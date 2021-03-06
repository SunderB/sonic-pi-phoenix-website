C.1 API basique

# API basique de Minecraft Pi

Sonic Pi supporte actuellement les interactions basiques suivantes avec Minecraft Pi :

* Affichage de messages de conversation
* Fixer la position de l'utilisateur
* Obtenir la position de l'utilisateur
* Fixer le type de bloc à une coordonnée donnée
* Obtenir le type de bloc à une coordonnée donnée


Voyons chacune d'elles tour à tour.

## Affichage de messages de conversation

Voyons juste comme c'est facile de contrôler Minecraft Pi depuis Sonic Pi. Assurez-vous d'abord que vous avez Minecraft Pi et Sonic Pi actifs en même temps et assurez-vous aussi que vous êtes entré dans un monde de Minecraft et que vous pouvez vous y déplacer.

Dans un tampon vierge de Sonic Pi, entrez simplement le code suivant :

```
mc_message "Hello from Sonic Pi"
```

Quand vous pressez le bouton *Run*, vous verrez votre message clignoter dans la fenêtre de Minecraft. Félicitations, vous avez écrit votre premier code Minecraft ! C'était facile, aucun doute.

## Fixer la position de l'utilisateur

Maintenant, essayons un peu de magie. Téléportons-nous quelque-part ! Essayez le code suivant :

```
mc_teleport 50, 50, 50
```

Quand vous pressez le bouton *Run* - boum ! Vous avez été instantanément transporté à un nouvel endroit. Le plus probablement, c'était dans le ciel et vous êtes tombé soit sur la terre ferme, soit dans l'eau. Maintenant, quels sont ces nombres : `50, 50, 50` ? Ce sont les coordonnées de l'endroit où vous essayiez d'être téléporté. Prenons un bref moment pour explorer ce que sont ces coordonnées et comment elles fonctionnent parce qu'elles sont réellement, réellement importantes pour programmer Minecraft.

## Coordonnées

Imaginez une carte de pirate avec un grand `X` marquant l'emplacement d'un trésor. L'emplacement exact du `X` peut être décrit avec deux nombres - à quelle distance du bord gauche de la carte en allant vers la droite et à quelle distance du bord inférieur de la carte en allant vers le haut il se trouve. Par exemple, `10cm` en horizontal et `8cm` en vertical. Ces deux nombres `10` et `8` sont des coordonnées. Vous pourriez imaginer aisément le description des endroits d'autres cachettes de trésor avec d'autres paires de nombres. Peut-être y-a-t-il un gros coffre d'or à `2` en horizontal et à `9` en vertical...

Maintenant, dans Minecraft, deux nombres ne sont pas tout à fait suffisants. Nous devons aussi savoir à quelle hauteur nous sommes. Nous avons donc besoin de trois nombres :

* Distance de la droite vers la gauche dans le monde - `x`
* Distance du devant vers l'arrière du monde - `z`
* À quelle hauteur nous sommes dans le monde - `y`

Une chose en plus - nous décrivons habituellement ces trois coordonnées dans l'ordre `x`, `y`, `z`.

## Trouver vos coordonnées actuelles

Jouons avec les coordonnées. Naviguez vers un bel endroit de la carte de Minecraft et puis basculez sur Sonic Pi. Maintenant, entrez le code suivant :

```
puts mc_location
```

Quand vous pressez le bouton *Run*, vous voyez les coordonnées de votre position courante affichées dans le panneau "trace". Prenez en note, puis déplacez-vous dans le monde et essayez à nouveau. Notez comme les coordonnées ont changé ! Maintenant, je vous recommande de passer quelque temps à refaire exactement cela - vous déplacer un peu dans le monde, regarder les coordonnées et recommencer. Faites cela jusqu'à ce que vous commenciez à être à l'aise sur la manière dont changent les coordonnées quand vous vous déplacez. Une fois que vous avez compris comment fonctionnent les coordonnées, programmer avec l'API à Minecraft sera du gâteau.

## Construisons !

Maintenant que vous savez comment trouver la position actuelle et vous téléporter en utilisant les coordonnées, vous avez tous les outils dont vous avez besoin pour commencer à construire des choses dans Minecraft avec du code. Disons que vous voulez faire du bloc avec les coordonnées `40`, `50`, `60` un bloc de verre. C'est super facile :

```
mc_set_block :glass, 40, 50, 60
```

Haha, c'était vraiment facile. Pour voir le résultat de votre travail pratique, téléportez-vous aux alentours et regardez :

```
mc_teleport 35, 50, 60
```

Maintenant, tournez sur vous-même et vous devriez voir votre bloc de verre ! Essayez de le changer en diamant :

```
mc_set_block :diamond, 40, 50, 60
```

Si vous regardiez dans la bonne direction, vous avez même pu voir le changement devant vos yeux ! C'est le début de quelque chose de passionnant...

## Recherche du type de bloc

Regardons une dernière chose avant d'aller vers quelque chose d'un peu plus compliqué. Étant donné un jeu de coordonnées, nous pouvons demander à Minecraft quel est le type d'un bloc spécifique. Essayons-le avec le bloc de diamant que vous venez de créer :

```
puts mc_get_block 40, 50, 60
```

Ouais ! C'est `:diamond`. Essayez de le faire revenir au verre et demandez à nouveau - Dit-il vraiment `:glass` maintenant ? Je suis certain que oui :-)

## Types de bloc disponibles

Avant que vous alliez vers un déchaînement de codage de Minecraft Pi, vous pourriez trouver utile cette liste des types de blocs disponibles :

```
    :air
    :stone
    :grass
    :dirt
    :cobblestone
    :wood_plank
    :sapling
    :bedrock
    :water_flowing
    :water
    :water_stationary
    :lava_flowing
    :lava
    :lava_stationary
    :sand
    :gravel
    :gold_ore
    :iron_ore
    :coal_ore
    :wood
    :leaves
    :glass
    :lapis
    :lapis_lazuli_block
    :sandstone
    :bed
    :cobweb
    :grass_tall
    :flower_yellow
    :flower_cyan
    :mushroom_brown
    :mushroom_red
    :gold_block
    :gold
    :iron_block
    :iron
    :stone_slab_double
    :stone_slab
    :brick
    :brick_block
    :tnt
    :bookshelf
    :moss_stone
    :obsidian
    :torch
    :fire
    :stairs_wood
    :chest
    :diamond_ore
    :diamond_block
    :diamond
    :crafting_table
    :farmland
    :furnace_inactive
    :furnace_active
    :door_wood
    :ladder
    :stairs_cobblestone
    :door_iron
    :redstone_ore
    :snow
    :ice
    :snow_block
    :cactus
    :clay
    :sugar_cane
    :fence
    :glowstone_block
    :bedrock_invisible
    :stone_brick
    :glass_pane
    :melon
    :fence_gate
    :glowing_obsidian
    :nether_reactor_core
```
