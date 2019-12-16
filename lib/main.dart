import 'package:app_10_fluttertube/app/blocs/favorites_bloc.dart';
import 'package:app_10_fluttertube/app/blocs/video_search_bloc.dart';
import 'package:app_10_fluttertube/app/screens/home_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideoSearchBloc()),
        Bloc((i) => FavoritesBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
