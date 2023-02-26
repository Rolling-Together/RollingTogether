import 'package:flutter/material.dart';

class PopularPostTile extends StatefulWidget {
  const PopularPostTile({Key? key}) : super(key: key);

  _PopularPostTileState createState() => _PopularPostTileState();
}

class _PopularPostTileState extends State<PopularPostTile>{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Container()
      ),
    );
  }
}
