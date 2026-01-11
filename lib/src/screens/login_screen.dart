import 'package:flutter/material.dart';
import 'package:login_stateful/src/bloc/bloc.dart';
import '../mixins/validations_mixins.dart';

class LoginScreen extends StatefulWidget {
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
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email,
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

  Widget passwordField() {
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

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        //reset -> clear the form
        //print(formKey.currentState?.validate());
        if (formKey.currentState?.validate() ?? false) {
          formKey.currentState?.save();
          print("Email and password posted successfully!");
          //if the form is valid, save the values
          //this one only works in scaffold
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text("Form submitted successfully!")),
          // );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      child: Text("Submit"),
    );
  }
}
