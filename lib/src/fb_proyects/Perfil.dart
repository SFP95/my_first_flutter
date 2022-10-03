class Perfil { // modificar en base a lo que tenemos en la base de datos del firebase
  final String? name;
  final String? state;
  final String? country;
  final bool? capital;
  final int? population;
  final List<String>? regions;

  Perfil({
    this.name,
    this.state,
    this.country,
    this.capital,
    this.population,
    this.regions,
  });

  factory Perfil.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Perfil(
      name: data?['name'],
      state: data?['state'],
      country: data?['country'],
      capital: data?['capital'],
      population: data?['population'],
      regions:
      data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (capital != null) "capital": capital,
      if (population != null) "population": population,
      if (regions != null) "regions": regions,
    };
  }
}