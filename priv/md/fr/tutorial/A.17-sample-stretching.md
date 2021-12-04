A.17 Étirement de l'échantillon

# Étirement de l'échantillon

Lorsque les personnes découvrent Sonic Pi, l'une des premières choses qu'ils apprennent est combien il est facile de jouer des sons pré-enregistrés en utilisant la fonction `sample`. Par exemple, vous pouvez faire jouer une boucle de batterie industrielle, entendre le bruit d'une chorale ou même écouter le "scratch" d'un vinyle, tout ça via une seule ligne de code. Cependant, plusieurs personnes ne réalisent pas que vous pouvez varier la vitesse à laquelle l'échantillon est joué pour ajouter des effets puissants et un tout nouveau niveau de contrôle sur vos sons enregistrés. Alors, lancez une copie de Sonic Pi et commençons à étirer quelques échantillons !

## Ralentissement des échantillons

Pour modifier la vitesse à laquelle joue un échantillon, nous devons utiliser l'option `rate:` :

```
sample :guit_em9, rate: 1
```
    
Si nous spécifions un `rate:` de `1`, alors l'échantillon sera joué à une vitesse normale. Si nous voulons le jouer à une vitesse réduite de moitié, nous utilisons tout simplement un `rate:` de `0.5` :


```
sample :guit_em9, rate: 0.5
```
    
Notez comme cela a deux effets sur l'audio. Premièrement l'échantillon sonne plus bas et deuxièmement il prend deux fois plus de temps à jouer (voir la barre latérale pour une explication). Nous pouvons même choisir des vitesses de plus en plus basses jusqu'à `0`, donc un `rate:` de `0.25` est un quart de la vitesse, `0.1` un dixième de la vitesse, etc. Essayez de jouer avec des vitesses lentes et de voir si vous pouvez transformer le son en un grondement.

## Accélération des échantillons

En plus de rendre le son plus long et grave en utilisant une petite vitesse, nous pouvons utiliser des vitesses plus rapides pour rendre le son plus court et aigu. Jouons avec une boucle de batterie pour cette fois-ci. Premièrement, écoutez comment cela sonne à la vitesse par défaut de `1` :

```
sample :loop_amen, rate: 1
```


Maintenant, accélérons un peu les choses :

```
sample :loop_amen, rate: 1.5
```
    
Ah ! Nous venons de passer du genre music techno vieille école à la jungle. Remarquer comment la fréquence de chaque coup de tambour est plus grande ainsi que le rythme complet qui est accéléré. Maintenant, essayer des taux encore plus grands et voyez comment haut et court vous pouvez modifier la boucle de batterie. Par exemple, si vous utilisez le taux de `100`, la boucle de batterie tourne en un clic !

## Marche arrière

A présent, je suis sûr que beaucoup d'entre vous pensent la même chose... "qu'est-ce qu'il se passe si j'utilise une valeur négative pour la vitesse ?". Excellente question ! Réfléchissons-y un court instant. Si notre `rate:` désigne la vitesse à laquelle l'échantillon est joué, `1` étant la vitesse normale, `2` étant deux fois plus rapide, `0.5` étant deux fois plus lent, `-1` doit vouloir dire à l'envers ! Essayons ça sur une caisse claire. Pour commencer, rejouez à la vitesse normale :

```
sample :elec_filt_snare, rate: 1
```
    
Maintenant, jouez le à l'envers :

```
sample :elec_filt_snare, rate: -1
```
    
Bien entendu, vous pouvez le jouer à l'envers deux fois plus vite avec un `rate:` de `-2` ou à l'envers deux fois plus lentement avec un `rate:` de `-0.5`. Maintenant, amusez-vous à jouer avec différentes valeurs négatives. C'est particulièrement amusant avec l'échantillon `:misc_burp` !


## Échantillon, Vitesse et Hauteur

L'un des effets de la modification de la vitesse sur les échantillons est que plus la vitesse est importante plus l'échantillon sonne aigu, et plus la vitesse est basse plus l'échantillon sonne grave. Un autre endroit où vous avez pu entendre cet effet est dans la vie de tous les jours lorsque vous faites du vélo ou que vous passez près d'un passage piéton qui émet un bip sonore - lorsque vous vous approchez de la source sonore le son est plus aigu que lorsque vous vous en éloignez - c'est ce que l'on appelle l'effet Doppler. Pourquoi cela ?

