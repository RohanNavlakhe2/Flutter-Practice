import 'package:flutter/material.dart';


class VideoCell extends StatelessWidget {
  String imgurl;
  VideoCell(this.imgurl);
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 8.0,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
            onTap: () => {},
            child: Hero(
              tag: imgurl,
              child: FadeInImage(
                placeholder: AssetImage('images/bgtry.png'),
                image: NetworkImage(imgurl),
                fit: BoxFit.cover,
              ),
            )));
  }
}
