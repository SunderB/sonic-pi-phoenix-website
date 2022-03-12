A.12 Tranchage d'échantillon

# Tranchage d'échantillon

Way back in episode 3 of this Sonic Pi series we looked at how to loop, stretch and filter one of the most famous drum breaks of all time - the Amen Break. In this tutorial we're going to take this one step further and learn how to slice it up, shuffle the slices and glue it back together in a completely new order. If that sounds a bit wild to you, don't worry, it will all become clear and you'll soon master a powerful new tool for your live coded sets.

## Le son en tant que données

Avant de démarrer, prenons juste un petit moment pour comprendre comment travailler avec les échantillons. Maintenant, vous devriez tous avoir manipulé le puissant échantillonneur de Sonic Pi. Si ce n'est pas le cas, c'est le moment ! Démarrez votre Raspberry Pi, lancez Sonic Pi depuis le menu Programmation, tapez ce qui suit dans un tampon vide et appuyez sur le bouton Run pour entendre un rythme de batterie préenregistré :

```
sample :loop_amen
```

L'enregistrement d'un son est simplement représenté comme de la donnée - un tas de nombres entre -1 et 1 qui représentent les pics et creux de l'onde sonore. Si nous rejouons ces nombres dans l'ordre, nous obtenons le son original. Cependant, qu'est-ce qui nous empêche de les jouer dans un ordre différent pour créer un nouveau son ?

Comment sont réellement enregistrés les échantillons ? C'est en fait assez simple une fois que vous comprenez les bases physiques du son. Quand vous produisez un son - par exemple en frappant sur une batterie, le bruit voyage dans l'air d'une façon proche de celle des petites ondes dans un lac quand vous y jetez un caillou. Quand ces ondes atteignent vos oreilles, votre tympan bouge de façon synchrone et convertit ces mouvements en son que vous entendez. Si nous souhaitons enregistrer et rejouer le son, nous avons donc besoin d'un moyen de capturer, stocker et reproduire ces ondes. Une des méthodes est d'utiliser un microphone qui se comporte comme un tympan et effectue un va-et-vient lorsque les ondes sonores le touchent. Le microphone convertit ensuite sa position en un petit signal électrique qui est ensuite mesuré de nombreuses fois par seconde. Ces mesures sont ensuite représentées par une série de nombres compris entre -1 et 1.

Si nous devions tracer point par point une représentation visuelle du son, ce serait un simple graphique de données avec le temps sur l'axe x et la position du microphone/de l'enceinte comme une valeur entre -1 et 1 sur l'axe y. Vous pouvez voir un exemple d'un tel graphique en haut du diagramme.

## Jouer une partie d'un échantillon

Donc, comment coder dans Sonic Pi la lecture d'un échantillon dans un ordre différent ? Pour répondre à cette question, nous devons jeter un oeil sur les options `start:` et `finish:` de `sample`. Celles-ci nous permettent de contrôler les position de début et de fin de notre lecture des nombres qui représentent le son. Les valeurs de ces deux options sont représentées par un nombre entre `0` et `1` où `0` représente le début de l'échantillon et `1` en est la fin. Donc, pour jouer la première partie de l'Amen Break, nous devons simplement spécifier un `finish:` à `0.5` :

```
sample :loop_amen, finish: 0.5
```

Nous pouvons ajouter une valeur `start:` pour jouer une partie encore plus petite de l'échantillon :

```
sample :loop_amen, start: 0.25, finish: 0.5
```

Pour le plaisir, vous pouvez même avoir la valeur `finish:` inférieure à la valeur `start:` et il jouera la section à l'envers :

```
sample :loop_amen, start: 0.5, finish: 0.25
```

## Réordonner la lecture des échantillons

Maintenant que nous savons d'une part qu'un échantillon est simplement une liste de nombres qui peuvent être joués dans n'importe quel ordre et que d'autre part, nous savons comment jouer une partie spécifique d'un échantillon, nous pouvons désormais nous amuser à jouer un échantillon dans le 'mauvais' ordre.

