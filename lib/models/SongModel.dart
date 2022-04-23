import 'dart:convert';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;

class SongDownload{
  String id;

  int? idRequest;
  SongDownload(this.id);

  Future download(callback) async{
    int trying = 0;
    http.Response response = await http.get(Uri.parse('http://spotifydownloadernima0.herokuapp.com/${id}'));
    var request = json.decode(response.body);
    idRequest = request['id'];
    if (!request['isDownloaded']){print(request['isDownloaded']);}

    while (!request['isDownloaded']) {
      print(request);
      if (trying <= 20) {
        await Future.delayed(Duration(seconds: 30));
        http.Response requestResponse = await http.get(Uri.parse(
            'https://spotifydownloadernima0.herokuapp.com/request/${idRequest}'));
        request = json.decode(requestResponse.body);
        trying++;
        print(trying);
      }else{
        break;
      }
    }
    if (!request['isDownloaded']) {
      final taskId = await FlutterDownloader.enqueue(
          url: 'https://spotifydownloadernima0.herokuapp.com${request["slug"]}',
          savedDir: '/storage/emulated/0/Music',
          showNotification: true,
          // show download progress in status bar (for Android)
          openFileFromNotification: true,
          // click on notification to open downloaded file (for Android)
          saveInPublicStorage: true
      );
      FlutterDownloader.registerCallback(
          callback); // callback is a top-level or static function
    }
  }
}