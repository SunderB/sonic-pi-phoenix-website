B.1 Utilisation des raccourcis

# Utilisation des raccourcis

Sonic Pi est tout autant un instrument qu'un environnement de programmation. Les raccourcis peuvent cependant rendre votre jeu avec Sonic Pi plus *efficace et naturel* - particulièrement quand vous jouez en direct devant un auditoire.

La plus grande part de Sonic Pi peut être contrôlée au moyen du clavier. Au fur et à mesure que vous deviendrez plus familier dans la pratique et l'interprétation avec Sonic Pi, vous commencerez probablement à utiliser de plus en plus de raccourcis. *Personnellement, je tape sans regarder le clavier* (je recommande que vous appreniez à le faire aussi) et je me sens frustré quand j'ai besoin d'attraper la souris parce que ça me retarde. J'utilise donc tous ces raccourcis très régulièrement !

Par conséquent, si vous apprenez les raccourcis, vous saurez utiliser efficacement votre clavier et vous coderez en direct comme un pro en peu de temps.

Toutefois, *n'essayez pas de les apprendre tous à la fois*, essayez et souvenez-vous simplement de ceux que vous utilisez le plus et continuez à en ajouter en supplément à votre pratique.

## Compatibilité entre plateformes

Imaginez que vous appreniez la clarinette. Vous vous attendriez à ce que toutes les clarinettes aient les mêmes contrôles et le même doigté. Si elles ne l'avaient pas, vous passeriez un moment pénible à basculer entre différentes clarinettes et vous seriez pris à rester toujours avec la même.

Malheureusement, les trois systèmes d'exploitation principaux (Linux, Mac OS X et Windows) se présentent avec leurs propres standards par défaut pour des actions telles que copier/coller etc. Sonic Pi va essayer d'honorer ces standards. Toutefois *la priorité est de favoriser la compatibilité entre plateformes* avec Sonic Pi plutôt que de tenter de se conformer aux standards d'une plateforme donnée. Ceci signifie que quand vous apprenez les raccourcis de jeu avec Sonic Pi sur votre Raspberry Pi, vous pouvez passer au Mac ou au PC et vous retrouver en terre connue.

## "Control" et "Meta"

Une part de la notion de constance est l'appellation des raccourcis. Dans Sonic Pi, nous utilisons les termes *Control* et *Meta* pour se référer aux deux combinaisons de touches principales. Sur toutes les plateformes *Control* (Ctrl) est identique. Toutefois, sur Linux et Windows, *Meta* est en réalité la touche *Alt* alors que sur Mac, *Meta* est la touche *Command* (Cmd). Pour la constance, nous utiliserons le terme *Meta* - rappelez-vous juste de le faire correspondre à la touche appropriée sur votre système d'exploitation.

## Abréviations

Pour conserver les choses simples et lisibles, nous utiliserons les abréviations *C-* pour *Control* plus une autre touche et *M-* pour *Meta* plus une autre touche. Par exemple, si un raccourci consiste à maintenir enfoncées à la fois *meta* et *r*, nous l'écrirons *M-r*. Le *-* veut dire simplement "en même temps que."

Voici ci-dessous les raccourcis que j'estime les plus utiles.

## Arrêter et démarrer

Au lieu de toujours attraper la souris pour exécuter votre code, vous pouvez simplement presser `M-r`. Similairement, pour stopper l'exécution de votre code, vous pouvez presser `M-s`.

## Navigation

Je suis vraiment perdu sans les raccourcis de navigation. Je recommande donc vivement que vous passiez du temps à les apprendre. Ces raccourcis fonctionnent aussi extrêmement bien quand vous apprenez à taper sans regarder le clavier parce qu'ils utilisent des lettres standards sans nécessiter de déplacer votre main jusqu'à la souris ou jusqu'aux touches flèches de votre clavier.

Vous pouvez vous déplacer au début de la ligne avec `C-a`, à la fin de la ligne avec `C-e`, à la ligne du dessus avec `C-p`, à la ligne du dessous avec `C-n`, avancer d'un caractère avec `C-f` et reculer d'un caractère avec `C-b`. Vous pouvez même effacer tous les caractères depuis le curseur jusqu'à la fin de la ligne avec `C-k`.

## Code ordonné

Pour aligner et indenter automatiquement vos lignes de code, pressez `M-m`.

## Système d'aide

Pour afficher/cacher le système d'aide vous pouvez presser `M-i`. Toutefois, un raccourci plus utile à connaître est `C-i`. Il détecte le mot où se trouve le curseur et affiche la documentation le concernant s'il la trouve. Aide instantanée !

Pour une liste complète, jetez un œil à la section B.2 - Antisèche des raccourcis.
