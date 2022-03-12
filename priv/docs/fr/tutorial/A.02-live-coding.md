A.2 Programmation interactive

# Programmation interactive (Live Coding)

The laser beams sliced through the wafts of smoke as the subwoofer pumped bass deep into the bodies of the crowd. The atmosphere was ripe with a heady mix of synths and dancing. However something wasn't quite right in this nightclub. Projected in bright colours above the DJ booth was futuristic text, moving, dancing, flashing. This wasn't fancy visuals, it was merely a projection of Sonic Pi running on a Raspberry Pi. The occupant of the DJ booth wasn't spinning disks, they wrote, edited and evaluated code. Live. This is Live Coding.

![Programmation interactive de Sam Aaron](../../../etc/doc/images/tutorial/articles/A.02-live-coding/sam-aaron-live-coding.png)

Cela peut sonner comme une histoire tirée par les cheveux dans une boîte de nuit futuriste mais coder de la musique comme cela est une tendance qui se développe et qu'on appelle souvent Live Coding (programmation interactive) (http://toplap.org). Une des directions récentes que cette approche de la musique a prise est l'Algorave (http://algorave.com) : des événements où des artistes comme moi codent de la musique pour que les gens dansent. Cependant vous n'avez pas besoin d'une boîte de nuit pour coder en live : avec Sonic Pi version 2.6 et plus vous pouvez le faire dans n'importe quel endroit où vous pouvez prendre votre Raspberry Pi et un casque ou des haut-parleurs. Quand vous aurez atteint la fin de cet article, vous saurez programmez vos rythmes et les modifier en direct. Où vous irez ensuite ne sera limité que par votre imagination.

## Boucle interactive

La clef de la programmation interactive avec Sonic Pi est la maîtrise de la `live_loop`. En voici une :

```
live_loop :beats do
  sample :bd_haus
  sleep 0.5
end
```

There are 4 core ingredients to a `live_loop`. The first is its name. Our `live_loop` above is called `:beats`. You're free to call your `live_loop` anything you want. Go wild. Be creative. I often use names that communicate something about the music they're making to the audience. The second ingredient is the `do` word which marks where the `live_loop` starts. The third is the `end` word which marks where the `live_loop` finishes, and finally there is the body of the `live_loop` which describes what the loop is going to repeat - that's the bit between the `do` and `end`. In this case we're repeatedly playing a bass drum sample and waiting for half a beat. This produces a nice regular bass beat. Go ahead, copy it into an empty Sonic Pi buffer and hit run. Boom, Boom, Boom!.

## Redéfinir à la volée

OK, qu'est-ce qu'elle a de si spécial, cette `live_loop` ? Jusqu'ici, on dirait que c'est juste une boucle idéalisée ! Eh bien, la beauté des `live_loop`, c'est qu'on peut les redéfinir à la volée. Ceci signifie que, pendant qu'elles sont en train de tourner, on peut changer ce qu'elles font. C'est le secret de la programmation interactive avec Sonic Pi. Essayons :

```
live_loop :choral_drone do
  sample :ambi_choir, rate: 0.4
  sleep 1
end
```

Maintenant cliquez le bouton 'Run' ou tapez 'alt-r'. Vous entendez maintenant de beaux sons de chœurs . Ensuite, alors qu'il est encore en train de jouer, changez la fréquence de `0.4` en `0.38`. Cliquez à nouveau sur 'Run'. Whaou ! Vous avez entendu le chœur changer de note ? Ecrivez à nouveau `0.4` pour revenir comme avant. Puis `0.2`, puis `0.19`, puis à nouveau `0.4`. Voyez-vous que juste en changeant un paramètre à la volée permet de contrôler la musique ? Maintenant jouez vous-même avec la fréquence, choisissez vos propres valeurs. Essayez des nombres négatifs, de très petits nombres et de grands nombres. Amusez-vous !

## Il est important de dormir

Une des leçons les plus importantes avec les `live_loop`, c'est qu'elles ont besoin de se reposer. Prenons par exemple cette `live_loop`:

```
live_loop :infinite_impossibilities do
  sample :ambi_choir
end
```

Si vous essayez d'exécuter ce code, vous verrez immédiatement que Sonic Pi se plaint que la `live_loop` n'a pas dormi. C'est un mécanisme de sécurité qui se met en place. Prenons un moment pour penser à ce que ce code demande à l'ordinateur de faire. C'est cela, on demande à l'ordinateur de jouer un nombre infini de samples de chorale dans un temps nul. Sans le mécanisme de sécurité le pauvre ordinateur essaierait de faire ça et exploserait. Souvenez-vous en bien : vos `live_loop`s doivent contenir un appel à `sleep`.


## Combiner des sons

La musique est pleine de choses qui arrivent en même temps. La batterie en même temps que la basse, en même temps que du chant, en même temps que des guitares... En informatique on appelle ça la concurrence et Sonic Pi nous donne une manière étonnamment simple de jouer des choses en même temps. Il suffit d'utiliser plus qu'une `live_loop` !

```
live_loop :beats do
  sample :bd_tek
  with_fx :echo, phase: 0.125, mix: 0.4 do
    sample  :drum_cymbal_soft, sustain: 0, release: 0.1
    sleep 0.5
  end
end
live_loop :bass do
  use_synth :tb303
  synth :tb303, note: :e1, release: 4, cutoff: 120, cutoff_attack: 1
  sleep 4
end
```

Here, we have two `live_loop`s, one looping quickly making beats and another looping slowly making a wild bass sound.

Une des choses intéressantes quand on utilise plusieurs `live_loop`, c'est que chacune gère son propre temps. Cela signifie qu'il est très facile de créer des structures polyrythmiques intéressantes et même de jouer avec la phase, style Steve Reich. Par exemple :

```
# La phase de piano de Steve Reich
notes = (ring :E4, :Fs4, :B4, :Cs5, :D5, :Fs4, :E4, :Cs5, :B4, :Fs4, :D5, :Cs5)
live_loop :slow do
  play notes.tick, release: 0.1
  sleep 0.3
end
live_loop :faster do
  play notes.tick, release: 0.1
  sleep 0.295
end
```

## Rassemblons tout

Dans chacun de ces tutoriels, nous finirons avec un exemple qui montre un nouveau morceau de musique qui utilise toutes les idées introduites. Lisez ce code et essayez d'imaginer ce qu'il fait. Ensuite, copiez-le dans un buffer frais de Sonic Pi et cliquez 'Run' pour entendre comment il sonne. Enfin changez un des nombres ou commentez / décommentez des parties. Voyez si vous pouvez prendre ça comme point de départ d'une nouvelle performance, et surtout amusez-vous ! A la prochaine...

```
with_fx :reverb, room: 1 do
  live_loop :time do
    synth :prophet, release: 8, note: :e1, cutoff: 90, amp: 3
    sleep 8
  end
end
live_loop :machine do
  sample :loop_garzul, rate: 0.5, finish: 0.25
  sample :loop_industrial, beat_stretch: 4, amp: 1
  sleep 4
end
live_loop :kik do
  sample :bd_haus, amp: 2
  sleep 0.5
end
with_fx :echo do
  live_loop :vortex do
    # use_random_seed 800
    notes = (scale :e3, :minor_pentatonic, num_octaves: 3)
    16.times do
      play notes.choose, release: 0.1, amp: 1.5
      sleep 0.125
    end
  end
end
```
