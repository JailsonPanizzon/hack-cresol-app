class Motorista {
  Motorista({this.idUsuario, this.empresa});

  String idUsuario;
  String empresa;

  factory Motorista.fromMap(map) => Motorista(
        idUsuario: map["idUsuario"],
        empresa: map["empresa"],
      );

  Map<String, dynamic> toJson() {
    return {"idUsuario": this.idUsuario, "empresa": this.empresa};
  }
}
