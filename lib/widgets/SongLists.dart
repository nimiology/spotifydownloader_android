import 'package:flutter/material.dart';

import '../models/SongModel.dart';

class SongsList extends StatefulWidget {
  final Songs;
  SongsList(this.Songs);

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 390,
        height: 460,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount:   widget.Songs.length,
            itemBuilder: (ctx, index){
              String artists = '';
              for(int i=0; i<  widget.Songs[index]['artists'].length; i++){
                artists +=   widget.Songs[index]['artists'][i];
                if (i+1!=  widget.Songs[index]['artists'].length){
                  artists += ', ';
                }
              }
              return Card(
                elevation: 0,
                color: Colors.white.withOpacity(0.0),
                margin: EdgeInsets.symmetric(
                    vertical: 0, horizontal: 5
                ),
                child: ListTile(
                    onTap: SongDownload(widget.Songs[index]['id']).download,
                    title: Text(
                      widget.Songs[index]['title'],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(artists,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: Container(
                      child: Text((index+1).toString(),
                        style: TextStyle(fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5
                      ),
                    )
                ),
              );
            }
        )
    );
  }
}
