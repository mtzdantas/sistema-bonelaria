import 'package:flutter/material.dart';

class ModelValidatorFunc extends ChangeNotifier{
  String nome;
  String cpf;
  String telefone;
  String email;
  String senha;
  String rua;
  String numero;
  String bairro;
  String complemento;

  ModelValidatorFunc({
    this.nome = '',
    this.cpf = '',
    this.telefone = '',
    this.email = '',
    this.senha = '',
    this.rua = '',
    this.numero = '',
    this.bairro = '',
    this.complemento = '',
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
  void setSenha(String senha) {
    this.senha = senha;
    notifyListeners();
  }
  void setRua(String rua) {
    this.rua = rua;
    notifyListeners();
  }
  void setNumero(String numero) {
    this.numero = numero;
    notifyListeners();
  }
  void setBairro(String bairro) {
    this.bairro = bairro;
    notifyListeners();
  }
  void setComplemento(String complemento) {
    this.complemento = complemento;
    notifyListeners();
  }
}