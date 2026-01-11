import 'package:flutter/material.dart';
import 'package:login_stateful/src/bloc/bloc.dart';
import 'package:login_stateful/src/screens/login_screen.dart';
import 'bloc/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  //function build overrides build from stateless widget
  //context is a Build instance inherited from stateless widget also
  @override
  Widget build(context) {
    return Provider(
      bloc: Bloc(),
      child: MaterialApp(
        title: "Log me in!",
        home: Scaffold(body: LoginScreen()),
      ),
    );
  }
}
