A. 15 techniques de codage en "Live"

# Cinq techniques de Live Coding

Dans le tutoriel Sonic Pi de ce mois-ci, nous allons regarder comment vous allez pouvoir commencer à traiter Sonic Pi comme un véritable instrument. Nous allons donc devoir commencer à penser au code d'une façon complètement différente. Les live coders voient le code de la même façon que les violonistes voient leur archet. En fait, tout comme un violoniste peut appliquer différentes méthodes d'archet pour créer des sons différents (des mouvements lents et amples ou des touches rapides et courtes) nous allons explorer cinq des techniques de base de live coding que permet Sonic Pi. À la fin de cet article, vous serez capables de commencer à vous entrainer pour vos propres représentations de live coding.

## 1. Mémoriser les raccourcis

Le premier truc pour live coder avec Sonic Pi est de commencer à utiliser les raccourcis. Par exemple, au lieu de perdre un temps précieux à atteindre la souris, la déplacer sur le bouton d'exécution et cliquer dessus, vous pouvez simplement appuyer simultanément sur `alt` et `r`, ce qui est beaucoup plus rapide et garde vos doigts sur le clavier, prêts pour la prochaine édition. Vous pouvez trouver les raccourcis pour les principaux boutons en haut, en passant la souris au dessus d'eux. Voyez la section 10.2 du tutoriel inclus pour la liste complète des raccourcis.

Lorsque vous jouez, une chose amusante à faire est d'ajouter un peu de style à votre mouvement de bras lorsque vous utilisez des raccourcis. Par exemple, il est souvent bien de communiquer avec votre public quand vous êtes sur le point de faire un changement. Embellissez donc votre mouvement quand vous appuyez sur `alt-r` comme le ferait un guitariste lorsqu'il joue un puissant accord.

## 2. Superposer manuellement vos sons

Maintenant que vous pouvez déclencher le code instantanément avec le clavier, vous pouvez instantanément utiliser cette compétence pour notre seconde technique qui est de calquer vos sons manuellement. Au lieu de "composer" en utilisant beaucoup d'appels de "jouer" et "échantillon" séparés par des appels de "dormir", nous allons avoir un appel de "jouer" que nous allons manuellement déclencher en utilisant "alt-r". Essayons-le. Taper le code suivant dans un nouveau tampon :

```
synth :tb303, note: :e2 - 0, release: 12, cutoff: 90
```

Maintenant, cliquez sur "Exécuter". Pendant que le son joue, modifiez le code afin de décrémenter quatre notes en effectuant ce qui suit :


```
synth :tb303, note: :e2 - 4, release: 12, cutoff: 90
```

Maintenant, pressez `Run` de nouveau, pour entendre les deux sons jouer en même temps. Ceci se produit puisque le bouton `Run` de Sonic Pi n'attend pas qu'un code précédent ne se termine et donc le code s'exécute en même temps. Ceci veut dire que vous pouvez facilement superposer plusieurs sons manuellement avec des modifications mineures ou majeures entre chaque déclenchement. Par exemple, essayez de changer la `note:` et l'option de `cutoff:` et de déclencher de nouveau.


Vous pouvez également essayer cette technique avec de longs échantillons abstraits. Par exemple :

```
sample :ambi_lunar_land, rate: 1
```

Essayer de démarrer l'échantillon, et puis progressivement couper de moitié l'option de `rate:` entre les clics de `Run` de `1` à `0.5` à `0.25` à `0.125`. Ensuite, essayez même des valeurs négatives comme `-0.5`. Superposez les sons ensemble et découvrez ce que vous pouvez faire. Finalement, essayez d'ajouter quelques FX.

En direct, travailler ainsi avec des lignes de code simples permet à un public découvrant Sonic Pi de suivre ce que vous faites et de faire le lien entre le code lu et le son entendu, le résultat du code.


## 3. Boucles maîtresses en "live"

