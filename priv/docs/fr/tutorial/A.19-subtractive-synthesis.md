A.19 Design du son - Synthèse soustractive

# Synthèse soustractive

Ceci est le deuxième d'une série d'articles sur comment utiliser Sonic Pi pour le design du son. Le mois dernier, nous avons étudié la synthèse additive dont nous avons découvert qu'il s'agissait simplement de jouer de multiples sons en même temps pour fabriquer un nouveau son combiné. Par exemple, nous pourrions combiner des synthés qui sonnent différemment ou même reprendre le même synthé avec plusieurs hauteurs pour construire un nouveau son complexe à partir d'ingrédients simples. Ce mois-ci, nous allons étudier une nouvelle technique communément appelée "synthèse soustractive" qui est le fait de prendre un son existant complexe et d'en retirer certaines parties pour créer quelque chose de nouveau. Il s'agit d'une technique qui est associée couramment avec le son des synthétiseurs analogiques des années 1960 et 1970, mais également avec la renaissance récente des synthétiseurs analogiques modulaires à travers des standards populaires comme Eurorack.

Même si cela semble être une technique particulièrement compliquée et avancée, Sonic Pi rend cela étonnamment facile et simple - alors commençons dès maintenant.

## Signal source complexe

Pour qu'un son se travaille bien avec la synthèse soustractive, il faut habituellement qu'il soit riche et intéressant. Cela ne veut pas dire que nous avons besoin de quelque chose d'extrêmement complexe - en fait, juste une onde standard `:square` ou `:saw` fonctionnera :

```
synth :saw, note: :e2, release: 4
```

Notez que ce son est déjà assez intéressant et contient plusieurs fréquences différentes au-dessus de `:e2` (le second E sur un piano) ce qui aide à créer le timbre. Si cela ne fait pas trop de sens pour vous, essayez de le comparer avec le `:beep` :

```
synth :beep, note: :e2, release: 4
```

Étant donné que le synthé `:beep` est seulement une onde sinusoïdale, vous entendrez une tonalité beaucoup plus pure, seulement `:e2`, et rien des sons hauts grinçants que vous avez entendu avec `:saw`. C'est cet effet et la variation d'une onde sinusoïdale pure avec lesquels nous pouvons jouer en utilisant la synthèse soustractive.

## Filtres

Une fois que nous avons notre signal source, la prochaine étape est d'appliquer un filtre d'un type qui modifiera le son en retirant ou en réduisant des parties de celui-ci. L'un des filtres les plus communs utilisés pour la synthèse soustractive est celui appelé le filtre passe-bas. Cela permet à toutes les parties basses du son de passer, mais il va réduire ou retirer les parties plus hautes. Sonic Pi a un système d'effets puissant, mais simple, à utiliser qui inclut un filtre passe-bas, appelé `:lpf`. Jouons avec :

```
with_fx :lpf, cutoff: 100 do
  synth :saw, note: :e2, release: 4
end
```

Si vous écoutez attentivement, vous entendrez comment ces grincements ont été retirés. En fait, toutes les fréquences dans le son qui sont au-dessus de la note `100` ont été réduites ou retirées et seulement celles en dessous sont toujours présentes dans le son. Essayez de changer ce point `cutoff:` à des notes plus basses, disons `70` puis `50` et comparer les sons.

Évidemment, le `:lpf` n'est pas le seul filtre que vous pouvez utiliser pour manipuler le signal source. Un autre effet important est le filtre passe-haut, dénommé `:hpf` dans Sonic Pi. Il fait le contraire de `:lpf` en laissant les parties hautes du son passées et en coupant les parties basses.

```
with_fx :hpf, cutoff: 90 do
  synth :saw, note: :e2, release: 4
end
```

Notez comment ce son est beaucoup plus grinçant maintenant que toutes les fréquences basses du son ont été retirées. Jouez avec la valeur de coupure - remarquez comment des valeurs plus basses laissent plus de parties basses du son original source passer et que les valeurs plus hautes sonnent plus petites et silencieuses.

## Filtre passe-bas

![Variation les quantités de filtre passe-bas en cours](../../../etc/doc/images/tutorial/articles/A.19-subtractive-synthesis/subtractive-synthesis-waveforms.png)

