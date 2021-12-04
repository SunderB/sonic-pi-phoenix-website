A.6 Minecraft musical

# Minecraft musical



Bonjour et bon retour parmi nous ! Dans les tutoriels précédents, nous nous sommes concentrés uniquement sur les possibilités musicales de Sonic Pi, en transformant votre Raspberry Pi en un instrument de musique prêt à jouer. Jusqu'à présent, nous avons appris comment :

* Programmation interactive - en changeant les sons à la volée,
* Coder des rythmes imposants,
* Générer des mélodies de synthé puissantes,
* Recréer le fameux son de basse acide TB-303.

Il y a tant d'autres choses à vous montrer (que nous explorerons dans les prochaines éditions). Cependant, ce mois-ci, regardons quelque chose que Sonic Pi peut faire que vous n'avez probablement pas remarqué : contrôler Minecraft.

## Bonjour, monde de Minecraft

D'accord, commençons. Démarrez votre Raspberry Pi, lancez Minecraft Pi et créez un nouveau monde. Maintenant, démarrez Sonic Pi, redimensionnez et déplacez vos fenêtres de manière à pouvoir voir Sonic Pi et Minecraft Pi en même temps.

Dans un tampon disponible, tapez ce qui suit :

```
mc_message "Hello Minecraft from Sonic Pi!"
```
    
Maintenant, cliquez sur 'Run'. Boum ! Votre message est apparu dans Minecraft ! C'était facile, non ? Maintenant, arrêtez un moment de lire ceci et jouez un peu avec vos propres messages. Amusez-vous !

![Écran 0](../../../etc/doc/images/tutorial/articles/A.06-minecraft/Musical-Minecraft-0-small.png)

## Téléportation sonique

Maintenant, faisons un peu d'exploration. L'option standard est d'attraper la souris et le clavier et de commencer à se promener. Ça fonctionne, mais c'est plutôt lent et ennuyeux. Il vaudrait mieux qu'on ait une sorte de téléporteur. Eh bien, grâce à Sonic Pi, nous en avons un. Essayez ceci :

```
mc_teleport 80, 40, 100
```
    
Oh ! C'était une longue ascension. Si vous n'étiez pas en mode de vol, vous seriez retombé jusqu'au sol. Si vous tapez deux fois sur la touche Espace pour entrer en mode vol et vous téléporter à nouveau, vous resterez en vol stationnaire à l'endroit où vous vous êtes déplacés.

Que signifient ces chiffres ? Nous avons trois nombres qui décrivent les coordonnées de l'endroit du monde où nous voulons nous déplacer. Nous donnons un nom à chacun de ces numéros - x, y et z :

* x - la distance à gauche et à droite (80 dans notre exemple)
* y - la hauteur que nous voulons atteindre (40 dans notre exemple)
* z - la distance avant et arrière (100 dans notre exemple)

En choisissant des valeurs différentes pour x, y et z, nous pouvons nous téléporter *n'importe où* dans notre monde. Essayez ! Choisissez différents nombres et voyez où vous pouvez vous retrouver. Si l'écran devient noir, c'est que vous vous êtes téléporté sous terre ou dans une montagne. Il suffit de choisir une valeur y plus élevée pour revenir au dessus de la terre. Continuez à explorer jusqu'à ce que vous trouviez un endroit qui vous plaise....

En utilisant les idées vues jusqu'ici, construisons un téléporteur sonique qui fera un son de téléportation amusant pendant qu'il nous propulsera à travers le monde de Minecraft :

```
mc_message "Preparing to teleport...."
sample :ambi_lunar_land, rate: -1
sleep 1
mc_message "3"
sleep 1
mc_message "2"
sleep 1
mc_message "1"
sleep 1
mc_teleport 90, 20, 10
mc_message "Whoooosh!"
```
    
![Écran 1](../../../etc/doc/images/tutorial/articles/A.06-minecraft/Musical-Minecraft-1-small.png)

## Blocs magiques

Maintenant que vous avez trouvé un bel endroit, commençons à construire. Vous pourriez faire comme vous en avez l'habitude et commencer à cliquer furieusement avec la souris pour placer des blocs sous le curseur. Ou vous pouvez employer la magie de Sonic Pi. Essayez ceci :

```
x, y, z = mc_location
mc_set_block :melon, x, y + 5, z
```

