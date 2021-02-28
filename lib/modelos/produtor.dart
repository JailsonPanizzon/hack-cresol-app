class Produtor {
  Produtor({
    this.nome,
    this.endereco,
    this.hora,
    this.coordenadas,
    this.idProdutor,
  });

  String nome;
  String hora;
  String endereco;
  String coordenadas;
  String observacao;
  String idProdutor;

  factory Produtor.fromMap(map) => Produtor(
        endereco: map["endereco"],
        nome: map["nome"],
        hora: map["hora"],
        coordenadas: map["coordenadas"],
        idProdutor: map["idProdutor"],
      );

  Map<String, dynamic> toJson() {
    return {
      "nome": this.nome,
      "hora": this.hora,
      "coordenadas": this.coordenadas,
      "observacao": this.observacao,
      "idProdutor": this.idProdutor,
      "endereco": this.endereco,
    };
  }
}
