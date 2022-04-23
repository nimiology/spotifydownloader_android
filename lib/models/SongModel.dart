import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SongDownload{
  String id;

  int? idRequest;
  SongDownload(this.id);

  Future download() async{
    int trying = 0;
    http.Response response = await http.get(Uri.parse('http://spotifydownloadernima0.herokuapp.com/${id}'));
    var request = json.decode(response.body);
    idRequest = request['id'];
    if (!request['isDownloaded']){print(request['isDownloaded']);}

    while (!request['isDownloaded'] && !request['failed']) {
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
    if (request['isDownloaded']) {
      final url = 'https://spotifydownloadernima0.herokuapp.com${request["slug"]}';
    if (await canLaunch(url)) {
      await launch(url);
    } else
      // can't launch url, there is some error
      throw "Could not launch $url";
    }
  }
}