import 'dart:async';
import 'package:login_stateful/src/mixins/validations_mixins.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  // final _email = StreamController<String>.broadcast();
  // final _password = StreamController<String>.broadcast();

  final _email = BehaviorSubject<String>();
  final _password =  BehaviorSubject<String>();


  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  //this is a validation-kind function that returns a bool indicating if it has an error or not
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print(validEmail);
    print(validPassword);
  }

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _email.close();
    _password.close();
  }
}

//singleton instance
//it is better to use scoped instances with big projects
//final bloc = Bloc();
