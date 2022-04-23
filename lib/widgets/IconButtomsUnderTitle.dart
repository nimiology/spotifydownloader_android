import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../models/SongModel.dart';


class ButtomIcons extends StatefulWidget {
  final t;
  final textFieldController;
  Function changeSpotifyLink;
  List songs;

  ButtomIcons(
      this.t,
      this.textFieldController,
      this.changeSpotifyLink,
      this.songs);

  @override
  State<ButtomIcons> createState() => _ButtomIconsState();
}

class _ButtomIconsState extends State<ButtomIcons> {
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

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.green,
                title: Container(
                  padding: EdgeInsets.all(0),
                  child: const Text('Spotify Link',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                content: TextField(
                  controller: widget.textFieldController,
                  decoration: const InputDecoration(
                    hintText: "Enter the link",
                    hintStyle:TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                actions: <Widget>[
                  RawMaterialButton(
                    fillColor: Colors.black,
                    child: const Text('OK', style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                    ),
                    onPressed: () {
                      Navigator.pop(context,  widget.textFieldController.text);
                      widget.changeSpotifyLink(widget.textFieldController.text);
                    },
                  ),
                ],
              );
        })
    ;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RawMaterialButton(
            shape: CircleBorder(),
            child: Icon(
              Icons.download_sharp,
              color: Colors.green,),
            onPressed: ()async{
              for (Map track in widget.songs){
                print(track['title']);
                await SongDownload(track['id']).download(downloadCallback);
              }
            },
          ),
          RawMaterialButton(
            shape: CircleBorder(),
            child: Icon(
              Icons.refresh_sharp,
              color:  Colors.green,),
            onPressed: ()async => _showTextInputDialog(context),
          ),
        ],
      ),
    );
  }
}
