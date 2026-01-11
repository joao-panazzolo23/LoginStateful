import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
  final Bloc bloc = Bloc();

  Provider({super.key, bloc, required super.child});

  //returns a type within BuildContext three with the same type informed
  static Bloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.bloc;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) => false;
}