Maintenant, regardez en l'air ! Il y a un melon dans le ciel ! Prenez un moment pour regarder le code. Qu'est-ce qu'on a fait ? Sur la première ligne, nous avons saisi l'emplacement actuel de Steve dans les variables x, y et z. Celles-ci correspondent à nos coordonnées décrites ci-dessus. Nous utilisons ces coordonnées dans le bloc fn `mc_set_block` qui placera le bloc de votre choix aux coordonnées spécifiées. Pour placer quelque chose plus haut dans le ciel, il suffit d'augmenter la valeur y, et c'est pourquoi nous y ajoutons 5. Faisons-en une longue traînée :

```
live_loop :melon_trail do
  x, y, z = mc_location
  mc_set_block :melon, x, y-1, z
  sleep 0.125
end
```

Maintenant, passez à Minecraft, assurez-vous que vous êtes en mode vol (tapez deux fois sur Espace sinon) et volez autour du monde. Regardez derrière vous pour voir une jolie traînée de blocs de melon ! Voyez quelles sortes de motifs tortueux vous pouvez faire dans le ciel.

## Programmation interactive de Minecraft

Ceux d'entre vous qui ont suivi ce tutoriel au cours des derniers mois seront probablement bien étonnés ici. La chemin de melons est plutôt chouette, mais la partie la plus excitante de l'exemple précédent est que vous pouvez utiliser `live_loop` avec Minecraft ! Pour ceux qui ne savent pas, `live_loop` est la faculté magique spéciale de Sonic Pi qu'aucun autre langage de programmation ne possède. Elle vous permet d'exécuter plusieurs boucles en même temps et vous permet de les modifier pendant qu'elles s'exécutent. Elles sont incroyablement puissantes et formidablement amusantes. J'utilise des `live_loop` pour jouer de la musique dans les boîtes de nuit avec Sonic Pi - les DJ utilisent des disques et j'utilise des `live_loop` :-) Cependant, aujourd'hui, nous allons programmer de manière interactive la musique et Minecraft.

Commençons tout de suite. Exécutez le code ci-dessus et recommencez à faire votre chemin de melons. Maintenant, sans arrêter le code, changez simplement `:melon` en `:brick` et cliquez sur `Run`. Et voilà, vous construisez maintenant un chemin en briques. Comme c'est simple ! Envie d'un peu de musique pour l'accompagner ? Facile. Essayez ceci :

```
live_loop :bass_trail do
  tick
  x, y, z = mc_location
  b = (ring :melon, :brick, :glass).look
  mc_set_block b, x, y -1, z
  note = (ring :e1, :e2, :e3).look
  use_synth :tb303
  play note, release: 0.1, cutoff: 70
  sleep 0.125
end
```
    
Maintenant, pendant que ça joue, commencez à modifier le code. Changez les types de blocs - essayez `:water`, `:grass` ou votre type de bloc préféré. Essayez aussi de changer la valeur de coupure de `70` à `80` et puis jusqu'à `100`. C'est amusant, non ?

## Rassemblons tout

![Écran 2](../../../etc/doc/images/tutorial/articles/A.06-minecraft/Musical-Minecraft-2-small.png)

Combinons tout ce qu'on a vu jusqu'ici avec un peu plus de magie. Combinons notre capacité de téléportation avec le placement des blocs et la musique pour créer une vidéo musicale Minecraft. Ne vous inquiétez pas si vous ne comprenez pas tout, tapez simplement le code et jouez en modifiant certaines des valeurs en cours d'exécution. Amusez-vous bien et à la prochaine fois....
    
```
live_loop :note_blocks do
  mc_message "This is Sonic Minecraft"
  with_fx :reverb do
    with_fx :echo, phase: 0.125, reps: 32 do
      tick
      x = (range 30, 90, step: 0.1).look
      y = 20
      z = -10
      mc_teleport x, y, z
      ns = (scale :e3, :minor_pentatonic)
      n = ns.shuffle.choose
      bs = (knit :glass, 3, :sand, 1)
      b = bs.look
      synth :beep, note: n, release: 0.1
      mc_set_block b, x+20, n-60+y, z+10
      mc_set_block b, x+20, n-60+y, z-10
      sleep 0.25
    end
  end
end
live_loop :beats do
  sample :bd_haus, cutoff: 100
  sleep 0.5
end
```
