import 'package:artivatic_task/bloc/home_bloc.dart';
import 'package:artivatic_task/ui/home.dart';
import 'package:artivatic_task/reposiotory/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Adding FetchHomeDateEvent to the Bloc initially
      home: BlocProvider(create: (_) => HomeBloc(HomeRepository())..add(FetchHomeDataEvent()),child: Home())
    );
  }
}


