import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/element_aleatoire.dart';

class GenerateurScreen extends StatefulWidget {
  const GenerateurScreen({super.key});

  @override
  _GenerateurScreenState createState() => _GenerateurScreenState();
}

class _GenerateurScreenState extends State<GenerateurScreen> {
  List<ElementAleatoire> elements = [];
  List<ElementAleatoire> valeursAleatoires = [];

  String? selectedCategorie;
  String? selectedSousCategorie;

  @override
  void initState() {
    super.initState();
    _chargerElements();
  }

  Future<void> _chargerElements() async {
    final csvData = await rootBundle.loadString('assets/data/elements.csv');
    final lignes = const CsvToListConverter(fieldDelimiter: ';').convert(csvData, eol: '\n');

    setState(() {
      elements = lignes
          .skip(1) // ignorer l'en-tête
          .map((row) => ElementAleatoire.fromCsv(row))
          .toList();
    });

    _tirerValeurs();
  }

  void _tirerValeurs() {
    final filtres = elements.where((e) {
      final catOk = selectedCategorie == null || e.categorie == selectedCategorie;
      final sousCatOk = selectedSousCategorie == null || e.sousCategorie == selectedSousCategorie;
      return catOk && sousCatOk;
    }).toList();

    filtres.shuffle(Random());

    setState(() {
      valeursAleatoires = filtres.take(10).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = elements.map((e) => e.categorie).toSet().toList();
    final sousCategories = selectedCategorie == null
        ? []
        : elements
            .where((e) => e.categorie == selectedCategorie && e.sousCategorie != null)
            .map((e) => e.sousCategorie!)
            .toSet()
            .toList();
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Image.asset(
            'assets/images/parchemin.jpg',
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Générateur aléatoire',
            style: TextStyle(
              fontFamily: 'CrimsonPro',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.brown[900],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/parchemin.jpg", fit: BoxFit.cover),
          ),
          Row(
            children: [
              // Colonne gauche : affichage des valeurs
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _tirerValeurs,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2F2F),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Tirer 10 noms'),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: isPortrait ? 1 : 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 4,
                        childAspectRatio: isPortrait ? 4.5 : 3.5, // ← ajuste la largeur/hauteur
                        padding: EdgeInsets.all(8),
                        children: valeursAleatoires.map((element) {
                          return Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(element.valeur, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                                Text(
                                  element.sousCategorie != null
                                      ? '${element.categorie} > ${element.sousCategorie}'
                                      : element.categorie,
                                  style: TextStyle(fontSize: 22, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              VerticalDivider(width: 1),

              // Colonne droite : catégories et sous-catégories
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text('Catégories', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true, // ← pour forcer l'affichage
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final cat = categories[index];
                            return ListTile(
                              title: Text(
                                cat,
                                style: TextStyle(fontSize: 26),
                              ),
                              selected: selectedCategorie == cat,
                              onTap: () {
                                setState(() {
                                  selectedCategorie = cat;
                                  selectedSousCategorie = null;
                                });
                                _tirerValeurs();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    if (sousCategories.isNotEmpty) Divider(),
                    if (sousCategories.isNotEmpty)
                      Text('Sous-catégories', style: TextStyle(fontWeight: FontWeight.bold)),
                    if (sousCategories.isNotEmpty)
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true, // ← pour forcer l'affichage
                          thickness: 6,
                          radius: Radius.circular(4),
                          trackVisibility: true,
                          interactive: true,
                          child: ListView.builder(
                            itemCount: sousCategories.length,
                            itemBuilder: (context, index) {
                              final sous = sousCategories[index];
                              return ListTile(
                                title: Text(
                                  sous,
                                  style: TextStyle(fontSize: 26),
                                ),
                                selected: selectedSousCategorie == sous,
                                onTap: () {
                                  setState(() {
                                    selectedSousCategorie = sous;
                                  });
                                  _tirerValeurs();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
