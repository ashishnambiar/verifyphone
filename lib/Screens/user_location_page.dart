import 'package:flutter/material.dart';

class UserLocationPage extends StatelessWidget {
  static const String route = '/UserLocationPage';
  const UserLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('User Location'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('user location'),
      ),
    );
  }
}
