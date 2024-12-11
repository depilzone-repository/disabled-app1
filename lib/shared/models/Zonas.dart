class Zona{
  final int? id;
  final String? nombre;
  final int? sesion;
  final double? precio;
  final int? minutos;

  const Zona({
     this.id,
     this.nombre,
     this.sesion,
     this.precio,
     this.minutos
  });

  factory Zona.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'nombre': String nombre,
      'sesion': int sesion,
      'precio': double precio,
      'minutos': int minutos
      } =>
          Zona(
            id: id,
            nombre: nombre,
            sesion: sesion,
            precio: precio,
            minutos: minutos
          ),
      _ => throw const FormatException('Failed to load citas.'),
    };
  }

}