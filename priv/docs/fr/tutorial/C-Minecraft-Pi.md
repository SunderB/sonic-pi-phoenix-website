C Minecraft Pi

# Minecraft Pi

Sonic Pi supporte maintenant une simple API (interface de programmation) pour interagir avec Minecraft Pi - l'édition spéciale de Minecraft qui est installée par défaut avec le système d'exploitation Raspbian Linux du Raspberry Pi.

## Aucun besoin d'importer des bibliothèques

L'intégration avec Minecraft Pi a été conçue pour être extrêmement simple à utiliser. Tout ce dont vous avez besoin est de lancer Minecraft Pi et de créer un monde. Vous êtes alors libre d'utiliser les fonctions `mc_*` tout comme vous pourriez utiliser `play` et `synth`. Il n'y a pas besoin d'importer quoi que ce soit ou d'installer des bibliothèques - tout est déjà prêt à être utilisé.

## Connexion automatique

L'API Minecraft Pi se préoccupe de la gestion de votre connexion à l'application Minecraft Pi. Cela veut dire que vous n'avez pas besoin de vous en inquiéter. Si vous essayez d'utiliser l'API à Minecraft Pi quand Minecraft Pi n'est pas démarré, Sonic Pi vous en avertira poliment. Similairement, si vous arrêtez Minecraft Pi quand vous êtes encore en train d'exécuter une `live_loop` qui utilise l'API, la boucle s'arrêtera et vous avertira poliment de l'impossibilité de se connecter. Pour vous reconnecter, relancez simplement Minecraft Pi et Sonic Pi le détectera automatiquement et rétablira la connexion pour vous.

## Conçue pour être codée en direct

L'API de Minecraft Pi a été conçue pour fonctionner sans heurt à l'intérieur des `live_loop`s. Ce qui signifie qu'il est possible de synchroniser des modifications de vos mondes de Minecraft Pi avec des modifications de vos sons de Sonic Pi. Des vidéos musicales instantanées basées sur Minecraft ! Notez cependant que Minecraft Pi est un logiciel en phase alpha et qu'il est connu pour être légèrement bogué. Si vous rencontrez un problème quelconque, relancez simplement Minecraft Pi et continuez comme avant. La fonctionnalité de connexion automatique de Sonic Pi prendra soin des choses pour vous.

## Nécessite un Raspberry Pi 2.0

Il est grandement recommandé d'utiliser un Raspberry Pi 2 si vous voulez exécuter à la fois Sonic Pi et Minecraft en même temps - particulièrement si vous voulez utiliser les capacités sonores de Sonic Pi.

## Support de l'API

À cette étape, Sonic Pi supporte les manipulations basiques des joueurs et des blocs qui sont détaillées dans la section C.1. Le support pour les retours d'appel d'événements déclenchés par les interactions des joueurs dans le monde est planifié pour une version future.
