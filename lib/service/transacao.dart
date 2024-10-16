import 'dart:convert';
import 'package:http/http.dart' as http;
import 'abstract_api.dart';

class TransacaoService extends AbstractApi {
  TransacaoService() : super('transacoes');

  Future<void> createTransacao(String nome, double valor) async {
    var response = await http.post(
      Uri.parse("$urlLocalHost/transacoes"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"nome": nome, "valor": valor}),
    );
    if (response.statusCode != 201) {
      throw Exception("Erro ao criar transação");
    }
  }

  Future<void> deleteTransacao(String id) async {
    var response = await http.delete(Uri.parse("$urlLocalHost/transacoes/$id"));
    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar transação");
    }
  }

  Future<void> updateTransacao(String id, String nome, double valor) async {
    var response = await http.put(
      Uri.parse("$urlLocalHost/transacoes/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"nome": nome, "valor": valor}),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar transação");
    }
  }
}
