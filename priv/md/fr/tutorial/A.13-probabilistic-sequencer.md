A.13 Coder un séquenceur probabiliste

# Coder un séquenceur probabiliste

Dans les épisodes précédents de cette série sur Sonic PI, nous avons exploré la puissance de l'aléatoire pour introduire de la variété, de la surprise et du changement dans nos pistes et nos représentations de Live Coding. Par exemple, nous avons choisi aléatoirement des notes d'une gamme pour créer des mélodies sans fin. Aujourd'hui, nous allons apprendre une nouvelle technique qui utilise l'aléatoire pour le rythme - les rythmes probabilistes !

## Probabilité

Avant de pouvoir commencer à faire de nouveaux rythmes et des rythmes de synthé, nous devons faire un plongeon rapide dans les bases de la probabilité. Cela peut sembler intimidant et compliqué, mais vraiment c'est aussi simple que de lancer un dé - honnêtement ! Lorsque vous prenez un dé régulier à 6 faces d'un jeu de société et le lancez, que se passe-t'il réellement ? Eh bien, tout d'abord, vous allez tomber sur 1, 2, 3, 4, 5 ou 6 avec exactement la même chance d'obtenir l'un des numéros. En fait, étant donné que c'est un dé à 6 côtés, en moyenne (si vous lancez de nombreuses fois), vous allez tomber sur un 1 tous les 6 lancers. Cela signifie que vous avez une chance sur 6 de lancer un 1. Nous pouvons émuler le lancement de dés dans Sonic Pi avec le fn 'dice'. Jetons-en un 8 fois :

```
8.times do
  puts dice
  sleep 1
end
```

Remarquez comme le journal affiche des valeurs entre 1 et 6 comme si nous avions lancé nous-même un dé.

## Rythmes aléatoires

Maintenant, imaginez vous avez un tambour et chaque fois que vous êtes sur le point de le frapper, vous lancez un dé. Si vous tirez un 1, vous frappez le tambour sinon, autre valeur que 1, vous ne frappez pas. Vous avez maintenant une boîte à rythmes probabiliste qui fonctionne avec une probabilité de 1/6 ! Écoutons à quoi ça ressemble :

```
live_loop :random_beat do
  sample :drum_snare_hard if dice == 1
  sleep 0.125
end
```


Passons en revue rapidement chaque ligne pour nous assurer que tout est parfaitement clair. Tout d'abord, nous créons une nouvelle `live_loop` appelée `:random_beat` qui va continuellement répéter les deux lignes entre `do` et `end`. La première de ces lignes est un appel à `sample` qui jouera un son préenregistré (le son `:drum_snare_hard` dans ce cas). Cependant, cette ligne a une fin conditionnelle spéciale `if`. Cela signifie que la ligne ne sera exécutée que si la déclaration située à droite du `if` («si») est `true` («vraie»). Dans ce cas, la déclaration est `dice == 1`. C'est ce qu'on appelle notre fonction `dice` qui, comme nous l'avons vu, renvoie une valeur comprise entre 1 et 6. Nous utilisons ensuite l'opérateur d'égalité `==` pour vérifier si cette valeur est `1`. Si c'est `1`, alors le test d'égalité est vrai, `true`, et notre caisse claire sonne. Si ce n'est pas `1` alors le test d'égalité n'est pas vérifié, il est faux, `false`, et la caisse claire est ignorée. La deuxième ligne attend simplement `0.125` secondes avant de lancer à nouveau les dés.

## Changer les probabilités

Ceux d'entre vous qui ont joué des jeux de rôle seront familiers avec beaucoup de dés de forme étrange avec différentes étendues de numéros. Par exemple, il y a le dé en tétraèdre qui a 4 côtés ou encore un dé de 20 côtés en forme d'icosaèdre. Le nombre de côtés sur les dés change la chance, ou la probabilité de tomber sur un 1. Moins il y a de côtés, plus vous avez de chances d'afficher un 1 et plus il y a de côtés, moins c'est probable. Par exemple, avec un dé à 4 côtés, il y a une chance sur 4 de lancer un 1 et avec un dé de 20 côtés il y a une chance sur 20. Heureusement, Sonic Pi a le très pratique «one_in» fn pour décrire exactement cela. Jouons :

```
live_loop :different_probabilities do
  sample :drum_snare_hard if one_in(6)
  sleep 0.125
end
```

Lancez la boucle ci-dessus et vous pourrez entendre un rythme aléatoire familier. Cependant, n'arrêtez pas l'exécution du code. Au lieu de cela, changez le `6` pour une valeur différente comme `2` ou `20` et appuyez de nouveau sur le bouton `Run`. Constatez que des nombres inférieurs signifient que le son de caisse claire sera plus fréquent et que des nombres supérieurs signifie que la caisse clair est jouée moins fréquemment. Vous faites de la musique avec des probabilités !

## Combiner les probabilités

Les choses deviennent vraiment excitantes quand plusieurs échantillons sont joués avec des probabilités différentes. Par exemple :

```
live_loop :multi_beat do
  sample :elec_hi_snare if one_in(6)
  sample :drum_cymbal_closed if one_in(2)
  sample :drum_cymbal_pedal if one_in(3)
  sample :bd_haus if one_in(4)
  sleep 0.125
end
```

De nouveau, exécutez le code ci-dessus et commencez à changer les probabilités pour modifier le rythme. De plus, essayez de changer les échantillons pour créer une sensation entièrement nouvelle. Par exemple, essayez de changer `:drum_cymbal_closed` par `:bass_hit_c` pour obtenir plus de basse !


## Rythmes répétables

Ensuite, nous pouvons utilisez notre vieil ami `use_random_seed` pour réinitialiser le générateur aléatoire après 8 itérations pour créer un rythme régulier. Tapez le code suivant pour entendre un rythme beaucoup plus régulier et répétitif. Une fois que vous entendez le rythme, essayez de remplacer la valeur `1000` par un autre nombre. Remarquez comme des nombres différents génèrent des rythmes différents.

```
live_loop :multi_beat do
  use_random_seed 1000
  8.times do
    sample :elec_hi_snare if one_in(6)
    sample :drum_cymbal_closed if one_in(2)
    sample :drum_cymbal_pedal if one_in(3)
    sample :bd_haus if one_in(4)
    sleep 0.125
  end
end
```

Une chose que j'ai tendance à faire avec ce genre de structures, c'est de me rappeler quelles graines aléatoires sonnent bien et de les noter. De cette manière, je peux facilement recréer mes rythmes dans des sessions d'entrainement ou des représentations futures.

## Rassemblons tout

Finalement, nous pouvons ajouter un peu de basse aléatoire pour lui donner un contenu mélodique sympa. Vous pourrez remarquer que nous pouvons aussi utiliser notre méthode de séquençage probabiliste récemment découverte sur les synthés comme sur les échantillons. Nous vous arrêtez pas là pour autant - ajuster les nombres et faites votre propre piste grâce au pouvoir des probabilités !

```
live_loop :multi_beat do
  use_random_seed 2000
  8.times do
    c = rrand(70, 130)
    n = (scale :e1, :minor_pentatonic).take(3).choose
    synth :tb303, note: n, release: 0.1, cutoff: c if rand < 0.9
    sample :elec_hi_snare if one_in(6)
    sample :drum_cymbal_closed if one_in(2)
    sample :drum_cymbal_pedal if one_in(3)
    sample :bd_haus, amp: 1.5 if one_in(4)
    sleep 0.125
  end
end
```
