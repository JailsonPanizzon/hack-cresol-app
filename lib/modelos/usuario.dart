class Usuario {
  Usuario(
      {this.nome,
      this.endereco,
      this.email,
      this.telefone,
      this.idOwner,
      this.idDoc});

  String nome;
  String email;
  String endereco;
  String telefone;
  String idOwner;
  String idDoc;

  factory Usuario.fromMap(map) => Usuario(
      endereco: map["endereco"],
      nome: map["nome"],
      email: map["email"],
      telefone: map["telefone"],
      idOwner: map["idEmpresa"]);

  Map<String, dynamic> toJson() {
    return {
      "nome": this.nome,
      "email": this.email,
      "telefone": this.telefone,
      "idOwner": this.idOwner,
      "endereco": this.endereco,
    };
  }
}
