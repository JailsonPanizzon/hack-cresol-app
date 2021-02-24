class Coleta {
  Coleta(
      {this.produtor,
      this.data,
      this.hora,
      this.coordenadas,
      this.quantidade,
      this.observacao,
      this.amostra,
      this.motorista,
      this.temperatura});

  String produtor;
  String motorista;
  String hora;
  String data;
  String coordenadas;
  String observacao;
  bool amostra;
  String quantidade;
  String temperatura;

  factory Coleta.fromMap(map) => Coleta(
      data: map["data"],
      produtor: map["produtor"],
      motorista: map["motorista"],
      hora: map["hora"],
      coordenadas: map["coordenadas"],
      amostra: map["amostra"],
      observacao: map["observacao"],
      temperatura: map["temperatura"],
      quantidade: map["idEmpresa"]);

  Map<String, dynamic> toJson() {
    return {
      "produtor": this.produtor,
      "motorista": this.motorista,
      "hora": this.hora,
      "coordenadas": this.coordenadas,
      "observacao": this.observacao,
      "amostra": this.amostra,
      "quantidade": this.quantidade,
      "temperatura": this.temperatura,
      "data": this.data,
    };
  }
}
