
# 🧙 Générateur Aléatoire - Univers Fantasy

Une application Android développée avec Flutter permettant de tirer aléatoirement des noms ou éléments selon des **catégories** et **sous-catégories** définies.  
Conçue pour être utilisée sur tablette, avec une interface immersive dans un style parchemin / fantasy.

---

## ✨ Fonctionnalités

- 🎲 Génération de 10 éléments aléatoires selon un filtre (catégorie et sous-catégorie)
- 📜 Interface personnalisée avec fond parchemin, icône stylisée, polices fantasy
- 📁 Chargement des données depuis un fichier CSV structuré
- 🔍 Navigation par **catégories** et **sous-catégories**
- 🌐 Affichage responsive (portrait / paysage)
- ✅ Aucune base de données nécessaire : toutes les données sont définies en amont

---

## 📂 Structure des données

Les éléments sont stockés dans un fichier CSV :  
```
assets/data/elements.csv
```

Chaque ligne contient :

```csv
valeur;categorie;sousCategorie
```

Exemple :
```csv
Gandalf;prénom;fantasy
Paris;lieu;
Alice;prénom;
```

Tu peux générer ce fichier automatiquement à partir d’une **arborescence de fichiers texte** grâce au script Python fourni (voir ci-dessous).

---

## ⚙️ Génération du CSV

Les fichiers `.txt` sont lus depuis :
```
/source_elements/
├── prenom/
│   ├── fantasy/
│   │   └── noms.txt
│   └── noms.txt
├── lieu/
│   └── lieux.txt
├── traductions.csv     ← facultatif
```

Lance simplement :
```bash
python generateur_csv.py
```

Le script produit automatiquement `assets/data/elements.csv` avec le bon format.

---

## 📦 Installation & compilation

### 🔧 Pré-requis

- [Flutter](https://docs.flutter.dev/get-started/install)
- Un terminal et un éditeur de code (VS Code, Android Studio)

### ▶️ Lancer en local (mode debug)

```bash
flutter run
```

### 📱 Compiler pour Android (mode release)

```bash
flutter build apk --release
```

Le fichier généré se trouve dans :
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📲 Installation sur tablette

1. Active le mode développeur et le **débogage USB**
2. Connecte la tablette via USB
3. Installe l’APK :

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

Ou transfère manuellement le fichier APK et ouvre-le depuis la tablette.

---

## 🚧 Roadmap (éventuelle)

- [ ] Ajout d'autres catégories
- [ ] Ajout d'autres univers

---

## 📝 Licence

Ce projet est distribué sous licence **Mozilla Public License 2.0**.

Vous pouvez l’utiliser et le modifier librement, y compris dans des projets commerciaux, mais **les fichiers modifiés doivent rester open source**.  
Les autres parties du projet peuvent être sous d'autres licences.

Voir le fichier [`LICENSE`](LICENSE) pour les détails.

---
