import 'package:api_request/bloc/dog_bloc.dart';
import 'package:api_request/bloc/dog_event.dart';
import 'package:api_request/screen/dog_screen.dart';
import 'package:api_request/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Dogs App',
      home: BlocProvider(
        create: (context) => DogBloc()..add(FetchDogEvent()),
        child: HomeScreen(),
      ),
    );
  }
}
