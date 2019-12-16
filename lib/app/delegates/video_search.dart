import 'package:app_10_fluttertube/api.dart';
import 'package:flutter/material.dart';

class VideoSearch extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_)=>close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty) return Container();
    return FutureBuilder(
      future: API().suggestions(query),
      builder: (context, snapshot){
        if(snapshot.hasData){
          List list = [];
          list.add(query);
          list.addAll(snapshot.data);
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(list[index]),
                leading: Icon(Icons.play_arrow),
                onTap: (){
                  close(context, list[index]);
                },
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }



}