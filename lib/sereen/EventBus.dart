import 'dart:async';

class EventBus {
  // Create a StreamController
  final StreamController<String> _controller = StreamController<String>.broadcast();

  // Expose the stream to allow listening to the events
  Stream<String> get stream => _controller.stream;

  // Function to add events to the stream
  void emit(String event) {
    _controller.add(event);
  }

  // Dispose the controller when done
  void dispose() {
    _controller.close();
  }
}

// Create a singleton instance of EventBus
final EventBus eventBus = EventBus();
