
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shopkeeper/models/UOM.dart';
import 'package:shopkeeper/services/keycloak_service.dart';

class QueryService {

  
  String url = 'http://dev.ci1.divisosofttech.com:9080';

  Future<List<UOM>> findUOMByIdpCode(String idpcode) async {
    KeycloakService.login('spiceindia', 'spiceindia');
    dynamic response = await http.get(url+'/api/query/findUOMByIdpCode/$idpcode',headers: KeycloakService.tokenHeaders);
    Map page = jsonDecode(response.body);
    var list = page['content'] as List;
    List<UOM> uoms = list.map((i) => UOM.fromJSON(i)).toList();  
    return uoms;
  }
}