import 'package:http/http.dart' as http;

class ApiServices {
  ///Fetch Data from Api
  Future<http.Response> fetchData(String _apiURL,Map<String,String> headers) async {
    http.Response response = await http.get(
      Uri.parse(_apiURL),
        headers: headers,
    );
   return response;
  }
}
