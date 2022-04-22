import 'package:flutter/material.dart';

class CoverArt extends StatefulWidget {
  final coverArt;
  CoverArt(this.coverArt);

  @override
  State<CoverArt> createState() => _CoverArtState();
}

class _CoverArtState extends State<CoverArt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      margin: EdgeInsets.fromLTRB(0, 60, 0, 28),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: widget.coverArt,
          )
      ),
    );
  }
}
