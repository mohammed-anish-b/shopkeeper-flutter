import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shopkeeper/configs/keycloak_auth_config.dart';

class KeycloakService {

  KeycloakService._privateConstructor();

  static final KeycloakService _instance = KeycloakService._privateConstructor();

  factory KeycloakService(){
    return _instance;
  }

  Map<String, String> tokenHeaders;
  KeycloakAuthConfig kCAuthConfig = KeycloakAuthConfig();

  login(String username, String password) {
    kCAuthConfig.authenticate(username, password).then((result) {
      Map res = jsonDecode(result.credentials.toJson());
      tokenHeaders = {'authorization' : 'Bearer ' + res['accessToken']};
    });
  }

  createUser(String username , String email , String password) {

    String authorization;

    kCAuthConfig.getAdminClient().then((data) async {
      Map res = jsonDecode(data.credentials.toJson());
      authorization = res['accessToken'];
      Map<String, String> headers = {
        'authorization' : 'Bearer ' + authorization,
        "Content-Type": "application/json"
        };
      Map<String, dynamic> body = {
        'username' : username,
        'email' : email,
        'enabled' : 'true',
        'credentials' : [
          {
            'type':'password',
            'value' : password,
            'temporary' : false
            }
          ],
          'clientRoles' : {
            'realm-management' : [
              'shopkeeper'
            ]
          }
        };
      await http.post(
        'https://dev.servers.divisosofttech.com/auth/admin/realms/graeshoppe/users',
        headers: headers,
        body: json.encode(body)
        );
        getUserInfo(username, headers).then((res) {
          roleMapping(res[0]['id'],headers).then((res) {});
        });
    });
  }

  Future getUserInfo(username,header) async {
    dynamic response = await http.get('https://dev.servers.divisosofttech.com/auth/admin/realms/graeshoppe/users/?username=$username',headers: header);
    List page = jsonDecode(response.body);
    return page;
  }

  Future roleMapping(String id,header) async {
    var body = jsonEncode(
      [
        {
          "id":"12a7fbcf-3976-4c3d-92aa-c393b2b5be64",
          "name":"shopkeeper"
        }
      ]);
    await http.post('https://dev.servers.divisosofttech.com/auth/admin/realms/graeshoppe/users/$id/role-mappings/realm',headers: header,body: body);
  }
}
