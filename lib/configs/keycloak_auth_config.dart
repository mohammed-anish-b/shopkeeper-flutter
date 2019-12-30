import 'dart:developer';

import 'package:oauth2/oauth2.dart' as oauth2;

class KeycloakAuthConfig {

  final authorizationEndpoint = Uri.parse('https://dev.servers.divisosofttech.com/auth/realms/graeshoppe/protocol/openid-connect/token');
  final identifier = "account";
  final secret = "d4f03412-cdad-45b0-9ccc-beddd8399ac5";
  final adminAuthorizationEndpoint = Uri.parse('https://dev.servers.divisosofttech.com/auth/realms/master/protocol/openid-connect/token');
  final adminIdentifier = 'admin-cli';
  final adminSecret = '46c38386-f577-4747-bcd4-922100638f23';
  final adminUsername = 'admin';
  final adminPassword = 'admin999';
  
  Future getAdminClient() async {
    log('getting credentials');
    try{
      return await oauth2.resourceOwnerPasswordGrant(
        adminAuthorizationEndpoint,
        adminUsername, adminPassword,
        identifier: adminIdentifier, secret: adminSecret);
    } catch (e) {
      log('errorrrrr');
      print(e);
    }
  }

  Future authenticate(String username, String password) async {
    try{
      return await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint, username, password,
        identifier: identifier, secret: secret);
    } catch (e) {
      print(e);
    }
  }

}