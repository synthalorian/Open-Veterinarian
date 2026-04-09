import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/anesthesia/anesthesia_timer_model.dart';

part 'anesthesia_timer_provider.g.dart';

@riverpod
class AnesthesiaTimerNotifier extends _$AnesthesiaTimerNotifier {
  Timer? _timer;

  @override
  AnesthesiaTimerState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return AnesthesiaTimerState();
  }

  void start() {
    if (state.isRunning) return;
    
    state = state.copyWith(isRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(elapsedTime: state.elapsedTime + const Duration(seconds: 1));
    });
    
    _addMilestone('Anesthesia Start');
  }

  void stop() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
    _addMilestone('Anesthesia Stop');
  }

  void reset() {
    _timer?.cancel();
    state = AnesthesiaTimerState();
  }

  void markMilestone(String label) {
    if (!state.isRunning) return;
    _addMilestone(label);
  }

  void _addMilestone(String label) {
    final milestone = TimerEvent(label: label, timestamp: state.elapsedTime);
    state = state.copyWith(milestones: [...state.milestones, milestone]);
  }
}
