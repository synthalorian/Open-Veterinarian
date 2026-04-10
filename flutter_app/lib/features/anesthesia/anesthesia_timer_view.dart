import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/anesthesia_timer_provider.dart';
import '../anesthesia/anesthesia_timer_model.dart';
import '../calculator/fluid_calculator.dart';

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
          _buildTimerDisplay(state),
          _buildControls(context, state, notifier),
          const Divider(color: Colors.cyanAccent, thickness: 0.5),
          _buildFluidHud(dropsPerMin),
          const Divider(color: Colors.cyanAccent, thickness: 0.5),
          _buildMilestoneList(state),
        ],
      ),
    );
  }

  Widget _buildFluidHud(double dropsPerMin) {
    final dropsPerSec = dropsPerMin > 0 ? 60 / dropsPerMin : 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.cyan.withValues(alpha: 0.05),
      child: Row(
        children: [
          // Posing Visual Drop
          ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.5).animate(
              CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
            ),
            child: Icon(Icons.water_drop, color: mlPerHour > 0 ? Colors.cyanAccent : Colors.white10),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('FLUID DRIP RATE HUD', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.cyanAccent)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'ml/hr', border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey)),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        keyboardType: TextInputType.number,
                        onChanged: (val) => setState(() => mlPerHour = double.tryParse(val) ?? 0),
                      ),
                    ),
                    const Text('ml/hr @ ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    DropdownButton<int>(
                      value: dripFactor,
                      dropdownColor: Colors.black,
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
              ),
              Text(
                dropsPerSec > 0 ? '1 drop every ${dropsPerSec.toStringAsFixed(1)}s' : '--',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerDisplay(AnesthesiaTimerState state) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(state.elapsedTime.inMinutes.remainder(60));
    final seconds = twoDigits(state.elapsedTime.inSeconds.remainder(60));
    final hours = twoDigits(state.elapsedTime.inHours);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: Text(
        '$hours:$minutes:$seconds',
        style: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.cyanAccent,
          fontFamily: 'monospace',
          shadows: [
            Shadow(color: Colors.cyanAccent, blurRadius: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context, AnesthesiaTimerState state, AnesthesiaTimerNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton.filled(
            icon: Icon(state.isRunning ? Icons.pause : Icons.play_arrow),
            onPressed: state.isRunning ? notifier.stop : notifier.start,
            style: IconButton.styleFrom(
              backgroundColor: state.isRunning ? Colors.orangeAccent : Colors.cyanAccent,
              foregroundColor: Colors.black,
              minimumSize: const Size(60, 60),
            ),
          ),
          IconButton.filled(
            icon: const Icon(Icons.refresh),
            onPressed: notifier.reset,
            style: IconButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.black,
              minimumSize: const Size(60, 60),
            ),
          ),
          IconButton.filled(
            icon: const Icon(Icons.bookmark_add),
            onPressed: state.isRunning ? () => _showMilestoneDialog(context, notifier) : null,
            style: IconButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              foregroundColor: Colors.black,
              minimumSize: const Size(60, 60),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneList(AnesthesiaTimerState state) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.milestones.length,
        itemBuilder: (context, index) {
          final event = state.milestones[index];
          String twoDigits(int n) => n.toString().padLeft(2, '0');
          final time = '${twoDigits(event.timestamp.inHours)}:${twoDigits(event.timestamp.inMinutes.remainder(60))}:${twoDigits(event.timestamp.inSeconds.remainder(60))}';
          
          return ListTile(
            leading: const Icon(Icons.circle, size: 8, color: Colors.cyanAccent),
            title: Text(event.label, style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(time, style: const TextStyle(fontFamily: 'monospace', color: Colors.grey)),
          );
        },
      ),
    );
  }

  void _showMilestoneDialog(BuildContext context, AnesthesiaTimerNotifier notifier) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Mark Milestone', style: TextStyle(color: Colors.cyanAccent)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: 'e.g., Surgery Start, Intubation', hintStyle: TextStyle(color: Colors.grey)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.grey))),
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
