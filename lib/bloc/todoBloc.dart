import 'package:rxdart/rxdart.dart';
import 'package:todos/apiProvider.dart';
import 'package:todos/model/todoModel.dart';

class TodoBloc {
  TodoBloc() {
    fetchProducts();
  }

  final _todo = PublishSubject<List<Todos>>();

  //getters to stream.
  Stream<List<Todos>> get todos => _todo.stream;

  fetchProducts() async {
    final products = await TodoApi().fetchProducts();
    _todo.sink.add(products);
  }

  dispose() {
    _todo.close();
  }
}
