class Servicio {

  final int id;
  final String nombre;
  final String nombreCorto;
  final int idEstado;
  final String color;


  const Servicio({
    required this.id,
    required this.nombre,
    required this.nombreCorto,
    required this.idEstado,
    required this.color,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'nombre': String nombre,
      'nombre_corto': String nombreCorto,
      'id_estado': int idEstado,
      'color': String color,
      } =>
          Servicio(
            id: id,
            nombre: nombre,
            nombreCorto: nombreCorto,
            idEstado: idEstado,
            color: color,
          ),
      _ => throw const FormatException('Error al obtener los servicios.'),
    };
  }
}