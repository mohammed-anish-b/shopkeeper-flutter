import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopkeeper/services/keycloak_service.dart';
import 'package:shopkeeper/services/query_service.dart';
import 'package:shopkeeper/widgets/sidemenu.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {

  @override
  void initState() {
    super.initState();
    print('getting');
    KeycloakService.login('spiceindia', 'spiceindia');
    QueryService().findUOMByIdpCode('spiceindia').then((uoms) {
      uoms.forEach((uom){
        print(uom.unit);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
      ),
      drawer: Menu(),
    );
  }
}