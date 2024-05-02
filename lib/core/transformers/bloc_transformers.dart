import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

/// Contains reusable event transformers commonly used in BLoC implementations.

/// Event transformer for debouncing events with a specified duration.
/// Explanation: Debouncing ensures that if multiple events are emitted rapidly,
/// only the last event within the specified duration will be processed. This is useful
/// for scenarios such as handling user input where you want to wait until the user
/// has stopped typing before triggering an action.
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

/// Event transformer for throttling events with a specified duration.
/// Explanation: Throttling limits the rate at which events are processed. Only the first
/// event emitted within the specified duration is processed, subsequent events are ignored.
/// This is useful for scenarios such as rate limiting API calls or preventing excessive UI updates.
EventTransformer<T> throttle<T>(Duration duration) {
  return (events, mapper) => events.throttleTime(duration).flatMap(mapper);
}

/// Event transformer for delaying events with a specified duration.
/// Explanation: Delays the emission of events by the specified duration. This is useful for
/// introducing a delay in processing events, for example, simulating a loading indicator or
/// delaying the execution of a particular action.
EventTransformer<T> delay<T>(Duration duration) {
  return (events, mapper) => events.delay(duration).flatMap(mapper);
}
