import 'package:http/http.dart' as http;

abstract class AbstractApi {

  final urlLocalHost = "http://localhost:3000";

  final String _recurso;

  AbstractApi(this._recurso);

  Future <String> getAll() async {
    var response = await http.get(Uri.parse("$urlLocalHost/$_recurso"));
    return response.body;
  }
}