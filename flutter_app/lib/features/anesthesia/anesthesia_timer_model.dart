import 'package:flutter/foundation.dart';

@immutable
class TimerEvent {
  final String label;
  final Duration timestamp;

  const TimerEvent({required this.label, required this.timestamp});
}

class AnesthesiaTimerState {
  final bool isRunning;
  final Duration elapsedTime;
  final List<TimerEvent> milestones;

  AnesthesiaTimerState({
    this.isRunning = false,
    this.elapsedTime = Duration.zero,
    this.milestones = const [],
  });

  AnesthesiaTimerState copyWith({
    bool? isRunning,
    Duration? elapsedTime,
    List<TimerEvent>? milestones,
  }) {
    return AnesthesiaTimerState(
      isRunning: isRunning ?? this.isRunning,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      milestones: milestones ?? this.milestones,
    );
  }
}