Le filtre passe-bas est une partie si importante de chaque boîte à outils de synthèse soustractive qu'il vaut la peine d'examiner de plus près comment il fonctionne. Ce diagramme montre la même onde sonore (le synthé `:prophet`) avec une quantité de filtrages variés. En haut, la section A montre l'onde audio sans filtrage. Remarquez comment la forme d'onde est très pointue et contient beaucoup d'arêtes vives. Ce sont ces angles durs et aigus qui produisent les composantes aiguës croustillantes / bourdonnantes du son. La section B montre le filtre passe-bas en action - remarquez comment il est moins pointu et plus arrondi que la forme d'onde ci-dessus. Cela signifie que le son aura moins de hautes fréquences, ce qui lui donnera une sensation arrondie plus douce. La section C montre le filtre passe-bas avec une valeur de coupure assez faible - cela signifie que davantage de hautes fréquences ont été supprimées du signal, ce qui donne une forme d'onde encore plus douce et plus ronde. Enfin, notez comment la taille de la forme d'onde, qui représente l'amplitude, diminue lorsque nous passons de A à C. La synthèse soustractive fonctionne en supprimant des parties du signal, ce qui signifie que l'amplitude globale est réduite en fonction de la quantité de filtrage appliquée.


## Filtre de modulation

Jusqu'à maintenant, nous avons produit des sons assez statiques. En d'autres mots, le son ne change en aucune façon pour toute sa durée. Souvent, vous voudrez peut-être donner du mouvement à un son afin de donner de la vie à son timbre. Une façon d'accomplir cela est avec le filtre de modulation - en changeant les options du filtre au travers du temps. Heureusement, Sonic Pi vous offre des outils puissants pour manipuler les options d'un FX au fil du temps. Par exemple, vous pouvez définir un temps de glissement à chaque option modulable pour spécifier combien de temps cela devrait-il prendre de glisser de la valeur actuelle vers la valeur cible :

```
with_fx :lpf, cutoff: 50 do |fx|
  control fx, cutoff_slide: 3, cutoff: 130
  synth :prophet, note: :e2, sustain: 3.5
end
```

Jetons un coup d’œil rapide à ce qui se passe ici. Premièrement, nous commençons avec un bloc FX `:lpf` avec un `cutoff:` initial d'un très bas `20`. Cependant, la première ligne termine également avec l'étrange `|fx|` à la fin. C'est une partie optionnelle de la syntaxe `with_fx` qui vous permet de nommer directement et de contrôler le synthé FX qui s'exécute. La ligne 2 fait exactement cela et contrôle le FX pour définir la valeur de l'option `cutoff_slide:` à 4 et la nouvelle cible de `cutoff:` à `130`. Ce FX commencera donc à glisser la valeur de l'option `cutoff:` de `50` à `130` sur une période de trois temps. Finalement, nous déclenchons également un synthé de signal source pour que nous puissions entendre l'effet du filtre passe-bas modulé.


## Rassemblons tout

This is just a very basic taster of what's possible when you use filters to modify and change a source sound. Try playing with Sonic Pi's many built-in FX to see what fun sounds you can design. If your sound feels too static, remember you can start modulating the options to create some movement.

Terminons en créant une fonction qui jouera un nouveau son créé avec la synthèse soustractive. Voyez si vous pouvez déterminer ce qui se passe - et pour les lecteurs avancés de Sonic Pi - voyez si vous pouvez trouver pourquoi j'ai tout enveloppé à l'intérieur d'un appel `at` (s'il-vous-plait envoyez vos réponses à @samaaron sur Twitter).

```
define :subt_synth do |note, sus|
  at do
    with_fx :lpf, cutoff: 40, amp: 2 do |fx|
      control fx, cutoff_slide: 6, cutoff: 100
      synth :prophet, note: note, sustain: sus
    end
    with_fx :hpf, cutoff_slide: 0.01 do |fx|
      synth :dsaw, note: note + 12, sustain: sus
      (sus * 8).times do
        control fx, cutoff: rrand(70, 110)
        sleep 0.125
      end
    end
  end
end
subt_synth :e1, 8
sleep 8
subt_synth :e1 - 4, 8
```
