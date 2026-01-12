# Documentation Joceluss

[![Deploy Zensical](https://github.com/joceluss/joceluss.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/joceluss/joceluss.github.io/actions/workflows/deploy.yml)

Documentation personnelle construite avec [Zensical](https://zensical.org/) - le générateur de site statique moderne par l'équipe de Material for MkDocs.

## 🚀 Voir la documentation

👉 [https://joceluss.github.io/](https://joceluss.github.io/)

## 💻 Développement local

### Installation

```bash
pip install -r requirements.txt
```

### Lancer le serveur de développement

```bash
zensical serve
```

Puis ouvrez [http://127.0.0.1:8000](http://127.0.0.1:8000) dans votre navigateur.

### Construire le site

```bash
zensical build
```

### Déployer manuellement

```bash
zensical gh-deploy
```

## 📝 Ajouter du contenu

1. Créez des fichiers Markdown dans le dossier `docs/`
2. Ajoutez-les à la navigation dans `zensical.toml`
3. Committez et poussez - le déploiement est automatique !

## 🎨 Personnalisation

Modifiez le fichier `zensical.toml` pour personnaliser :
- Les couleurs et le thème
- La navigation
- Les extensions Markdown
- Et bien plus !

Consultez la [documentation Zensical](https://zensical.org/docs/) pour toutes les options.

## ⚡ Pourquoi Zensical ?

- **Ultra-rapide** : Builds en quelques secondes grâce à Rust
- **Moderne** : Architecture de nouvelle génération
- **Compatible** : Même design et philosophie que Material for MkDocs
- **Supporté** : Développé activement par l'équipe Material
