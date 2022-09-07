import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future<http.Response> getRequest({url}) async {
    return await http.get(Uri.parse(url));
  }
}
