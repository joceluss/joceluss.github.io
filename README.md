# Site de Documentation

Ce repository contient le site de documentation personnel hébergé sur GitHub Pages.

## À propos

Ce site utilise [MkDocs](https://www.mkdocs.org/) avec le thème [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) pour créer une documentation moderne et responsive.

## Structure du projet

```
├── docs/           # Fichiers markdown de la documentation
├── mkdocs-material/# Thème Material for MkDocs
├── mkdocs.yml      # Configuration MkDocs
└── README.md       # Ce fichier
```

## Développement local

Pour travailler sur la documentation en local :

1. Installer MkDocs :
   ```bash
   pip install mkdocs
   ```

2. Lancer le serveur de développement :
   ```bash
   mkdocs serve
   ```

3. Ouvrir http://127.0.0.1:8000 dans votre navigateur

## Déploiement

Le site est automatiquement déployé sur GitHub Pages à l'adresse : https://joceluss.github.io

## Contribuer

Pour ajouter ou modifier du contenu :
1. Éditer les fichiers markdown dans le dossier `docs/`
2. Tester localement avec `mkdocs serve`
3. Committer et pousser les modifications
