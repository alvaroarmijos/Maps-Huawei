import 'package:http/http.dart' as http;

/// If you want to do a verification, you can use the link below
///
/// [idToken] the token received token from signed HUAWEI ID.
Future<void> performServerVerification(String idToken) async {
  var response = await http.post(
      "https://oauth-login.cloud.huawei.com/oauth2/v3/tokeninfo",
      body: {'id_token': idToken});
  print(response.body);
}
