import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotifydownloader_flutter/widgets/CoverArt.dart';
import 'package:spotifydownloader_flutter/widgets/IconButtomsUnderTitle.dart';
import 'package:spotify/spotify.dart';


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

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Playlist(),
    );
  }
}


class Playlist extends StatefulWidget {

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  ImageProvider imageAlbum = AssetImage('assets/images/default_artwork.png');
  String title = 'Title';
  String owner = '';


  List<Color> paletteGeneratorColors = [
    Colors.black,
    Colors.grey,
  ];

  TextEditingController _textFieldController = TextEditingController();


  void getImagePalette () async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.
    fromImageProvider(imageAlbum);
    setState((){
      this.paletteGeneratorColors = paletteGenerator.colors.take(2).toList();
    });
  }

  Future<Track> getTrack(spotifyLink) async{
    var track = await spotify.tracks.get(spotifyLink);
    return track;
  }

  void changeSpotifyLink(link){

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
              paletteGeneratorColors[1],
              _textFieldController,
              changeSpotifyLink
          ),

        ],
      ),
    );
  }
}

