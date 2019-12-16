import 'package:app_10_fluttertube/api.dart';
import 'package:app_10_fluttertube/app/blocs/favorites_bloc.dart';
import 'package:app_10_fluttertube/app/blocs/video_search_bloc.dart';
import 'package:app_10_fluttertube/app/delegates/video_search.dart';
import 'package:app_10_fluttertube/app/models/video.dart';
import 'package:app_10_fluttertube/app/screens/favorites_screen.dart';
import 'package:app_10_fluttertube/app/widgets/favorite_icon_button.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          height: 40,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: BlocProvider.getBloc<FavoritesBloc>().outFavorites,
              builder: (ctx, snap){
                if(snap.hasData){
                  return Text("${snap.data.length}");
                }
                return Text("0");
              },
            ),
          ),
          IconButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => FavoritesScreen()
                )
              );
            },
            icon: Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              String result = await showSearch(context: context, delegate: VideoSearch());
              BlocProvider.getBloc<VideoSearchBloc>().inSearch.add(result);
            },
            icon: Icon(Icons.search),
          )
        ],

      ),
      body: Container(
        color: Colors.black,
        child: StreamBuilder(
          stream: BlocProvider.getBloc<VideoSearchBloc>().outVideos,
          builder: (context, snapshot){
            if(snapshot.hasData){
              List<Video> list = snapshot.data;
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, i){
                    return Divider(height: 2, color: Colors.grey);
                  },
                  itemCount: list.length + 1,
                  itemBuilder: (context, index){
                    if((index + 3) > list.length && list.length > 5){
                      BlocProvider.getBloc<VideoSearchBloc>().inSearch.add(null);
                    }
                    if(index == list.length)
                      return Center(child: CircularProgressIndicator());
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: list[index].id);
                          },
                          child: AspectRatio(
                            aspectRatio: 16.0/9.0,
                            child: Image.network(list[index].thumb, fit: BoxFit.cover),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(list[index].title,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize:18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(list[index].channel, style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                            ),
                            FavoriteIconButton(list[index])
                          ],
                        ),
                        SizedBox(height: 16)
                      ],
                    );
                  }
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),

    );
  }
}
