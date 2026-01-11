import 'dart:async';
import 'package:login_stateful/src/mixins/validations_mixins.dart';

class Bloc extends Object with Validators {
  final _email = StreamController<String>();
  final _password = StreamController<String>();

  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _email.close();
    _password.close();
  }
}

//singleton instance
//it is better to use scoped instances with big projects
final bloc = Bloc();
