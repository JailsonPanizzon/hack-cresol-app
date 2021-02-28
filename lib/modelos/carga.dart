class Carga {
  Carga({
    this.data,
    this.hora,
    this.coordenadas,
    this.lote,
  });

  String hora;
  String lote;
  String data;
  String coordenadas;
  factory Carga.fromMap(map) => Carga(
        data: map["data"],
        hora: map["hora"],
        coordenadas: map["coordenadas"],
        lote: map["lote"],
      );

  Map<String, dynamic> toJson() {
    return {
      "hora": this.hora,
      "coordenadas": this.coordenadas,
      "lote": this.lote,
      "data": this.data,
    };
  }
}
