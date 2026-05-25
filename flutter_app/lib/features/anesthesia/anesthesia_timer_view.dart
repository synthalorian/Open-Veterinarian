import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/anesthesia_timer_provider.dart';
import '../anesthesia/anesthesia_timer_model.dart';
import '../calculator/fluid_calculator.dart';
import '../theme/app_theme.dart';

class AnesthesiaTimerView extends ConsumerStatefulWidget {
  const AnesthesiaTimerView({super.key});

  @override
  ConsumerState<AnesthesiaTimerView> createState() => _AnesthesiaTimerViewState();
}

class _AnesthesiaTimerViewState extends ConsumerState<AnesthesiaTimerView> with SingleTickerProviderStateMixin {
  double mlPerHour = 0;
  int dripFactor = 15; // default 15 gtt/ml
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _updatePulse(double dropsPerMin) {
    if (dropsPerMin <= 0) {
      _pulseController.stop();
      return;
    }
    
    // Duration for 1 drop
    final intervalMs = (60 / dropsPerMin) * 1000;
    _pulseController.duration = Duration(milliseconds: intervalMs.round());
    if (!_pulseController.isAnimating) {
      _pulseController.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final state = ref.watch(anesthesiaTimerNotifierProvider);
    final notifier = ref.read(anesthesiaTimerNotifierProvider.notifier);
    
    final dropsPerMin = DripRateCalculator.calculateDropsPerMinute(mlPerHour: mlPerHour, dripFactor: dripFactor);
    _updatePulse(dropsPerMin);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anesthesia Timer'),
      ),
      body: Column(
        children: [
          _buildTimerDisplay(state, appColors),
          _buildControls(context, state, notifier, appColors),
          Divider(color: appColors.accent, thickness: 0.5),
          _buildFluidHud(dropsPerMin, appColors),
          Divider(color: appColors.accent, thickness: 0.5),
          _buildMilestoneList(state, appColors),
        ],
      ),
    );
  }

  Widget _buildFluidHud(double dropsPerMin, AppColors appColors) {
    final dropsPerSec = dropsPerMin > 0 ? 60 / dropsPerMin : 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: appColors.accent.withAlpha(12),
      child: Row(
        children: [
          // Posing Visual Drop
          ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.5).animate(
              CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
            ),
            child: Icon(Icons.water_drop, color: mlPerHour > 0 ? appColors.accent : appColors.textDim.withAlpha(51)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FLUID DRIP RATE HUD', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: appColors.accent)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'ml/hr', border: InputBorder.none, hintStyle: TextStyle(color: appColors.textDim)),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: appColors.accent.withAlpha(204)),
                        keyboardType: TextInputType.number,
                        onChanged: (val) => setState(() => mlPerHour = double.tryParse(val) ?? 0),
                      ),
                    ),
                    Text('ml/hr @ ', style: TextStyle(fontSize: 12, color: appColors.textDim)),
                    DropdownButton<int>(
                      value: dripFactor,
                      dropdownColor: appColors.surface,
                      underline: const SizedBox(),
                      items: [10, 15, 20, 60].map((f) => DropdownMenuItem(value: f, child: Text('$f gtt/ml', style: const TextStyle(fontSize: 12)))).toList(),
                      onChanged: (val) => setState(() => dripFactor = val!),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${dropsPerMin.toStringAsFixed(1)} gtt/min',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: appColors.accent),
              ),
              Text(
                dropsPerSec > 0 ? '1 drop every ${dropsPerSec.toStringAsFixed(1)}s' : '--',
                style: TextStyle(fontSize: 10, color: appColors.textDim),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerDisplay(AnesthesiaTimerState state, AppColors appColors) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(state.elapsedTime.inMinutes.remainder(60));
    final seconds = twoDigits(state.elapsedTime.inSeconds.remainder(60));
    final hours = twoDigits(state.elapsedTime.inHours);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: Text(
        '$hours:$minutes:$seconds',
        style: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: appColors.accent,
          fontFamily: 'monospace',
          shadows: [
            Shadow(color: appColors.accent, blurRadius: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context, AnesthesiaTimerState state, AnesthesiaTimerNotifier notifier, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton.filled(
            icon: Icon(state.isRunning ? Icons.pause : Icons.play_arrow),
            onPressed: state.isRunning ? notifier.stop : notifier.start,
            style: IconButton.styleFrom(
              backgroundColor: state.isRunning ? appColors.warning : appColors.accent,
              foregroundColor: appColors.surface,
              minimumSize: const Size(60, 60),
            ),
          ),
          IconButton.filled(
            icon: const Icon(Icons.refresh),
            onPressed: notifier.reset,
            style: IconButton.styleFrom(
              backgroundColor: appColors.danger,
              foregroundColor: appColors.surface,
              minimumSize: const Size(60, 60),
            ),
          ),
          IconButton.filled(
            icon: const Icon(Icons.bookmark_add),
            onPressed: state.isRunning ? () => _showMilestoneDialog(context, notifier) : null,
            style: IconButton.styleFrom(
              backgroundColor: appColors.accent,
              foregroundColor: appColors.surface,
              minimumSize: const Size(60, 60),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneList(AnesthesiaTimerState state, AppColors appColors) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.milestones.length,
        itemBuilder: (context, index) {
          final event = state.milestones[index];
          String twoDigits(int n) => n.toString().padLeft(2, '0');
          final time = '${twoDigits(event.timestamp.inHours)}:${twoDigits(event.timestamp.inMinutes.remainder(60))}:${twoDigits(event.timestamp.inSeconds.remainder(60))}';
          
          return ListTile(
            leading: Icon(Icons.circle, size: 8, color: appColors.accent),
            title: Text(event.label, style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(time, style: TextStyle(fontFamily: 'monospace', color: appColors.textDim)),
          );
        },
      ),
    );
  }

  void _showMilestoneDialog(BuildContext context, AnesthesiaTimerNotifier notifier) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: appColors.surface,
        title: Text('Mark Milestone', style: TextStyle(color: appColors.accent)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: TextStyle(color: appColors.accent.withAlpha(204)),
          decoration: InputDecoration(hintText: 'e.g., Surgery Start, Intubation', hintStyle: TextStyle(color: appColors.textDim)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('CANCEL', style: TextStyle(color: appColors.textDim))),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                notifier.markMilestone(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('MARK'),
          ),
        ],
      ),
    );
  }
}
