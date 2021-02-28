class Coleta {
  Coleta(
      {this.produtor,
      this.data,
      this.hora,
      this.coordenadas,
      this.quantidade,
      this.observacao,
      this.carga,
      this.amostra,
      this.motorista,
      this.nomeProdutor,
      this.id,
      this.temperatura});

  String produtor;
  String id;
  String motorista;
  String hora;
  String nomeProdutor;
  String data;
  String carga;
  String coordenadas;
  String observacao;
  bool amostra;
  String quantidade;
  String temperatura;

  factory Coleta.fromMap(map) => Coleta(
        data: map["data"],
        id: map["id"],
        produtor: map["produtor"],
        nomeProdutor: map["nomeProdutor"],
        motorista: map["motorista"],
        carga: map["carga"],
        hora: map["hora"],
        coordenadas: map["coordenadas"],
        amostra: map["amostra"],
        quantidade: map["quantidade"],
        observacao: map["observacao"],
        temperatura: map["temperatura"],
      );

  Map<String, dynamic> toJson() {
    return {
      "produtor": this.produtor,
      "nomeProdutor": this.nomeProdutor,
      "motorista": this.motorista,
      "hora": this.hora,
      "coordenadas": this.coordenadas,
      "carga": this.carga,
      "observacao": this.observacao,
      "amostra": this.amostra,
      "quantidade": this.quantidade,
      "temperatura": this.temperatura,
      "data": this.data,
    };
  }
}
