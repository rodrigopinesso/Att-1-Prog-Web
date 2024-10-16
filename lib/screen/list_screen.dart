import 'dart:convert';
import 'package:flutter/material.dart';
import '../service/transacao.dart';
import 'form_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  TransacaoService _transacaoService = TransacaoService();
  List _transacoes = [];

  void _fetchTransacoes() async {
    var response = await _transacaoService.getAll();
    setState(() {
      _transacoes = json.decode(response);
    });
  }

  void _deleteTransacao(String id) async {
    await _transacaoService.deleteTransacao(id);
    _fetchTransacoes();
  }

  @override
  void initState() {
    super.initState();
    _fetchTransacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transações')),
      body: ListView.builder(
        itemCount: _transacoes.length,
        itemBuilder: (context, index) {
          var transacao = _transacoes[index];
          return ListTile(
            title: Text(transacao['nome']),
            subtitle: Text('Valor: ${transacao['valor']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(
                          id: transacao['id'],
                          nome: transacao['nome'],
                          valor: double.tryParse(transacao['valor'].toString()),
                        ),
                      ),
                    ).then((_) => _fetchTransacoes());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTransacao(transacao['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          ).then((_) => _fetchTransacoes());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
