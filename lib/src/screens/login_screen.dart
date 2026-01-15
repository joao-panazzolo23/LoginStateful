import 'package:flutter/material.dart';
import 'package:login_stateful/src/bloc/bloc.dart';
import 'package:login_stateful/src/bloc/provider.dart';
import '../mixins/validations_mixins.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

//with is a very important keyword in dart
//it allows you to use mixins
//mixins are like a class that can be used in multiple classes, but they don't have
//to be instantiated. They're used to add functionality to a class without using inheritance.
//in this case, we are using the ValidationsMixins mixin to add validation functionality
class LoginScreenState extends State<LoginScreen> with Validators {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(context) {
    final bloc = Provider.of(context);

    var child = [
      emailField(bloc),
      passwordField(bloc),
      Container(margin: EdgeInsets.only(top: 25.0)),
      submitButton(bloc),
    ];

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(children: child),
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: Provider.of(context).email,
      //this is anon func
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: bloc.changeEmail, //works as well
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email Address",
            hintText: "youremail@gmail.com",
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      //this is anon func
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: bloc.changePassword,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Insert your password...",
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    var style = ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    );

    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          //null makes button disabled
          //onPressed: snapshot.hasError ? login : null, reverse logic
          onPressed: snapshot.hasData ? bloc.submit : null,
          style: style,
          child: Text("Login"),
        );
      },
    );
  }
  //
  // void login() {
  //   if (formKey.currentState?.validate() ?? false) {
  //     formKey.currentState?.save();
  //     print("IT WORKS!!!");
  //   }
  // }
}
