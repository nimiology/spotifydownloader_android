import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../models/SongModel.dart';

class SongsList extends StatefulWidget {
  final Songs;
  SongsList(this.Songs);

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }
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
                    onTap: (){SongDownload(widget.Songs[index]['id']).download(downloadCallback);},
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
