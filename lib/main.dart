import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

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
      body: Playlist()
    );
  }
}


class Playlist extends StatefulWidget {

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<Color> paletteGeneratorColors = [
    Colors.black12,
    Colors.grey,
  ];

  void getImagePalette (ImageProvider image) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.
    fromImageProvider(image);
    setState((){
      this.paletteGeneratorColors = paletteGenerator.colors.take(2).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    getImagePalette(NetworkImage('https://i.scdn.co/image/ab67616d0000b273948ee25ce784ed4d532cc328'));
    return Container(
      width: 500,
      height: 720,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(35),
          bottomLeft: Radius.circular(35),
        ),
        gradient:  LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: paletteGeneratorColors,
        ),
      ),
      child: Column(
        children: [
          Container(
              width: 175,
              height: 175,
              margin: EdgeInsets.all(70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage('https://i.scdn.co/image/ab67616d0000b273948ee25ce784ed4d532cc328'),
                  )
              ),
            ),
        ],
      ),
    );
  }
}

