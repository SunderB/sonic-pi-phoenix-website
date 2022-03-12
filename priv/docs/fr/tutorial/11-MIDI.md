11 MIDI

# MIDI

Une fois que vous avez maîtrise la conversion du code en musique, vous vous demandez peut-être : quel est la suite ? Parfois les contraintes de travailler purement dans la syntaxe de Sonic Pi et d'un système de son peut paraître excitant et vous placez dans une nouvelle position créative. Toutefois, parfois il est essentiel de sortir du code pour aller dans le vrai monde. Nous voulons deux choses supplémentaires :

1. Pour être capable de convertir des actions du vrai monde en événements de Sonic Pi avec lesquels coder
2. Pour être capable d'utiliser le model fort de timing de Sonic Pi et ses sémantiques pour contrôler et manipuler les objets dans le vrai monde

Heureusement, il existe un protocole depuis les années 80 qui permet exactement ce genre d'interactions : MIDI. Il y a un nombre incroyable de périphériques externes en incluant les claviers, les contrôleurs, les séquenceurs et des logiciels d'audio professionnels qui supportent tous le MIDI. Nous pouvons utiliser le MIDI pour recevoir des données et en envoyer.

Sonic Pi supporte entièrement le protocole MIDI ce qui vous permet de connecter votre code au vrai monde. Explorons-le plus en détails ...
