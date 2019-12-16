import 'dart:async';

import 'package:app_10_fluttertube/api.dart';
import 'package:app_10_fluttertube/app/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class VideoSearchBloc implements BlocBase{

  List<Video> videos = [];
  API api = API();

  final _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideoSearchBloc(){
    _searchController.stream.listen(_search);
  }

  _search(query) async{
    if(query == null && videos.isEmpty) return;
    if(query == null){
      videos += await api.next();
    }else{
      _videosController.add([]);
      videos = await api.search(search: query);
    }
    _videosController.add(videos);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
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