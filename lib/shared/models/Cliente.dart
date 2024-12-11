class Cliente{
     int? id;
     String? nombres;
     String? apellidos;
     String? correo;
     String? celular1;
     String? celular2;
     String? foto;
     String? genero;
     String? numeroDocumentoIdentidad;
     String? tipoDocumentoIdentidad;
     String? alias;

     bool? encontrado;
     bool? tieneCredenciales;

     Cliente({
          this.id,
          this.nombres,
          this.apellidos,
          this.correo,
          this.celular1,
          this.celular2,
          this.foto,
          this.genero,
          this.alias
     });

     Map<String, dynamic> toJson() =>
         {
              'id': id,
              'nombres': nombres,
              'apellidos': apellidos,
              'correo': correo,
         };
}