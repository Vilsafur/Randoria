import os
import csv

# Configuration
DOSSIER_SOURCE = "./source_elements"  # Dossier contenant tes catégories et sous-catégories
FICHIER_TRADUCTIONS = os.path.join(DOSSIER_SOURCE, "traductions.csv")
FICHIER_SORTIE = "./assets/data/elements.csv"

# Lecture du fichier de traductions (facultatif)
traductions = {}
if os.path.exists(FICHIER_TRADUCTIONS):
    with open(FICHIER_TRADUCTIONS, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            if len(row) >= 2:
                traductions[row[0]] = row[1]

# Construction de la liste des éléments
elements = []
for categorie in os.listdir(DOSSIER_SOURCE):
    cat_path = os.path.join(DOSSIER_SOURCE, categorie)

    if os.path.isdir(cat_path) and categorie != "traductions.csv":
        cat_label = traductions.get(categorie, categorie)

        for item in os.listdir(cat_path):
            item_path = os.path.join(cat_path, item)

            if os.path.isdir(item_path):  # sous-catégorie
                sous_label = traductions.get(item, item)
                for fichier in os.listdir(item_path):
                    if fichier.endswith(".txt"):
                        with open(os.path.join(item_path, fichier), encoding="utf-8") as f:
                            lignes = [line.strip() for line in f if line.strip()]
                            for ligne in lignes:
                                elements.append([ligne, cat_label, sous_label])

            elif item.endswith(".txt"):  # fichier directement sous la catégorie
                with open(item_path, encoding="utf-8") as f:
                    lignes = [line.strip() for line in f if line.strip()]
                    for ligne in lignes:
                        elements.append([ligne, cat_label, ""])

# Écriture du fichier CSV final
os.makedirs(os.path.dirname(FICHIER_SORTIE), exist_ok=True)
with open(FICHIER_SORTIE, "w", newline='', encoding="utf-8") as csvfile:
    writer = csv.writer(csvfile, delimiter=';')
    writer.writerow(["valeur", "categorie", "sousCategorie"])
    writer.writerows(elements)

print(f"✅ Fichier généré avec {len(elements)} éléments : {FICHIER_SORTIE}")
