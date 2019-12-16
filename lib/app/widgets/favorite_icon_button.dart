import 'package:app_10_fluttertube/app/blocs/favorites_bloc.dart';
import 'package:app_10_fluttertube/app/models/video.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {

  Video video;


  FavoriteIconButton(this.video);

  @override
  Widget build(BuildContext context) {

    final favBloc = BlocProvider.getBloc<FavoritesBloc>();


    return StreamBuilder<Map<String,Video>>(
      stream: favBloc.outFavorites,
      initialData: {},
      builder: (ctx, snap){
        if(snap.hasData){
          var starIcon = snap.data.containsKey(video.id) ? Icons.star : Icons.star_border;
          return IconButton(
              icon: Icon(starIcon),
              color: Colors.yellow,
              iconSize: 30,
              onPressed: (){
                favBloc.toggleFavorite(video);
              }
          );
        }
        return Container(width: 35, height: 35,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