Lorsque vous travaillez avec une musique plus rythmée, il est souvent difficile de déclencher tout manuellement et de conserver le bon tempo. A la place, il est souvent mieux d'utiliser une `live_loop`. Cela fournit une répétition de votre code en plus de vous donner la possibilité de modifier le code pour la prochaine itération de la boucle. Ces "boucles en direct", live loops, vont également être exécutées en même temps que les autres `live_loop`s ce qui signifie que vous pouvez jouer les deux ensemble l'une avec l'autre et programmer manuellement les déclencheurs. Jetez un coup d’œil à la section 9.2 du tutoriel inclus pour plus d'informations à propos du travail avec les boucles en direct.

En direct, pensez à utiliser l'option `live_loop`'s `sync:` pour récupérer des erreurs d'exécution accidentelles qui stoppent la boucle en direct à cause d'une erreur de votre part, erreur de syntaxe par exemple. Si vous avez l'option `sync:` qui pointe vers une autre `live_loop` valide alors vous pouvez rapidement réparer votre erreur de syntaxe et ré-exécuter le code corrigé pour redémarrer les choses sans l'arrêt du morceau complet.

## 4. Utiliser le mixer général

L'un des secrets les mieux gardés de Sonic Pi est qu'il a un mixeur maître par lequel passent tous les flux de sons. Ce mixeur a un filtre de passe basse et un filtre de passe élevé inclus, afin que vous puissiez facilement effectuer des modifications globales au son. La fonctionnalité du mixeur maître est accessible via la fonction `set_mixer_control!`. Par exemple, pendant que du code s'exécute et fait du son, entrez ceci dans un tampon supplémentaire et pressez `Run` :

` set_mixer_control! lpf: 50 `

Ce code une fois exécuté, tous les sons existants et les nouveaux auront un filtre passe-bas qui leur sera appliqué : ils sonneront donc plus étouffés. Notez que cela veut dire que les nouvelles valeurs du mixeur demeurent les mêmes tant qu'elles ne sont pas changées de nouveau. Cependant, si vous le voulez, vous pouvez toujours remettre le mixeur à son état par défaut avec `reset_mixer!`. Quelques unes des options supportées actuellement sont : `pre_amp:`, `lpf:` `hpf:`, et `amp:`. Pour la liste complète, voir la documentation incluse pour `set_mixer_control!`.

Utilisez les options `*_slide` du mixeur pour faire varier, glisser une ou plusieurs valeurs d'option au fil du temps. Par exemple, pour glisser lentement le filtre de passe-bas du mixeur de la valeur courante à 30, utilisez ceci :

```
set_mixer_control! lpf_slide: 16, lpf: 30
```

Vous pouvez désormais glisser rapidement de nouveau vers une valeur haute avec :

```
set_mixer_control! lpf_slide: 1, lpf: 130
```

Lorsque vous jouez, il est souvent utile de conserver un tampon libre pour travailler avec le mixeur comme cela.

## 5. Entraînement

La technique la plus importante pour la programmation en direct est la pratique. Le trait le plus commun au travers des musiciens professionnels de tous les types est qu'ils s'entraînent à jouer avec leur instrument - souvent plusieurs heures par jour. La pratique est aussi importante pour un programmeur en direct qu'un guitariste. La pratique permet à vos doigts de mémoriser certains schémas et éditions communes afin que vous puissiez les tapez et travailler avec eux de manière plus fluide. La pratique vous donne également des opportunités d'explorer des nouveaux sons et des nouvelles constructions de code.

En performant, vous découvrirez que plus vous pratiquez, plus il sera facile pour vous de vous relaxer pendant une séance. La pratique vous donne également une richesse d'expérience de laquelle apprendre. Cela peut vous aider à comprendre quel types de modifications seraient intéressants et également ce qui fonctionne bien avec les sons courants.

## Rassemblons tout

Ce mois-ci, au lieu de vous donner un exemple final qui combine toutes les choses dont nous avons discuté, essayons plutôt de poser un défi. Voyez si vous pouvez passer une semaine à pratiquer l'une de ces idées tous les jours. Par exemple, une journée pratiquez les déclencheurs manuels, la suivante faites du travail basique de `live_loop` et avant que vous ne vous en rendiez compte, vous serez en train de coder en direct pour un vrai public.
