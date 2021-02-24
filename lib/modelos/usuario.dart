class Usuario {
  Usuario(
      {this.nome,
      this.endereco,
      this.email,
      this.telefone,
      this.idEmpresa,
      this.idDoc});

  String nome;
  String email;
  String endereco;
  String telefone;
  String idEmpresa;
  String idDoc;

  factory Usuario.fromMap(map) => Usuario(
      endereco: map["endereco"],
      nome: map["nome"],
      email: map["email"],
      telefone: map["telefone"],
      idEmpresa: map["idEmpresa"]);

  Map<String, dynamic> toJson() {
    return {
      "nome": this.nome,
      "email": this.email,
      "telefone": this.telefone,
      "idEmpresa": this.idEmpresa,
      "endereco": this.endereco,
    };
  }
}
