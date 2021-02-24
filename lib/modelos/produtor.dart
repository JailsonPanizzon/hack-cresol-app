class Produtor {
  Produtor(
      {this.nome,
      this.endereco,
      this.hora,
      this.coordenadas,
      this.quantidade,
      this.observacao,
      this.amostra,
      this.empresaAtual,
      this.temperatura});

  String nome;
  String hora;
  String endereco;
  String coordenadas;
  String observacao;
  String amostra;
  String empresaAtual;
  String quantidade;
  String temperatura;

  factory Produtor.fromMap(map) => Produtor(
      endereco: map["endereco"],
      nome: map["nome"],
      hora: map["hora"],
      coordenadas: map["coordenadas"],
      amostra: map["amostra"],
      empresaAtual: map["empresaAtual"],
      observacao: map["observacao"],
      temperatura: map["temperatura"],
      quantidade: map["idEmpresa"]);

  Map<String, dynamic> toJson() {
    return {
      "nome": this.nome,
      "hora": this.hora,
      "coordenadas": this.coordenadas,
      "observacao": this.observacao,
      "amostra": this.amostra,
      "empresaAtual": this.empresaAtual,
      "quantidade": this.quantidade,
      "temperatura": this.temperatura,
      "endereco": this.endereco,
    };
  }
}
