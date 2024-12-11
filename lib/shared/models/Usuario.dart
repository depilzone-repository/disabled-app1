class Usuario{

   late int? id;
   late String? nombre;
   late  String? apellido;
   late String? correo;
   late String? hash;

   Usuario({
    this.id,
    this.nombre,
    this.apellido,
    this.correo,
    this.hash
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'apellido': apellido,
    'correo': correo,
    'hash': hash
  };

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        correo = json['correo'],
        hash = json['hash'];

}