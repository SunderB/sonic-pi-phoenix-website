A.18 Design du son - Synthèse additive

# Synthèse additive

Ceci est le premier d'une courte série d'articles sur comment utiliser Sonic Pi pour le design du son. Nous allons faire un tour rapide d'un nombre de techniques différentes disponibles pour fabriquer votre propre son unique. La première technique que nous allons regarder est appelée *synthèse additive*. Cela peut sembler compliqué - mais si nous développons chaque mot légèrement, la signification en ressort rapidement. Premièrement, additif signifie une combinaison de choses et deuxièmement, synthèse signifie de créer un son. Ainsi, la synthèse additive ne signifie rien de plus compliqué que *combiner des sons existants pour en créer des nouveaux*. Cette technique de synthèse date de très longtemps - par exemple, les orgues du Moyen Âge avaient beaucoup de tuyaux sonnant légèrement différents que vous pouviez activer ou désactiver avec des arrêts. Tirer sur l'arrêt pour un certain tuyau 'l'ajoutait au mélange' ce qui rendait le son plus riche et complexe. Maintenant, voyons comment nous pouvons tirer tous les arrêts avec Sonic Pi.


## Combinaisons simples

Commençons avec le son le plus basique qu'il existe - l'humble onde sinusoïdale aux tons purs :

```
synth :sine, note: :d3
```

Maintenant, voyons comment cela sonne combiné avec une onde carrée :

```
synth :sine, note: :d3
synth :square, note: :d3
```

Remarquez comment les deux sons se combinent pour former un nouveau son plus riche. Bien sûr, nous n'avons pas à nous arrêter là, nous pouvons ajouter autant de sons que nous avons besoin. Cependant, nous devons être prudent avec combien de sons nous ajoutons ensemble. Tout comme lorsque nous mélangeons des peintures ensembles pour créer de nouvelles couleurs, ajouter trop de couleurs résultera en un brun laid, similairement - ajouter trop de sons ensemble résultera en un son boueux.


## Mélange

Ajoutons quelque chose pour le faire sonner un peu plus clair. Nous pourrions utiliser une onde triangulaire à une octave supérieure ( pour ce haut son clair) encore le jouer seulement à un amplificateur de `0.4` pour qu'il ajoute quelque chose d'extra au son au lieu de le remplacer :

```
synth :sine, note: :d3
synth :square, note: :d3
synth :tri, note: :d4, amp: 0.4
```

Maintenant, essayez de créer vos propres sons en combinant 2 synthés ou plus à des octaves et des amplitudes différentes. Également, notez que vous pouvez jouer avec les options de chaque synthé en modifiant chaque source avant qu'elle soit mélangée pour encore plus de combinaisons de sons.


## Désaccordage

Jusqu'à maintenant, lorsque nous combinons nos différents synthés nous avons utilisé soit le même ton ou une octave changée. Comment cela peut-il sonner si nous ne nous n'en tenons pas qu'aux octaves et que nous choisissons à la place une note légèrement plus aiguë ou grave ? Essayons-le :

```
detune = 0.7
synth :square, note: :e3
synth :square, note: :e3 + detune
```

Si nous désaccordons nos ondes carrées par 0.7 note, nous entendrons quelque chose qui ne sonnera pas accordé ou correct - une 'mauvaise' note. Cependant, en se rapprochant de 0, cela va sonner de moins en moins en désaccord alors que les tons des deux ondes se rapprochent et sont plus similaires. Essayez-le par vous-même ! Changer la valeur de l'option `detune:` de `0.7` à `0.5` et écoutez le nouveau son. Essayer `0.2`, `0.1`, `0.05`, `0`. Chaque fois que vous changez la valeur, écoutez et voyez si vous êtes capables de déterminer comment le son change. Remarquez que les valeurs basses de désaccordage comme `0.1` produisent un très beau son `dense`, avec deux tons différents qui interagissent l'un avec l'autre de manière intéressante, parfois surprenante.

Certains des synthés intégrés proposent déjà une option de "désaccord" qui fait exactement cela en un seul synthé. Essayer de jouer avec l'option de `detune:` de `:dsaw`, `:dpulse` et `:dtri`.


## Façonner l'amplitude

Une autre manière de fabriquer notre son finement est d'utiliser une enveloppe différente et des options pour chaque déclenchement de synthé. Par exemple, cela vous permettra de rendre certains aspects du son percutant et d'autres aspects résonner pour une période de temps.

```
detune = 0.1
synth :square, note: :e1, release: 2
synth :square, note: :e1 + detune, amp: 2, release: 2
synth :gnoise, release: 2, amp: 1, cutoff: 60
synth :gnoise, release: 0.5, amp: 1, cutoff: 100
synth :noise, release: 0.2, amp: 1, cutoff: 90
```

Dans l'exemple ci-dessus, j'ai mélangé un élément de bruit percutant dans le son avec quelques grondements de fond plus persistants. Cela a été réalisé en utilisant deux bruits de synthés avec des valeurs (`90` et `100`) de coupures de milieu en utilisant de courts repos avec un plus long temps de repos mais avec une basse valeur de coupure (ce qui rend le son moins impeccable et plus grondant.)

## Rassemblons tout

Let's combine all these techniques to see if we can use additive synthesis to re-create a basic bell sound. I've broken this example into four sections. Firstly we have the 'hit' section which is the initial onset part of the bell sound - so uses a short envelope (e.g. a `release:` of around `0.1`). Next we have the long ringing section in which I'm using the pure sound of the sine wave. Notice that I'm often increasing the note by roughly `12` and `24` which are the number of notes in one and two octaves. I have also thrown in a couple of low sine waves to give the sound some bass and depth. Finally, I used `define` to wrap my code in a function which I can then use to play a melody. Try playing your own melody and also messing around with the contents of the `:bell` function until you create your own fun sound to play with!

```
define :bell do |n|
  # Ondes en triangle pour la "percussion"
  synth :tri, note : n - 12, release : 0.1
  synth :tri, note : n + 0.1, release : 0.1
  synth :tri, note : n - 0.1, release : 0.1
  synth :tri, note : n, release : 0.2
  # Ondes en forme sinusoïdales pour le "tintement"
  synth :sine, note : n + 24, release : 2
  synth :sine, note : n + 24.1, release : 2
  synth :sine, note : n + 24.2, release : 0.5
  synth :sine, note : n + 11.8, release : 2
  synth :sine, note : n, release : 2
  # Ondes sinusoïdales lentes pour les basses
  synth :sine, note : n - 11.8, release : 2
  synth :sine, note : n - 12, release : 2
end
# joue une melodie avec notre nouvelle cloche
bell :e3
sleep 1
bell :c2
sleep 1
bell :d3
sleep 1
bell :g2
```
