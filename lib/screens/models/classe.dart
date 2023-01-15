class Classe{
  
  final String id;
  final int niveau;
  final String branche;
  final int numero;
  final String name;
  final int nbEtudiant;
  final String year;

  const Classe({
    required this.id,
    required this.niveau,
    required this.branche,
    required this.numero,
    required this.name,
    required this.nbEtudiant,
    required this.year
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      id: json['id'],
      niveau: json['niveau'],
      branche: json['branche'],
      numero: json['numero'],
      name: json['name'],
      nbEtudiant: json['nbEtudiant'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'niveau': niveau,
        'branche': branche,
        'numero': numero,
        'name': name,
        'nbEtudiant': nbEtudiant,
        'year': year,
      };

}