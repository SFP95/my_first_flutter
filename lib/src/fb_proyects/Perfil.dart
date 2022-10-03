class Perfil { // modificar en base a lo que tenemos en la base de datos del firebase
  final String? name;
  final String? city;
  final String? country;
  final int? edad;


  Perfil({
    this.name="",
    this.city="",
    this.country="",
    this.edad=0,
  });

  factory Perfil.fromFirestore( //  hay que descargar su document SnapShot pero no se puede hacer hasta que se tenga bien el firebase
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Perfil(
      name: data?['name'],
      country: data?['country'],
      city: data?['city'],
      edad: data['edad'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (country != null) "country": country,
      if (city != null) "capital": city,
      if (edad != null) "edad": edad,
    };
  }
}