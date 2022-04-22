import 'package:spotify/spotify.dart';


var credentials = SpotifyApiCredentials('a145db3dcd564b9592dacf10649e4ed5',
    '389614e1ec874f17b8c99511c7baa2f6');
var spotify = SpotifyApi(credentials);

void main(){
  String asd= 'https://open.spotify.com/track/4mPBx3plCRVI9DGT9KSmQs?si=2d78914ae0dd448a';
  String result = asd.substring(31);
  print(result);
}