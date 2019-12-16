import 'dart:async';
import 'dart:convert';

import 'package:app_10_fluttertube/app/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesBloc implements BlocBase {
  Map<String, Video> videos = {};

  static const String _prefKey = "favorites";

  final _favController = BehaviorSubject<Map<String, Video>>();

  Stream get outFavorites => _favController.stream;

  FavoritesBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.containsKey(_prefKey))
        videos = json.decode(prefs.getString(_prefKey)).map((k,v){
          return MapEntry<String, Video>(k, Video.fromJson(v));
        }).cast<String, Video>();

        _favController.add(videos);
    });
  }

  toggleFavorite(Video video) {
    if (videos.containsKey(video.id))
      videos.remove(video.id);
    else
      videos[video.id] = video;
    _favController.add(videos);
    _saveFavorites();
  }

  bool isFavorite(Video video) {
    return videos.containsKey(video.id);
  }

  void _saveFavorites(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString(_prefKey, json.encode(videos));
    });
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _favController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }


}
