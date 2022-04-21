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
  String imageAlbum = 'https://i.scdn.co/image/ab67616d0000b273a3eff72f62782fb589a492f9';
  List Songs = [
    {
      'title': 'Alone Again',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Too Late',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Hardest To Love',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Scared To Live',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Snowchild',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Escape from LA',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Heartless',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Faith',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Blinding Lights',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'In Your Eyes',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Save Your Tears',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Repeat After Me (Interlude)',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'After Hours',
      'artists' : ['The Weeknd']
    },
    {
      'title': 'Until I Bleed Out',
      'artists' : ['The Weeknd']
    },
  ];

  List<Color> paletteGeneratorColors = [
    Colors.black,
    Colors.grey,
  ];

  TextEditingController _textFieldController = TextEditingController();

  void getImagePalette (ImageProvider image) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.
    fromImageProvider(image);
    setState((){
      this.paletteGeneratorColors = paletteGenerator.colors.take(2).toList();
    });
  }

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: paletteGeneratorColors[1],
            title: Container(
              padding: EdgeInsets.all(0),
              child: const Text('Spotify Link',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            content: TextField(
              controller: _textFieldController,
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
                fillColor: paletteGeneratorColors[0],
                child: const Text('OK', style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
                ),
                ),
                onPressed: () => Navigator.pop(context, _textFieldController.text),
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    getImagePalette(NetworkImage(imageAlbum));
    return Container(
      width: 500,
      height: double.infinity,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(
        //   bottomRight: Radius.circular(35),
        //   bottomLeft: Radius.circular(35),
        // ),
        gradient:  LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: paletteGeneratorColors,
        ),
      ),
      child: Column(
        children: [
          Container(
              width: 220,
              height: 220,
              margin: EdgeInsets.fromLTRB(0, 60, 0, 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(imageAlbum),
                  )
              ),
            ),
          Container(
              child: Text(
                'After Hours',
                style: Theme.of(context).textTheme.titleLarge,)
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 2.5, 0, 20),
            child: Text(
              'The Weeknd',
              style: TextStyle(
                  color: Colors.grey
              )
            )
          ),
          Container(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RawMaterialButton(
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.download_sharp,
                    color: paletteGeneratorColors[0],),
                  onPressed: (){},
                ),
                RawMaterialButton(
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.refresh_sharp,
                    color: paletteGeneratorColors[0],),
                  onPressed: ()async => _showTextInputDialog(context),
                ),
              ],
            ),
          ),
          Container(
            width: 390,
            height: 460,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: Songs.length,
                itemBuilder: (ctx, index){
                  String artists = '';
                  for(int i=0; i<Songs[index]['artists'].length; i++){
                    artists += Songs[index]['artists'][i];
                    if (i+1!=Songs[index]['artists'].length){
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
                      onTap: (){},
                      title: Text(
                        Songs[index]['title'],
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
          ),
        ],
      ),
    );
  }
}

