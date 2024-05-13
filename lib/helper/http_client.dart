import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/RFConstant.dart';

enum HttpMethod{
  get,
  post,
  put,
  delete,
  patch
}
class HttpClient{
  static dynamic _invoke({
    required String endPoint,
    required HttpMethod method,
    Map<String, dynamic>? query,
    bool decode = true,
    Map<String, dynamic>? body
  }) async{

    Uri uri = Uri.parse("$apiBaseUrl$endPoint").replace(queryParameters: query);
    Map<String, String> header = <String, String>{};
    var pref =  await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    if (token != null){
      header = {
        "Authorization": "Bearer $token"
      };
    }
    late http.Response response;
    switch (method){
      case HttpMethod.get:
        response = await http.get(uri, headers: header);
        break;
      case HttpMethod.post:
        header["Content-Type"] = "application/json; charset=UTF-8";
        response = await http.post(uri, headers: header, body: convert.jsonEncode(body));
        break;
      case HttpMethod.put:
        header["Content-Type"] = "application/json; charset=UTF-8";
        response = await http.put(uri, headers: header, body: convert.jsonEncode(body));
        break;
      case HttpMethod.delete:
        response = await http.delete(uri, headers: header, body: convert.jsonEncode(body));
        break;
      case HttpMethod.patch:
        header["Content-Type"] = "application/json; charset=UTF-8";
        response = await http.patch(uri, headers: header, body: convert.jsonEncode(body));
        break;
    }
    if([200, 201, 204].contains(response.statusCode) ){
      if(decode) {
        return convert.jsonDecode(response.body);
      }else{
        return response.body;
      }
    }
    else{
      throw HttpException("Server respond with ${response.statusCode} http code and body = ${response.body} ");
    }
  }

  static Future<dynamic> get({required endPoint, Map<String, dynamic>? query}){
    return _invoke(endPoint: endPoint, method: HttpMethod.get, query: query);
  }

  static Future<dynamic> post({required endPoint, Map<String, dynamic>? body, Map<String, dynamic>? query, bool decode=true}){
    return _invoke(endPoint: endPoint, method: HttpMethod.post, query: query, body: body, decode: decode);
  }

  static dynamic patch({required endPoint, Map<String, dynamic>? body, Map<String, dynamic>? query}){
    return _invoke(endPoint: endPoint, method: HttpMethod.patch, query: query, body: body);
  }
  static dynamic put({required endPoint, Map<String, dynamic>? body} ){
    return _invoke(endPoint: endPoint, method: HttpMethod.put, body: body);
  }
  static dynamic delete(endPoint, {Map<String, dynamic>? query, Map<String, dynamic>? body,}){
    return _invoke(endPoint: endPoint, method: HttpMethod.delete, query: query ,body: body);
  }

}