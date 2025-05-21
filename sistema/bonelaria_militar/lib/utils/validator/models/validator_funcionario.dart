import 'package:flutter/material.dart';

class ModelValidatorFunc extends ChangeNotifier{
  String nome;
  String cpf;
  String telefone;
  String email;

  ModelValidatorFunc({
    this.nome = '',
    this.cpf = '',
    this.telefone = '',
    this.email = '',
  });

  void setNome(String nome) {
    this.nome = nome;
    notifyListeners();
  }
  void setCpf(String cpf) {
    this.cpf = cpf;
    notifyListeners();
  }
  void setTelefone(String telefone) {
    this.telefone = telefone;
    notifyListeners();
  }
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  } 
}