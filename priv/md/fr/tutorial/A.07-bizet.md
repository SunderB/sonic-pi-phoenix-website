A.7 Battements de Bizet

# Battements de Bizet

Après notre brève excursion dans le monde fantastique de la programmation Minecraft avec Sonic Pi le mois dernier, penchons-nous à nouveau sur la musique. Aujourd'hui nous allons amener un morceau classique de danse d'opéra droit dans le 21ème siècle en utilisant la puissance impressionnante du code.

## Scandaleux et Perturbateur

Sautons dans une machine à remonter le temps jusqu'en 1875. Un compositeur nommé Bizet avait juste terminé son dernier opéra : Carmen. Malheureusement comme beaucoup de nouveaux morceaux innovants et perturbateurs, les gens ne les aimaient pas du tout puisqu'ils les trouvaient trop choquants et différents. Malheureusement Bizet est mort dix ans avant que l'opéra ne connaisse un succès international et ne devienne l'un des opéras les plus connus et les plus fréquemment interprétés de tous les temps. Par sympathie pour cette tragédie, nous allons prendre un des thèmes principaux de Carmen et nous allons le convertir dans un format moderne de musique qui est aussi trop innovant et pertubateur pour la plupart des gens de notre époque : la musique codée interactive !

## La Habanera décryptée

Essayer de programmer un opéra entier de manière interactive serait un peu trop ambitieux pour ce tutoriel. Concentrons nous plutôt sur une des ses plus célèbres parties : la ligne de basse de la Habanera :

![Riff Habanera](../../../etc/doc/images/tutorial/articles/A.07-bizet/habanera.png)

Cela peut vous sembler complètement illisible si vous n'avez pas étudié la notation musicale. Cependant, en tant que programmeurs nous voyons la notation musicale comme juste une autre forme de code, elle représente juste des instructions pour un musicien au lieu d'un ordinateur. C'est pourquoi nous devons trouver un moyen de la décoder.

## Notes

Les notes sont arrangées de gauche à droite comme les mots dans ce magazine mais elles ont aussi des hauteurs différentes. *La position verticale en hauteur sur la partition représente la hauteur d'une note.* Plus haute est la note sur la partition, plus la hauteur de la note est élevée.

Dans Sonic Pi nous savons déjà comment changer la hauteur d'une note : on peut utiliser des grands ou petits nombres comme `play 75` et `play 80` ou on peut utiliser les noms des notes : `play :E` et `play :F`. Heureusement chacune des positions verticales sur la partition représente un nom de note en particulier. Jetez un œil à cette table de correspondance bien pratique :

![Notes](../../../etc/doc/images/tutorial/articles/A.07-bizet/notes.png)

## Silences

Les partitions sont une sorte de code extrêmement riche et expressif capable de communiquer de nombreuses choses. Cela ne devrait donc pas nous surprendre que les partitions peuvent non seulement nous dire quelles notes jouer mais aussi quand *ne pas* jouer de note. En programmation c'est à peu près l'équivalent de l'idée de `nil` ou `null` : l'absence de valeur. En d'autres termes, ne pas jouer une note, c'est comme une absence de note.

Si vous regardez de près la partition, vous verrez que c'est en fait une combinaison de ronds noirs avec des barres qui représentent les notes à jouer et des choses ondulées qui représentent les silences. Heureusement, Sonic Pi a une notation très pratique pour un silence : `:r`, donc si on exécute `play :r` il jouera en fait un silence ! On pourrait aussi écrire `play :rest`, `play nil` ou `play false` qui sont autant de manières équivalentes de représenter un silence.

## Rythme

Enfin, il y a une dernière chose à apprendre à décoder dans la notation : la notion de durée des notes. Dans la notation originale vous verrez que les notes sont liées par des traits épais. La deuxième note a deux de ces traits ce qui veut dire qu'elle dure un 16ème de temps. Les autres notes ont un seul trait ce qui veut dire qu'elles durent un 8ème de temps. Le silence a aussi deux traits ondulés ce qui veut dire qu'il représente aussi un 16ème de temps.

