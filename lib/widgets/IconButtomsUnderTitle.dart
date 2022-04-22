import 'package:flutter/material.dart';


class ButtomIcons extends StatefulWidget {
  final firstGradientColor;
  final secondGradientColor;
  final textFieldController;
  Function changeSpotifyLink;

  ButtomIcons(
      this.firstGradientColor,
      this.secondGradientColor,
      this.textFieldController,
      this.changeSpotifyLink);

  @override
  State<ButtomIcons> createState() => _ButtomIconsState();
}

class _ButtomIconsState extends State<ButtomIcons> {

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: widget.secondGradientColor,
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
                fillColor: widget.firstGradientColor,
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
        });
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
              color: widget.firstGradientColor),
            onPressed: (){},
          ),
          RawMaterialButton(
            shape: CircleBorder(),
            child: Icon(
              Icons.refresh_sharp,
              color:  widget.firstGradientColor),
            onPressed: ()async => _showTextInputDialog(context),
          ),
        ],
      ),
    );
  }
}
