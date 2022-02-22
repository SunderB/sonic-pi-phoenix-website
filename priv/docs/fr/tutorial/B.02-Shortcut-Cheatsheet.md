B.2 Antisèche des raccourcis

# Antisèche des raccourcis

Ce qui suit est un récapitulatif des principaux raccourcis clavier disponibles avec Sonic Pi. Voyez svp la section B.1 pour la motivation et le contexte.

## Conventions

Dans cette liste, nous utilisons les conventions suivantes (où *Meta* est la touche *Alt* pour Windows/Linux et *Cmd* sur Mac) :

* `C-a` signifie maintenir la touche *Control* enfoncée puis presser la touche *a* en les maintenant les deux en même temps, puis les relâcher.
* `M-r` signifie maintenir la touche *Meta* enfoncée puis presser la touche *r* en les maintenant les deux en même temps, puis les relâcher.
* `S-M-z` signifie maintenir les touches *Majuscule* et *Meta* enfoncées puis presser la touche *z* en les maintenant les deux en même temps, puis les relâcher.
* `C-M-f` signifie maintenir les touches *Control* et *Meta* enfoncées puis presser la touche *f* en les maintenant les deux en même temps, puis les relâcher.

## Manipulation de l'application principale

* `M-r` - Exécute le code
* `M-s` - Arrête le code
* `M-i` - Affiche/cache le système d'aide
* `M-p` - Affiche/cache les préférences
* `M-{` - Bascule sur le buffer de gauche
* `M-}` - Bascule sur le buffer de droite
* `S-M-0` - Bascule vers le tampon 0
* `S-M-1` - Bascule vers le tampon 1
* ...
* `S-M-9` - Bascule vers le tampon 9
* `M-+` - Augmente la taille du texte du buffer courant
* `M--` - Diminue la taille du texte du buffer courant


## Sélection/Copier/Coller

* `M-a` - Sélectionner tout
* `M-c` - Copie la sélection dans le presse-papier
* `M-]` - Copie la sélection dans le presse-papier
* `M-x` - Coupe la sélection et la copie dans le presse-papier
* `C-]` - Coupe la sélection et la copie dans le presse-papier
* `C-k` - Coupe jusqu'à la fin de la ligne et le copie dans le presse-papier
* `M-v` - Colle depuis le presse-papier
* `C-y` - Colle depuis le presse-papier
* `C-SPACE` - Pose une marque. La navigation surligne et sélectionne la région depuis la marque. Utilisez `C-g` pour sortir.

## Manipulation du texte

* `M-m` - Aligne et indente tout le texte
* `Tab` - Aligne et indente la ligne courante ou la sélection (ou sélectionne l'auto-complétion)
* `C-l` - Centre l'éditeur
* `M-/` - Commente/Décommente la ligne courante ou la sélection
* `C-t` - Intervertit les caractères sélectionnés
* `M-u` - Convertit le mot suivant (ou la sélection) en majuscule.
* `M-l` - Convertit le mot suivant (ou la sélection) en minuscule.

## Navigation

* `C-a` - Déplace au début de la ligne
* `C-e` - Déplace à la fin de la ligne
* `C-p` - Déplace à la ligne précédente
* `C-n` - Déplace à la ligne suivante
* `C-f` - Avance d'un caractère
* `C-b` - Recule d'un caractère
* `M-f` - Avance d'un mot
* `M-b` - Recule d'un mot
* `C-M-n` - Déplace la ligne ou la sélection vers le bas
* `C-M-p` - Déplace la ligne ou la sélection vers le haut
* `S-M-u` - Déplace 10 lignes vers le haut
* `S-M-d` - Déplace 10 lignes vers le bas
* `M-<` - Aller au début du tampon
* `M->` - Aller à la fin du tampon

## Suppression

* `C-h` - Supprime le caractère précédent
* `C-d` - Supprime le caractère suivant

## Fonctionnalités avancées de l'éditeur

* `C-i` - Affiche la documentation du mot où se trouve le curseur
* `M-z` - Défait
* `S-M-z` - Refait
* `C-g` - Sortir
* `S-M-f` - Bascule en mode plein écran
* `S-M-b` - Affiche/cache les boutons
* `S-M-l` - Affiche/cache le panneau "trace"
* `S-M-m` - Bascule entre l'affichage clair et sombre
* `S-M-s` - Enregistrer le contenu du tampon dans un fichier
* `S-M-o` - Charger le contenu d'un tampon à partir d'un fichier