Considérons un simple bip qui est représenté par une onde sinusoïdale. Si nous utilisons un oscilloscope pour tracer ce bip, nous verrons quelque chose comme la figure A. Si nous traçons le bip une octave plus aiguë, nous verrons la figure B et une octave plus grave ressemblera à la figure C. Remarquez que les ondes des notes aiguës sont plus compactes tandis que celles des notes graves sont plus étendues.

Un échantillon d'un bip n'est rien de plus que beaucoup de nombres (x,y, coordonnées) qui, lorsque tracé point par point sur un graphique, dessinera de nouveau les courbes originales. Voyez la figure D où chaque cercle représente une coordonnée. Pour convertir de nouveau les coordonnées en audio, l'ordinateur travaille avec chaque valeur x et envoie chaque valeur y correspondante aux haut-parleurs. L'astuce ici est que la vitesse à laquelle l'ordinateur travaille avec les nombres x n'a pas besoin d'être la même que la vitesse à laquelle ils ont été enregistrés. En d'autres mots, l'espace (représentant une quantité de temps) entre chaque cercle peut être étiré ou compressé. Donc, si l'ordinateur travaille plus rapidement avec les valeurs x que la vitesse originale, cela aura l'effet d'écraser les cercles ensemble ce qui résultera en un bip sonnant plus aigu. Cela va également rendre le bip plus court étant donné que nous allons naviguer plus rapidement au travers des cercles. Cela est démontré dans la figure E.

Finalement, une dernière chose à savoir est qu'un mathématicien appelé Fourier a prouvé que tout son est beaucoup d'ondes sinusoïdales combinées toutes ensemble. Donc, quand nous compressons et étirons quelconque son enregistré, nous étirons et compressons plusieurs ondes sinusoïdales ensemble en même temps de cette manière exactement.

## Effet Pitch Bend

Comme nous l'avons vu, utiliser une vitesse plus rapide rendra le son plus aigu et une vitesse plus lente rendra le son plus grave. Une astuce très simple et utile est de savoir que doubler la vitesse résultera en un son qui est une octave plus aiguë et inversement, diminuer la vitesse de moitié rendra le son une octave plus grave. Cela veut dire que, pour les échantillons mélodiques, les faire jouer en même temps que lui-même à une vitesse doublée ou divisée de moitié sonne plutôt bien :

```
sample :bass_trance_c, rate: 1
sample :bass_trance_c, rate: 2
sample :bass_trance_c, rate: 0.5
```
    
Cependant, comment devons-nous faire si nous voulons modifier la vitesse afin que le son soit un demi-ton plus aigu (une note plus aiguë sur le piano) ? Sonic Pi rend cela très facile avec l'option `rpitch:` :

```
sample :bass_trance_c
sample :bass_trance_c, rpitch: 3
sample :bass_trance_c, rpitch: 7
```
    
Si vous regardez le journal à droite, vous remarquerez qu'un `rpitch:` de `3` correspond en fait à un rythme de `1.1892` et qu'un `rpitch:` de `7` correspond à un rythme de `1.4983`. Finalement, nous pouvons même combiner les options `rate:` et `rpitch:` :

```
sample :ambi_choir, rate: 0.25, rpitch: 3
sleep 3
sample :ambi_choir, rate: 0.25, rpitch: 5
sleep 2
sample :ambi_choir, rate: 0.25, rpitch: 6
sleep 1
sample :ambi_choir, rate: 0.25, rpitch: 1
```
    

## Rassemblons tout

Let's take a look at a simple piece which combines these ideas. Copy it into an empty Sonic Pi buffer, hit play, listen to it for a while and then use it as a starting point for your own piece. See how much fun it is to manipulate the playback rate of samples. As an added exercise try recording your own sounds and play around with the rate to see what wild sounds you can make.

```
live_loop :beats do
  sample :guit_em9, rate: [0.25, 0.5, -1].choose, amp: 2
  sample :loop_garzul, rate: [0.5, 1].choose
  sleep 8
end
 
live_loop :melody do
  oct = [-1, 1, 2].choose * 12
  with_fx :reverb, amp: 2 do
    16.times do
      n = (scale 0, :minor_pentatonic).choose
      sample :bass_voxy_hit_c, rpitch: n + 4 + oct
      sleep 0.125
    end
  end
end
```







