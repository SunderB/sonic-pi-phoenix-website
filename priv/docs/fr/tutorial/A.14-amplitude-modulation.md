A.14 Modulation d'amplitude

# Modulation d'amplitude

Ce mois-ci nous allons plonger en profondeur dans l'un des effets les plus puissants et les plus flexibles de Sonic Pi - le `:slicer`. D'ici la fin de cet article, vous aurez appris comment manipuler le volume global de certaines parties de notre son codé en live de façons nouvelles et puissantes.

## Trancher cet ampli

Alors, que fait réellement l'effet `:slicer` ? Une façon de se le représenter est simplement comme quelqu'un qui joue avec le contrôle du volume de votre TV ou de votre chaîne hi-fi. Voyons cela, mais d'abord, écoutez le grognement profond produit par le code suivant qui utilise le synthé `:prophet` :

```
synth :prophet, note: :e1, release: 8, cutoff: 70
synth :prophet, note: :e1 + 4, release: 8, cutoff: 80
```

Maintenant, passons le à travers l'effet `:slicer` :

```

with_fx :slicer do
  synth :prophet, note: :e1, release: 8, cutoff: 70
  synth :prophet, note: :e1 + 4, release: 8, cutoff: 80
end
```

Écoutez comme le `:slicer` fait comme s'il coupait puis rétablissait le son à un rythme régulier. Observez aussi comme le `:slicer` affecte tout le son généré entre les blocs `do` et `end`. Vous pouvez contrôler la vitesse à laquelle il coupe et rétablit le son avec l'option `phase:` qui est l'abréviation de "durée de phase". Sa valeur par défaut est `0.25` ce qui signifie 4 fois par seconde au rythme par défaut de 60 BPM. Accélérons le :

```
with_fx :slicer, phase: 0.125 do
  synth :prophet, note: :e1, release: 8, cutoff: 70
  synth :prophet, note: :e1 + 4, release: 8, cutoff: 80
end
```

Maintenant, jouez avec différentes durées `phase :` vous-même. Essayez des valeurs de plus en plus courtes. Voyez ce qui se passe lorsque vous choisissez une valeur vraiment courte. Essayez également différents synthés tels que `:beep` ou`:dsaw` et différentes notes. Jetez un œil au diagramme suivant pour voir comment les différentes valeurs de `phase :` changent le nombre de changements d'amplitude par battement.

![Durée de Phase](../../../etc/doc/images/tutorial/articles/A.14-amplitude-modulation/slicer_phase_durations.png)

La durée de phase est la durée d'un cycle on/off. De ce fait, des valeurs plus petites feront que l'effet alternera entre on et off beaucoup plus rapidement qu'avec des valeurs plus grandes. De bonnes valeurs pour commencer à jouer sont `0.125`, `0.25`, `0.5` et `1`.


## Ondes de contrôle

Par défaut, l'effet `:slicer` utilise une onde carrée pour manipuler l'amplitude au fil du temps. C'est pour cela que l'on entend l'amplitude pendant une période, puis elle est immédiatement coupée pendant une période, puis remise en marche. Il se trouve que l'onde carrée est juste l'une des 4 différentes ondes de contrôle supportée par le `:slicer`. Les autres sont l'onde en dent de scie (saw), l'onde triangle et l'onde (co)sinus. Regardez le diagramme ci-dessous pour voir à quoi elles ressemblent. On peut aussi entendre comment elles sonnent. Par exemple, le code suivant utilise l'onde (co)sinus comme onde de contrôle. Remarquez comme le son n'est pas coupé puis remis brusquement, mais au lieu de cela, augmente et diminue doucement :

```
with_fx :slicer, phase: 0.5, wave: 3 do
  synth :dsaw, note: :e3, release: 8, cutoff: 120
  synth :dsaw, note: :e2, release: 8, cutoff: 100
end
```

Jouez avec les différentes formes d'ondes en changeant l'option `wave:` à `0` pour la dent de scie, `1` pour l'onde carrée, `2` pour l'onde triangle et `3` pour la sinusoïde. Voyez aussi comme les différentes ondes sonnent avec des options `phase:` différentes.

Chacune de ces ondes peut être inversée avec l'option `invert_wave:` qui la retourne sur l'axe y. Par exemple, lors d'une phase, l'onde en dent de scie commence typiquement à l'état haut puis descend doucement avant de sauter d'un coup à l'état haut. Avec `invert_wave: 1`, elle va commencer à l'état bas, puis monter doucement avant de sauter de nouveau à l'état bas. De plus, l'onde de contrôle peut démarrer à différents points avec l'option `phase_offset:` qui prend une valeur entre `0` et `1`. En jouant avec les options `phase:`, `wave:`, `invert_wave:` et `phase_offset`, vous pouvez changer drastiquement la façon dont l'amplitude est modulée au cours du temps.

