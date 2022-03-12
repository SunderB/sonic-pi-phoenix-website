A.1 Conseils pour Sonic Pi

# Les cinq meilleurs conseils

## 1. Il n'y a pas d'erreur

La plus importante leçon à apprendre avec Sonic Pi, c'est qu'il n'y a pas vraiment d'erreur. La meilleure façon d'apprendre, c'est juste d'essayer, essayer, et essayer. Essayez beaucoup de choses différentes, ne vous inquiétez pas de savoir si votre code sonne bien ou pas, et commencez par expérimenter avec le plus de synthés, de notes, d'effets et d'options possibles. Vous découvrirez beaucoup de choses qui vous feront rire parce qu'elles ne sonnent pas bien du tout et aussi quelques joyaux qui sonnent magnifiquement bien. Débarrassez-vous ensuite de ce que vous n'aimez pas et gardez les choses qui vous plaisent. Plus vous vous permettrez de faire des 'erreurs' et plus vite vous apprendrez et découvrirez votre son personnel de programmation interactive.


## 2. Utilisez les effets

Disons que vous maîtrisez déjà les bases de Sonic Pi pour créer des sons avec `sample` et `play`. Qu'est-ce qui vient ensuite ? Savez-vous que Sonic Pi supporte plus de 27 effets studio pour modifier le son de votre code ? Les effets sont comme des filtres pour images dans les programmes de dessin, mais à la place de rendre l'image floue ou noir et blanc, on peut ajouter de la réverbération, de la distorsion ou de l'écho à votre son. On peut voir ça comme brancher le câble d'une guitare dans une pédale d'effet de votre choix puis dans un ampli. Heureusement, Sonic Pi rend l'utilisation d'effets très simple et n'a pas besoin de câble ! Tout ce dont vous avez besoin c'est de choisir à quelle section de votre code ajouter l'effet puis de l'emballer avec le code de l'effet. Prenons un exemple. Disons que vous avez le code suivant :

```
sample :loop_garzul
16.times do
  sample :bd_haus
  sleep 0.5
end
```

Si vous voulez ajouter un effet à l'échantillon `:loop_garzul`, il suffit de le mettre dans un bloc `with_fx` comme ceci :

```
with_fx :flanger do
  sample :loop_garzul
end
16.times do
  sample :bd_haus
  sleep 0.5
end
```

Maintenant, si voulez ajouter un effet au tambour basse, enveloppez-le aussi dans un `with_fx` :

```
with_fx :flanger do
  sample :loop_garzul
end 
with_fx :echo do
  16.times do
    sample :bd_haus
    sleep 0.5
  end
end
```

Rappelez-vous, vous pouvez entourer *n'importe quel* code dans `with_fx` et tous les sons créés passeront dans cet effet.


## 3. Paramétrez vos synthés

Pour découvrir vraiment le son de votre code, vous voudrez bientôt savoir comment modifier et contrôler les synthés et effets. Par exemple, vous voudrez peut-être changer la durée d'une note, ajouter plus de réverb, ou changer la durée entre les échos. Heureusement, Sonic Pi vous donne un niveau de contrôle incroyable pour faire exactement cela avec des trucs appelés des paramètres optionnels ou opts pour faire court. Jetons-y un coup d'œil rapide. Copiez ce code dans un espace de travail et exécutez-le :

```
sample :guit_em9
```

Oh, un joli son de guitare ! Commençons à jouer un peu avec. Et si on changeait son taux ?

```
sample :guit_em9, rate: 0.5
```

Hé, qu'est-ce que ce `rate: 0.5` que j'ai ajouté à la fin ? C'est ce qu'on appelle une opt. Tous les synthés et effets de Sonic Pi les supportent et il y en a beaucoup avec lesquels on peut jouer. Ils sont disponibles pour les effets aussi. Essayez ceci :

```
with_fx :flanger, feedback: 0.6 do
  sample :guit_em9
end
```

Now, try increasing that feedback to 1 to hear some fun sounds! Read the docs for full details on all the many opts available to you.


## 4. Coder en direct

La meilleure manière d'expérimenter rapidement et d'explorer Sonic Pi est de coder de manière interactive. Cela vous permet de partir d'un peu de code et de le changer de manière continue pendant qu'il est en train de s'exécuter. Par exemple, si vous ne savez pas ce que le paramètre cutoff fait à un échantillon, jouez avec. Essayons ! Copiez ce code dans un de vos espaces de travail Sonic Pi :

```
live_loop :experiment do
  sample :loop_amen, cutoff: 70
  sleep 1.75
end
```

Maintenant, cliquez sur 'Run' et vous entendrez un rythme de batterie un peu étouffé. Maintenant, changez la valeur de `cutoff:` pour `80` et cliquez à nouveau sur 'Run'. Entendez-vous la différence ? Essayez `90`, `100`, `110`...

Quand vous aurez pris la main à utiliser des `live_loop`, vous ne pourrez plus vous en passer. À chaque fois que je donne un concert de programmation interactive, je m'appuie autant sur `live_loop` qu'un batteur sur ses baguettes. Pour plus d'informations à propos de la programmation interactive, regardez la section 9 du tutoriel inclus.

## 5. Surfez sur les flux aléatoires

Enfin, une chose que j'adore faire est de tricher en faisant en sorte que Sonic Pi compose des choses pour moi. Une manière géniale de faire ça est d'utiliser l'aléation. Cela peut paraître compliqué, mais ça ne l'est pas du tout. Regardons. Copiez ceci dans un espace de travail :

```
live_loop :rand_surfer do
  use_synth :dsaw
  notes = (scale :e2, :minor_pentatonic, num_octaves: 2)
  16.times do
    play notes.choose, release: 0.1, cutoff: rrand(70, 120)
    sleep 0.125
  end
end
```

Maintenant, quand vous jouez ceci, vous entendrez une suite continue de notes aléatoires de la gamme `:e2 :minor_pentatonic` jouée avec le synthé `:dsaw`. "Attendez, attendez ! Ce n'est pas une mélodie", vous entends-je crier ! Eh bien, voici la première partie du tour de magie. Chaque fois que l'on recommence le `live_loop` on peut dire à Sonic Pi de réinitialiser la suite aléatoire à un point connu. C'est un peu comme voyager dans le temps dans le TARDIS avec le Docteur vers un point particulier du temps et de l'espace. Essayons ceci : ajoutez la ligne `use_random_seed 1` au `live_loop`:

```
live_loop :rand_surfer do
  use_random_seed 1
  use_synth :dsaw
  notes = (scale :e2, :minor_pentatonic, num_octaves: 2)
  16.times do
    play notes.choose, release: 0.1, cutoff: rrand(70, 120)
    sleep 0.125
  end
end
```

Maintenant, chaque fois que la boucle `live_loop` tourne, la suite aléatoire est réinitialisée. Ceci signifie qu'elle contient exactement les même 16 notes à chaque fois. Et voilà ! Une mélodie de composée. Et maintenant, voici la partie vraiment excitante. Changez la valeur de graine de `1` pour un autre nombre. Par exemple `4923`. Ouaouh, une autre mélodie ! Donc, en changeant uniquement un nombre (la graine aléatoire), on peut explorer autant de combinaisons mélodiques qu'on peut imaginer ! C'est ça la magie du code.
