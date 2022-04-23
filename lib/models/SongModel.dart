import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class SongDownload{
  String id;

  int? idRequest;
  SongDownload(this.id);
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading(String url, String fileSlug) async {
    String path = await _getFilePath(fileSlug.substring(7));

    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
      },
      deleteOnError: true,
    ).then((_) {});
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    print("/storage/emulated/0/Music/$filename");
    return "/storage/emulated/0/Music/$filename";
  }

  Future download() async{
    int trying = 0;
    http.Response response = await http.get(Uri.parse('http://spotifydownloadernima0.herokuapp.com/${id}'));
    var request = json.decode(response.body);
    print(request);
    idRequest = request['id'];
    if (!request['isDownloaded']){print(request['isDownloaded']);}
    print(request);

    while (!request['isDownloaded']) {
      print(request);
      if (trying <= 10) {
        await Future.delayed(Duration(minutes: 1));
        http.Response requestResponse = await http.get(Uri.parse(
            'https://spotifydownloadernima0.herokuapp.com/request/${idRequest}'));
        request = json.decode(requestResponse.body);
        trying++;
        print(trying);
      }else{
        break;
      }
    }
    startDownloading('https://spotifydownloadernima0.herokuapp.com${request["slug"]}', request["slug"]);
    print('done2');

  }
  }