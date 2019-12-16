import 'package:app_10_fluttertube/api.dart';
import 'package:app_10_fluttertube/app/blocs/favorites_bloc.dart';
import 'package:app_10_fluttertube/app/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.getBloc<FavoritesBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Favorites"),
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFavorites,
        builder: (ctx, snap){
          if(snap.hasData){
            var list = snap.data.values.toList();
            return ListView.separated(
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (ctx, idx){
                return Divider(height: 2, color: Colors.grey[800]);
              },
              itemBuilder: (ctx, idx){
                return ListTile(
                  onTap: (){
                    FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: list[idx].id);
                  },
                  onLongPress: (){
                    bloc.toggleFavorite(list[idx]);
                  },
                  leading: Container(
                    height: 80,
                    child: AspectRatio(
                      aspectRatio: 16.0/9.0,
                      child: Image.network(list[idx].thumb),
                    ),
                  ),
                  title: Text(list[idx].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize:16, color: Colors.white),
                  ),
                  subtitle: Text(list[idx].channel,
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
