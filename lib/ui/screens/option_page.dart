import 'package:flutter/material.dart';

class Option1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Option 1'),
      ),
      body: Center(
        child: Text('This is Option 1'),
      ),
    );
  }
}

class Option2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Option 2'),
      ),
      body: Center(
        child: Text('This is Option 2'),
      ),
    );
  }
}

class Option3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Option 3'),
      ),
      body: Center(
        child: Text('This is Option 3'),
      ),
    );
  }
}