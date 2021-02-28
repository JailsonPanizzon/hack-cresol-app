class Motorista {
  Motorista({this.idUsuario, this.empresa});

  String idUsuario;
  String empresa;

  factory Motorista.fromMap(map) => Motorista(
        idUsuario: map["IdUsuario"],
        empresa: map["empresa"],
      );

  Map<String, dynamic> toJson() {
    return {"IdUsuario": this.idUsuario, "empresa": this.empresa};
  }
}
