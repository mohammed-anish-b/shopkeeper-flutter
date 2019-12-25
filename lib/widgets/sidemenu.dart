import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Shopkeeper'),
              accountEmail: Text('shopkeeper@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text("P"),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/product');
              },
            ),
            ListTile(
              leading: Icon(Icons.format_align_justify),
              title: Text('Category'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('SignUp'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
            ),
          ],
        ),
      );
  }
}