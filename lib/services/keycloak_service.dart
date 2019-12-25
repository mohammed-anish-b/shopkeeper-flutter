import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shopkeeper/configs/keycloak_auth_config.dart';

class KeycloakService {

  static Map<String, String> tokenHeaders;
  static KeycloakAuthConfig kCAuthConfig = KeycloakAuthConfig();

  static login(String username, String password) {
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
        };
      dynamic response = await http.post(
        'https://dev.servers.divisosofttech.com/auth/admin/realms/graeshoppe/users',
        headers: headers,
        body: json.encode(body)
        );
      print('Response Body    '+response.status);
      print('Response Body    '+response.body);
    });
  }
}