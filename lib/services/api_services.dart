import 'package:baby_220fa3cd9a07183fa6e7d8f5082f21c4dcffa74f/model/product.dart';
import 'package:http/http.dart' show Client;
import 'package:query_params/query_params.dart';

class ApiService {
  final String baseUrl = "https://kulina-recruitment.herokuapp.com";
  Client client = Client();

  Future<List<ProductModel>> getAllProducts() async {
     Map<String, String> requestHeaders = {
       'Accept': 'application/json',
     };

    final response = await client.get(
      "$baseUrl/products/", 
      headers:requestHeaders
    );
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<ProductModel>> getProductWithQueryParam() async {
     Map<String, String> requestHeaders = {
       'Accept': 'application/json',
     };

    URLQueryParams queryParams = new URLQueryParams();  
    queryParams.append('_limit',"10");
    queryParams.append('_page',"1");

    String param = queryParams.toString();

    final response = await client.get(
      "$baseUrl/products/?$param", 
      headers:requestHeaders
    );
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      return null;
    }
  }
}
