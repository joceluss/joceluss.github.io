# Guide de Sécurité - Security Guide

Ce guide explique comment vérifier qu'il n'y a plus de failles de sécurité dans le code de ce projet de documentation.

This guide explains how to verify that there are no more security vulnerabilities in this documentation project's code.

## 🔒 Contrôles de Sécurité Automatisés / Automated Security Checks

### Exécution Locale / Local Execution

Pour vérifier la sécurité localement / To check security locally:

```bash
# Installer les dépendances de sécurité / Install security dependencies
pip install -r requirements.txt

# Exécuter les vérifications de sécurité / Run security checks
./check-security.sh
```

### Rapports Générés / Generated Reports

Les rapports de sécurité sont générés dans le dossier `security-reports/` :

Security reports are generated in the `security-reports/` folder:

- **`security-summary.md`** : Résumé des problèmes trouvés / Summary of issues found
- **`pip-audit-report.json`** : Vulnérabilités dans les dépendances Python / Python dependency vulnerabilities  
- **`bandit-report.json`** : Problèmes de sécurité dans le code Python / Python code security issues
- **`npm-audit-report.json`** : Vulnérabilités dans les dépendances JavaScript / JavaScript dependency vulnerabilities

## 🛠️ Outils de Sécurité Utilisés / Security Tools Used

### 1. **pip-audit** - Analyse des Dépendances Python / Python Dependency Analysis
- Vérifie les vulnérabilités connues dans les packages Python / Checks for known vulnerabilities in Python packages
- Base de données: PyPA Advisory Database et OSV / Database: PyPA Advisory Database and OSV
- Commande manuelle / Manual command: `pip-audit --format=json`

### 2. **bandit** - Analyse du Code Python / Python Code Analysis
- Détecte les problèmes de sécurité dans le code Python / Detects security issues in Python code
- Vérifie: injections SQL, hardcoded passwords, etc. / Checks for: SQL injections, hardcoded passwords, etc.
- Commande manuelle / Manual command: `bandit -r . -f json`

### 3. **npm audit** - Analyse des Dépendances JavaScript / JavaScript Dependency Analysis
- Vérifie les vulnérabilités dans les packages npm / Checks for vulnerabilities in npm packages
- Base de données: npm security advisories / Database: npm security advisories
- Commande manuelle / Manual command: `npm audit --json`

### 4. **safety** (Dépréciée / Deprecated) - Analyse des Dépendances Python
- Ancienne méthode pour vérifier les vulnérabilités Python / Old method for checking Python vulnerabilities
- Remplacée par pip-audit / Replaced by pip-audit

## 🚀 Intégration CI/CD

### GitHub Actions
Les vérifications de sécurité sont automatiquement exécutées sur chaque push et pull request.

Security checks are automatically run on every push and pull request.

**Workflows configurés / Configured workflows:**
- **`.github/workflows/ci.yml`** : Vérifications de sécurité + déploiement / Security checks + deployment
- **`.github/workflows/codeql.yml`** : Analyse de code avec CodeQL / Code analysis with CodeQL

### Dependabot
Configuration automatique pour les mises à jour de sécurité.

Automatic configuration for security updates.

**Fichier de configuration / Configuration file:** `.github/dependabot.yml`

## 🔧 Comment Corriger les Vulnérabilités / How to Fix Vulnerabilities

### Dépendances Python / Python Dependencies

1. **Identifier les packages vulnérables / Identify vulnerable packages:**
   ```bash
   pip-audit --format=table
   ```

2. **Mettre à jour requirements.txt / Update requirements.txt:**
   ```bash
   # Remplacer / Replace:
   mkdocs-material==9.6.19
   # Par / With:
   mkdocs-material==9.6.20  # version corrigée / fixed version
   ```

3. **Installer les mises à jour / Install updates:**
   ```bash
   pip install -r requirements.txt
   ```

### Dépendances JavaScript / JavaScript Dependencies

1. **Corriger automatiquement / Auto-fix:**
   ```bash
   cd mkdocs-material/
   npm audit fix
   ```

2. **Correction manuelle pour les problèmes majeurs / Manual fix for major issues:**
   ```bash
   npm audit fix --force
   ```

### Problèmes de Code / Code Issues

1. **Analyser les problèmes / Analyze issues:**
   ```bash
   bandit -r . -ll  # Affiche seulement les problèmes de niveau élevé / Show only high-level issues
   ```

2. **Corriger le code / Fix code:**
   - Remplacer les patterns non-sécurisés / Replace insecure patterns
   - Utiliser des fonctions sécurisées / Use secure functions
   - Ajouter une validation d'entrée / Add input validation

## 📊 Surveillance Continue / Continuous Monitoring

### Alertes GitHub / GitHub Alerts
- **Dependabot alerts** : Mises à jour automatiques des dépendances / Automatic dependency updates
- **Code scanning alerts** : Résultats de CodeQL / CodeQL results
- **Secret scanning** : Détection de secrets hardcodés / Detection of hardcoded secrets

### Fréquence des Vérifications / Check Frequency
- **Push/PR** : Vérifications automatiques / Automatic checks
- **Hebdomadaire** : CodeQL et Dependabot / Weekly: CodeQL and Dependabot
- **Mensuel** : Révision manuelle des rapports / Monthly: Manual report review

## 🎯 Bonnes Pratiques / Best Practices

### Pour les Développeurs / For Developers
1. **Exécuter les vérifications avant chaque commit / Run checks before each commit**
2. **Maintenir les dépendances à jour / Keep dependencies up to date**
3. **Réviser les alertes de sécurité rapidement / Review security alerts quickly**
4. **Ne jamais ignorer les vulnérabilités de haute sévérité / Never ignore high-severity vulnerabilities**

### Pour le Maintien du Projet / For Project Maintenance
1. **Révision hebdomadaire des rapports de sécurité / Weekly security report review**
2. **Tests après chaque mise à jour de sécurité / Testing after each security update**
3. **Documentation des exceptions de sécurité / Documentation of security exceptions**
4. **Formation de l'équipe sur les pratiques de sécurité / Team training on security practices**

## 🆘 En Cas de Vulnérabilité Critique / In Case of Critical Vulnerability

### Actions Immédiates / Immediate Actions
1. **Évaluer l'impact / Assess impact**
2. **Appliquer un correctif temporaire si nécessaire / Apply temporary fix if needed**
3. **Mettre à jour la dépendance vulnérable / Update vulnerable dependency**
4. **Tester la correction / Test the fix**
5. **Déployer rapidement / Deploy quickly**

### Communication / Communication
1. **Notifier l'équipe / Notify team**
2. **Documenter l'incident / Document incident**
3. **Planifier la prévention / Plan prevention**

---

**Contact pour les questions de sécurité / Contact for security questions:**
- Créer une issue GitHub / Create a GitHub issue
- Étiquette: `security` / Label: `security`