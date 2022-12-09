import 'package:http/http.dart';
import '../../models/api_service.dart';

class FetchDataHelper{

  ApiServices apiServices=ApiServices();

  /// Creating Fetch Data Method
  Future<Response> fetchData(String _apiUrl)async{
    Map<String,String>headers={
      "X-CMC_PRO_API_KEY": "5e0d005e-3f3d-4436-8c5b-e6dba4b6f334",
      "Accept": "application/json"};
    Response response=await apiServices.fetchData(_apiUrl=_apiUrl, headers);
    return response;
  }
}