Quand on essaie de décoder et d'explorer de nouvelles choses, un truc très pratique est de faire en sorte que tout se ressemble le plus possible pour essayer de voir des relations ou des modèles. Par exemple, lorsqu'on réécrit notre notation uniquement en double-croches, vous pouvez voir que notre notation se transforme en une belle séquence de notes et de silences.

![Riff Habanera 2](../../../etc/doc/images/tutorial/articles/A.07-bizet/habanera2.png)

## Recodage de la Habanera

Nous sommes maintenant prêt à commencer la traduction de cette ligne de basse en Sonic Pi. Encodons ces notes et silences dans un anneau :

```
(ring :d, :r, :r, :a, :f5, :r, :a, :r)
```
    
Voyons comment ça sonne. Jetons ça dans une boucle interactive et parcourons-là :

```
live_loop :habanera do
  play (ring :d, :r, :r, :a, :f5, :r, :a, :r).tick
  sleep 0.25
end
```
    
Fabuleux, cette mélodie qu'on reconnaît immédiatement prend vie dans vos haut-parleurs. On a fait de gros efforts pour en arriver là, mais ça valait la peine, bien joué !
    
## Synthés grincheux

Maintenant qu'on a la ligne de basse, essayons de recréer une partie de l'ambiance de la scène d'opéra. Un synthé à essayer est `:blade` qui est un synthé style années 80. Essayons-le avec la note de départ `:d` passée dans un slicer et de la réverb :

```
live_loop :habanera do
  use_synth :fm
  use_transpose -12
  play (ring :d, :r, :r, :a, :f5, :r, :a, :r).tick
  sleep 0.25
end
with_fx :reverb do
  live_loop :space_light do
    with_fx :slicer, phase: 0.25 do
      synth :blade, note: :d, release: 8, cutoff: 100, amp: 2
    end
    sleep 8
  end
end
```

Maintenant essayez les autres notes de la ligne de basse : `:a` et `:f5`. Souvenez-vous que vous n'avez pas besoin de cliquer sur 'Stop', vous pouvez juste modifier le code pendant que la musique tourne et ensuite cliquer sur 'Run' à nouveau. Aussi essayez différentes valeurs pour l'option `phase:` du slicer comme `0.5`, `0.75` et `1`.

## Rassemblons tout

Enfin, combinons toutes les idées vues jusqu'ici dans un nouveau remix de la Habanera. Vous remarquerez peut-être que j'ai inclus une autre partie de la ligne de basse en commentaire. Quand vous aurez tout tapé dans un tampon de libre, cliquez sur 'Run' pour entendre la composition. Maintenant, sans cliquer sur 'Stop', *décommentez* la seconde ligne en enlevant le `#` et cliquez sur 'Run' à nouveau : c'est merveilleux, non ? Maintenant amusez-vous à le modifier vous-même.

```
use_debug false
bizet_bass = (ring :d, :r, :r, :a, :f5, :r, :a, :r)
#bizet_bass = (ring :d, :r, :r, :Bb, :g5, :r, :Bb, :r)
 
with_fx :reverb, room: 1, mix: 0.3 do
  live_loop :bizet do
    with_fx :slicer, phase: 0.125 do
      synth :blade, note: :d4, release: 8,
        cutoff: 100, amp: 1.5
    end
    16.times do
      tick
      play bizet_bass.look, release: 0.1
      play bizet_bass.look - 12, release: 0.3
      sleep 0.125
    end
  end
end
 
live_loop :ind do
  sample :loop_industrial, beat_stretch: 1,
    cutoff: 100, rate: 1
  sleep 1
end
 
live_loop :drums do
  sample :bd_haus, cutoff: 110
  synth :beep, note: 49, attack: 0,
    release: 0.1
  sleep 0.5
end
```
