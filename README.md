# Documentation Joceluss

[![Deploy Zensical](https://github.com/joceluss/joceluss.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/joceluss/joceluss.github.io/actions/workflows/deploy.yml)

Documentation personnelle construite avec [Zensical](https://zensical.org/) - le successeur moderne de Material for MkDocs.

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

## 📝 Ajouter du contenu

1. Créez des fichiers Markdown dans le dossier `docs/`
2. Ajoutez-les à la navigation dans `zensical.toml`
3. Committez et poussez - le déploiement est automatique !

## ⚡ Pourquoi Zensical ?

- **Ultra-rapide** - Écrit en Rust, builds en secondes
- **Moderne** - Par les créateurs de Material for MkDocs
- **Puissant** - Fonctionnalités intégrées, moins de plugins
- **Futur** - Développement actif et support à long terme

## 🎨 Personnalisation

Modifiez le fichier `zensical.toml` pour personnaliser :
- Les couleurs et le thème
- La navigation
- Les extensions Markdown
- Et bien plus !

Consultez la [documentation Zensical](https://zensical.org/docs/) pour toutes les options.