![Durées de Phase](../../../etc/doc/images/tutorial/articles/A.14-amplitude-modulation/slicer_control_waves.png)


## Régler vos niveaux

Par défaut, le `:slicer` alterne entre les valeurs d'amplitude `1` (volume max nominal) et `0` (silencieux). Ceci peut être changé avec les options `amp_min:` et `amp_max:`. Vous pouvez utiliser ceci en parallèle du réglage d'onde sinusoïdale pour créer un effet de trémolo simple :

```
with_fx :slicer, amp_min: 0.25, amp_max: 0.75, wave: 3, phase: 0.25 do
  synth :saw, release: 8
end
```

C'est comme attraper le bouton de volume de votre chaîne hi-fi et le bouger légèrement de haut en bas pour que le volume oscille.


## Probabilités

L'une des fonctionnalités puissantes de `:slicer` est sa capacité à utiliser la probabilité pour choisir d'activer ou pas le slicer. Avant que le FX `:slicer` ne commence une nouvelle phase, il lance un dé et, en fonction du résultat, utilise l'onde de contrôle sélectionnée ou maintient l'amplitude désactivée. Écoutons :

```
with_fx :slicer, phase: 0.125, probability: 0.6  do
  synth :tb303, note: :e1, cutoff_attack: 8, release: 8
  synth :tb303, note: :e2, cutoff_attack: 4, release: 8
  synth :tb303, note: :e3, cutoff_attack: 2, release: 8
end
```

Ecoutez comme nous avons maintenant un rythme de pulsations intéressant. Essayez de changer l'option `probability:` vers une valeur différente entre `0` et `1`. Les valeurs plus proches de `0` provoqueront plus d'espacement entre les sons, dû à la probabilité beaucoup plus basse que le son soit déclenché.

Une autre chose à remarquer, est que le système de probabilités dans l'effet FX est identique à celui qui est accessible via les fonctions comme `rand` et `shuffle`. Ils sont tous les deux complètement déterministes. Cela signifie qu'à chaque fois que vous appuyez sur le bouton `executer`, vous entendrez exactement le même rythme de pulsations pour une probabilité donnée. Si vous voulez changer les choses, vous pouvez utiliser l'option `seed:` pour sélectionner une graine de départ différente. Cela fonctionne exactement comme `use_random_seed` mais affecte uniquement cet effet particulier.

Enfin, vous pouvez changer la "position de repos" de l'onde de contrôle quand le test de probabilité échoue, de `0` à n'importe quelle autre position avec l'option `prob_pos:` :

```
with_fx :slicer, phase: 0.125, probability: 0.6, prob_pos: 1  do
  synth :tb303, note: :e1, cutoff_attack: 8, release: 8
  synth :tb303, note: :e2, cutoff_attack: 4, release: 8
  synth :tb303, note: :e3, cutoff_attack: 2, release: 8
end
```

## Tranchage de rtythmes

Une chose très amusante à faire est d'utiliser le `:slicer` pour découper un rythme de batterie :

```
with_fx :slicer, phase: 0.125 do
  sample :loop_mika
end
```

Ceci nous permet de prendre n'importe quel échantillon et de créer de nouvelles possibilités rythmiques, ce qui est très amusant. Cependant, une chose pour laquelle il faut être prudent est de s'assurer que le tempo de l'échantillon correspond au rythme actuel dans Sonic Pi, sinon la découpe sonnera totalement décalée. Par exemple, essayez de remplacer `:loop_mika` avec l'échantillon `loop_amen` pour entendre comme cela sonne mal quand les tempo ne s'alignent pas.

## Modifier le tempo

Comme vous avez pu le voir, changer le BPM par défaut avec `use_bpm` fera s'accroitre ou se réduire les temps de pause et les durées d'enveloppe des synthés pour correspondre avec le tempo. L'effet `:slicer` honorera cela aussi, car l'option `phase:` est en fait mesurée en pulsation et non en secondes. Nous pouvons donc régler le problème avec `loop_amen` en changeant le BPM pour qu'il corresponde à l'échantillon :

```
use_sample_bpm :loop_amen
with_fx :slicer, phase: 0.125 do
  sample :loop_amen
end
```

## Rassemblons tout

Appliquons ces idées dans un dernier exemple qui utilise uniquement l'effet `:slicer` pour créer une combinaison intéressante. Allez-y, commencez à le modifier et à en faire votre propre morceau !

```
live_loop :dark_mist do
  co = (line 70, 130, steps: 8).tick
  with_fx :slicer, probability: 0.7, prob_pos: 1 do
    synth :prophet, note: :e1, release: 8, cutoff: co
  end
  
  with_fx :slicer, phase: [0.125, 0.25].choose do
    sample :guit_em9, rate: 0.5
  end
  sleep 8
end
live_loop :crashing_waves do
  with_fx :slicer, wave: 0, phase: 0.25 do
    sample :loop_mika, rate: 0.5
  end
  sleep 16
end
```




