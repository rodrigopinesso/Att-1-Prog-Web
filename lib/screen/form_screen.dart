import 'package:flutter/material.dart';
import '../service/transacao.dart';

class FormScreen extends StatefulWidget {
  final String? id;
  final String? nome;
  final double? valor;

  const FormScreen({this.id, this.nome, this.valor, Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _nome;
  double? _valor;
  TransacaoService _transacaoService = TransacaoService();

  @override
  void initState() {
    super.initState();
    _nome = widget.nome;
    _valor = widget.valor;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.id == null) {
        _transacaoService.createTransacao(_nome!, _valor!);
      } else {
        _transacaoService.updateTransacao(widget.id!, _nome!, _valor!);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id == null ? 'Adicionar Transação' : 'Editar Transação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nome,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value;
                },
              ),
              TextFormField(
                initialValue: _valor?.toString(),
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _valor = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.id == null ? 'Adicionar' : 'Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
