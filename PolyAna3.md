# Polycopié : Convertisseurs Analogique-Numérique et Numérique-Analogique

## Introduction
Les convertisseurs analogique-numérique (CAN) et numérique-analogique (CNA) sont des composants essentiels pour interfacer des signaux analogiques du monde réel avec des systèmes numériques. Ils trouvent des applications dans divers domaines tels que l’audio, l’instrumentation, et les systèmes embarqués. Ce document aborde les bases théoriques, les architectures, les erreurs, et les applications des CAN et des CNA, accompagné d’exercices résolus pour faciliter la compréhension.

---

## 1. Convertisseurs Numérique-Analogique (CNA)

### 1.1. Principes de Base
Un CNA transforme une valeur numérique codée sur \(N\) bits en une tension ou un courant analogique proportionnel. Sa caractéristique de transfert peut s’exprimer comme :

\[
V_s = - \left(\frac{R_G}{R_0}\right)\sum_{k=0}^{N-1} \frac{b_k}{2^k} V_{\text{ref}}
\]

où :
- \(V_s\) est la tension de sortie.
- \(V_{\text{ref}}\) est la tension de référence.
- \(b_k\) sont les bits de l’entrée numérique (0 ou 1).

---

### 1.2. Architectures Principales

#### a) CNA à Résistances Pondérées
- **Principe :** Utilise un réseau de résistances pondérées selon des puissances de 2.
- **Avantages :** Simple à comprendre et implémenter.
- **Inconvénients :** Tolérance stricte sur les résistances, limité à 8 bits.
- **Tension de sortie :**

\[
V_s = -\frac{R_G}{R_0}\left(b_{N-1} + \frac{b_{N-2}}{2} + \ldots + \frac{b_0}{2^{N-1}}\right)V_{\text{ref}}
\]

---

#### b) CNA à Réseau R-2R
- **Principe :** Utilise un réseau de résistances avec seulement deux valeurs (\(R\) et \(2R\)), réduisant les erreurs d’appariement.
- **Avantages :** Plus facile à intégrer, linéarité accrue.
- **Tension de sortie :**

\[
V_s = -\frac{V_{\text{ref}}}{2^N}\sum_{k=0}^{N-1} 2^{N-1-k} a_k
\]

---

#### c) CNA Segmenté
- **Principe :** Combine des CNA à résistances pondérées et des CNA R-2R pour les bits de poids fort et faible respectivement.
- **Avantages :** Réduit les erreurs globales de linéarité.
- **Applications :** Utilisé dans les systèmes nécessitant des conversions rapides et précises.

---

### 1.3. Erreurs dans les CNA
- **Erreur de gain :** Écart sur la pente idéale de la fonction de transfert.
- **Erreur de linéarité :** Déviation par rapport à une caractéristique idéale linéaire.
- **Erreur de quantification :** Variation résiduelle entre la sortie réelle et idéale.

---

## 2. Convertisseurs Analogique-Numérique (CAN)

### 2.1. Principes de Base
Un CAN effectue la conversion inverse d’un CNA en transformant une entrée analogique en un code numérique. La tension d’entrée est discrétisée et codée en fonction de la pleine échelle (\(V_{\text{FS}}\)) et du pas de quantification (\(q\)) :

\[
q = \frac{V_{\text{FS}}}{2^N}
\]

---

### 2.2. Architectures Principales

#### a) CAN Flash
- **Principe :** Compare simultanément l’entrée à \(2^N - 1\) niveaux de tension.
- **Avantages :** Conversion ultra-rapide.
- **Inconvénients :** Nombre de comparateurs exponentiel (\(2^N - 1\)).
- **Applications :** Oscilloscopes numériques.

---

#### b) CAN à Approximations Successives (SAR)
- **Principe :** Utilise une méthode dichotomique pour ajuster successivement les bits du code numérique.
- **Avantages :** Précis, adapté aux résolutions élevées.
- **Temps de conversion :**

\[
T_{\text{conv}} = N \cdot T_{\text{horloge}}
\]

---

#### c) CAN à Rampe
- **Principe :** Compare une rampe de tension à l’entrée pour déterminer le code numérique.
- **Avantages :** Simple et peu coûteux.
- **Inconvénients :** Lent, sensible au bruit.

---

#### d) CAN Segmenté
- **Principe :** Combine les principes des CAN flash et SAR pour minimiser les défauts de chaque architecture.
- **Applications :** Instrumentation nécessitant vitesse et précision.

---

### 2.3. Erreurs dans les CAN
- **Erreur de quantification :** Se situe entre \(-q/2\) et \(+q/2\).
- **Erreur de gain et d’offset :** Corrigées par calibration.
- **Erreur de linéarité :** DNL (non-linéarité différentielle) et INL (non-linéarité intégrale).

---

## 3. Concepts Communs

### 3.1. Échantillonnage
- **Théorème de Shannon :** La fréquence d’échantillonnage (\(F_s\)) doit être au moins deux fois la fréquence maximale du signal (\(F_{\text{max}}\)).
- **Filtrage anti-repliement :** Nécessaire pour éviter les alias.

---

### 3.2. Codage
- **Code binaire naturel :** Convient aux signaux unipolaires.
- **Code binaire décalé :** Utilisé pour les signaux bipolaires.

---

## 4. Applications Pratiques
- **Audio numérique :** Utilisation de CNA R-2R pour générer des signaux sonores avec un filtrage de lissage.
- **Instrumentation :** CAN SAR pour des mesures précises et rapides.
- **Télécommunications :** CAN flash dans les systèmes à haute fréquence.

---

## 5. Exercices Résolus

### Exemple : Calculer le Pas de Quantification d’un CNA R-2R
1. **Données :** \(N = 8\) bits, \(V_{\text{ref}} = 10\) V.
2. **Formule :**

\[
q = \frac{V_{\text{FS}}}{2^N} = \frac{10}{2^8} = 39.06 \, \text{mV}.
\]

3. **Interprétation :** La plus petite variation de l’entrée numérique entraîne une variation de \(39.06 \, \text{mV}\) en sortie.

---

