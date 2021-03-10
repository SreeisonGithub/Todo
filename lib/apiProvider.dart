import 'package:http/http.dart' show Client;
import 'package:todos/model/todoModel.dart';

class TodoApi {
  static Client client = Client();
  final String _root = 'https://jsonplaceholder.typicode.com/todos';

  fetchProducts() async {
    var response = await client.get(_root);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return todosFromJson(jsonString) ;
      //productsFromJson(jsonString);
    } else {
      return throw Exception('Failed to load data');
    }
  }
}
