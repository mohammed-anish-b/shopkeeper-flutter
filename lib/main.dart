import 'package:flutter/material.dart';
import 'package:shopkeeper/pages/home.dart';
import 'package:shopkeeper/pages/product.dart';
import 'package:shopkeeper/pages/signup.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context) => Home(),
    '/product' : (context) => Product(),
    '/signup' : (context) => Signup()
  },
));