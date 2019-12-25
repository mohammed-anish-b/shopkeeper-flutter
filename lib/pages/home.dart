import 'package:flutter/material.dart';
import 'package:shopkeeper/widgets/sidemenu.dart';

class Home extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true
      ),
      drawer: Menu(),
    );
  }
}