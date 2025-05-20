class ElementAleatoire {
  final String valeur;
  final String categorie;
  final String? sousCategorie;

  ElementAleatoire({
    required this.valeur,
    required this.categorie,
    this.sousCategorie,
  });

  factory ElementAleatoire.fromCsv(List<dynamic> row) {
    return ElementAleatoire(
      valeur: row[0].toString(),
      categorie: row[1].toString(),
      sousCategorie: row.length > 2 && row[2].toString().trim().isNotEmpty
          ? row[2].toString()
          : null,
    );
  }
}
