import 'dart:async';

mixin Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (event, sink) {
      if (event.contains('@')) {
        sink.add(event);
      } else {
        sink.addError('Enter a valid Email!');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (event, sink) {
      if (event.length > 8) {
        sink.add(event);
      } else {
        sink.addError('Enter a valid password!');
      }
    },
  );
}