![Amen Slices](../../../etc/doc/images/tutorial/articles/A.12-sample-slicing/amen_slice.png)

Prenons notre Amen Break et découpons-le en 8 tranches égales et mélangeons ensuite les morceaux. Regardez le diagramme : en haut A) représente le graphe des données originales de l'échantillon. Le découper en 8 tranches nous donne B) - notez que nous avons donné à chaque tranche une couleur différente pour aider à les distinguer. Vous pouvez voir les valeurs de début (`start`) et de fin (`finish`) en haut. Enfin C) est une réorganisation des tranches. Nous pouvons ensuite jouer ceci pour créer un nouveau rythme. Jetez un coup d’œil sur le code utilisé pour faire cela :

```
live_loop :beat_slicer do
  slice_idx = rand_i(8)
  slice_size = 0.125
  s = slice_idx * slice_size
  f = s + slice_size
  sample :loop_amen, start: s, finish: f
  sleep sample_duration :loop_amen, start: s, finish: f
end
```

1. Nous choisissons une tranche aléatoire à jouer, qui doit être un nombre aléatoire entre 0 et 7 (souvenez-vous que nous commençons à compter à partir de 0). Sonic Pi a une fonction pratique pour faire exactement cela : `rand_i(8)`. Nous stockons ensuite l'index de cette tranche aléatoire dans la variable `slice_idx`.
2. Nous définissons la taille notre tranche, `slice_size` à 1/8 soit 0.125. `slice_size` nous est nécessaire pour convertir l'index `slice_idx` en une valeur comprise entre 0 et 1 pour l'utiliser dans l'option `start:`.
3. Nous calculons la position de départ `s` en multipliant l'index `slice_idx` par la taille de la tranche `slice_size`.
4. Nous pouvons calculer la position finale de 'f' en ajoutant la 'slice_size' à la position de départ 's'.
5. Nous pouvons maintenant jouer la tranche d'échantillon en associant les valeurs `s` et `f` aux options `start:` et `finish:` de `sample`.
6. Avant de jouer la prochaine tranche, nous devons savoir pendant combien de temps faire une pause avec `sleep`, ce qui doit correspondre à la durée de la tranche d'échantillon. Heureusement, Sonic Pi s'en occupe avec la fonction `sample_duration`, qui accepte les mêmes options que `sample` et retourne simplement la durée. Par conséquent, en fournissant à `sample_duration` nos options `start:` et `finish:`, nous pouvons trouver la durée d'une tranche.
7. Nous enveloppons tout ce code dans une boucle `live_loop` pour que nous puissions continuer à choisir de nouvelles tranches à jouer.


## Rassemblons tout

Combinons tout ce que nous avons vu jusqu'à maintenant dans un dernier exemple, qui démontre comment nous pouvons utiliser une approche similaire pour combiner aléatoirement des morceaux de rythmes avec de la basse pour créer le début d'une piste intéressante. Maintenant c'est votre tour - prenez le code suivant comme point de départ et voyez si vous pouvez le modifier à votre façon pour créer quelque chose de nouveau...

```
live_loop :sliced_amen do
  n = 8
  s =  line(0, 1, steps: n).choose
  f = s + (1.0 / n)
  sample :loop_amen, beat_stretch: 2, start: s, finish: f
  sleep 2.0  / n
end
live_loop :acid_bass do
  with_fx :reverb, room: 1, reps: 32, amp: 0.6 do
    tick
    n = (octs :e0, 3).look - (knit 0, 3 * 8, -4, 3 * 8).look
    co = rrand(70, 110)
    synth :beep, note: n + 36, release: 0.1, wave: 0, cutoff: co
    synth :tb303, note: n, release: 0.2, wave: 0, cutoff: co
    sleep (ring 0.125, 0.25).look
  end
end
```
