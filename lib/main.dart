import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotifydownloader_flutter/widgets/CoverArt.dart';
import 'package:spotifydownloader_flutter/widgets/IconButtomsUnderTitle.dart';
import 'package:spotify/spotify.dart';
import 'package:spotifydownloader_flutter/widgets/SongLists.dart';


var credentials = SpotifyApiCredentials('a145db3dcd564b9592dacf10649e4ed5',
    '389614e1ec874f17b8c99511c7baa2f6');
var spotify = SpotifyApi(credentials);


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 22.5,
              color: Colors.white,
              fontWeight: FontWeight.w900
          ),
          titleMedium: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          titleSmall : TextStyle(
              color: Colors.grey,
          )
        ),
    ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Playlistt(),
    );
  }
}


class Playlistt extends StatefulWidget {

  @override
  State<Playlistt> createState() => _PlaylisttState();
}

class _PlaylisttState extends State<Playlistt> {
  ImageProvider imageAlbum = AssetImage('assets/images/default_artwork.png');
  String title = 'Title';
  String owner = '';
  List songs = [];


  List<Color> paletteGeneratorColors = [
    Colors.grey,
    Colors.black,
    Colors.black,

  ];

  TextEditingController _textFieldController = TextEditingController();


  void getImagePalette () async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.
    fromImageProvider(imageAlbum);
    setState((){
      this.paletteGeneratorColors = paletteGenerator.colors.take(2).toList();
    });
  }


  Future trackMapWithTrackSimple(TrackSimple track)async{
    Map trackMap = {};
    String? trackName = track.name;
    if (trackName != null){

      trackMap['title'] = trackName;
    }
    List<Artist>? ownerNames = track.artists;
    if (ownerNames != null){
      List artists = [];
      for(Artist artist in ownerNames){
        if (artist.name != null){
          artists.add(artist.name.toString());
        }
        trackMap['artists'] = artists;
        trackMap['id'] = track.id;
      }
    }
    return trackMap;
  }

  void changeSpotifyLink(String link){
    setState(() async{
      if (link.startsWith('https://open.spotify.com/track/')){
        Track track = await spotify.tracks.get(link.substring(31));
        String? imageUrl =track.album?.images?[1].url;
        if (imageUrl != null){this.imageAlbum = NetworkImage(imageUrl);}

        Map trackMap = {};
        String? trackName = track.name;
        if (trackName != null){
          this.title = trackName;
          trackMap['title'] = trackName;
        }
        List<Artist>? ownerNames = track.artists;
        if (ownerNames != null){
          print(ownerNames);
          List artists = [];
          for(Artist artist in ownerNames){
            if (artist.name != null){
              print(artist.name.toString());
              artists.add(artist.name.toString());
            }
            trackMap['artists'] = artists;
            trackMap['id'] = track.id;
          }
          if (ownerNames[0].name != null){
            owner = ownerNames[0].name.toString();
          }
        }

        songs = [trackMap];
      }

      else if (link.startsWith('https://open.spotify.com/album/')){
        List trackList = [];
        Album album = await spotify.albums.get(link.substring(31));
        var tracks = await spotify.albums.getTracks(album.id!).all();

        String? imageUrl = album.images?[1].url;
        String? title2 = album.name;
        List? artistalbum = album.artists;
        if (imageUrl != null){this.imageAlbum = NetworkImage(imageUrl);}
        if (title2 != null){this.title = title2;}
        if (artistalbum != null){
          String artists = '';
          for(int i=0; i<  artistalbum.length; i++){
            artists += artistalbum[i].name;
            if (i+1!=  artistalbum.length){
              artists += ', ';
            }
        }
          owner = artists;
        }

        if (tracks != null){
          for (TrackSimple track in tracks) {
            Map trackMap = {};
            String? trackName = track.name;
            if (trackName != null){

              trackMap['title'] = trackName;
            }
            List<Artist>? ownerNames = track.artists;
            if (ownerNames != null){
              List artists = [];
              for(Artist artist in ownerNames){
                if (artist.name != null){
                  artists.add(artist.name.toString());
                }
                trackMap['artists'] = artists;
                trackMap['id'] = track.id;
              }
            }
            trackList.add(trackMap);
          }
        }
        songs = trackList;
      }

      else if (link.startsWith('https://open.spotify.com/playlist/')){
        List trackList = [];
        Playlist playlist = await spotify.playlists.get(link.substring(34));
        Iterable tracks = await spotify.playlists.getTracksByPlaylistId(playlist.id).all();

        String? title2 = playlist.name;
        String? imageUrl = playlist.images?[0].url;
        if (imageUrl != null){this.imageAlbum = NetworkImage(imageUrl);}
        if (title2 != null){this.title = title2;}
        owner = '';
        if (tracks != null){
          for (TrackSimple track in tracks) {
            Map trackMap = {};
            String? trackName = track.name;
            if (trackName != null){

              trackMap['title'] = trackName;
            }
            List<Artist>? ownerNames = track.artists;
            if (ownerNames != null){
              List artists = [];
              for(Artist artist in ownerNames){
                if (artist.name != null){
                  artists.add(artist.name.toString());
                }
                trackMap['artists'] = artists;
                trackMap['id'] = track.id;
              }
            }
            trackList.add(trackMap);
          }
        }
        songs = trackList;
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    getImagePalette();
    return Container(
      width: 500,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: paletteGeneratorColors,
        ),
      ),
      child: Column(
        children: [
          CoverArt(imageAlbum),
          Container(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,)
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 2.5, 0, 20),
            child: Text(
              owner,
              style: TextStyle(
                  color: Colors.grey
              )
            )
          ),
          ButtomIcons(
            paletteGeneratorColors[0],
            _textFieldController,
            changeSpotifyLink,
            songs
          ),
          SongsList(songs),
        ],
      ),
    );
  }
}

