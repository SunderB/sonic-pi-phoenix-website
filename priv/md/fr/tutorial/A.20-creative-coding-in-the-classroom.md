A.20 Codage créatif en classe avec Sonic Pi

# Codage créatif en classe avec Sonic Pi

(Cet article a été publié en anglais dans [le numéro 9 du magazine Hello World](https://helloworld.raspberrypi.org/issues/9))

Le code est l'un des médias les plus créatifs que les humains aient créés. Les symboles initialement obscurs des parenthèses et des lambdas ne sont pas seulement profondément enracinés dans les sciences et les mathématiques, ils sont les plus proches que nous ayons réussi à obtenir pour jeter le même genre de sorts magiques que Gandalf et Harry Potter. Je crois que cela constitue un moyen puissant d'engagement dans nos espaces d'apprentissage. Grâce à la magie du code, nous sommes en mesure d'évoquer des histoires et des expériences d'apprentissage qui ont un sens pour chacun d'entre nous.

Nous sommes entourés d'expériences magiques. Du tour de passe-passe d'un magicien de scène faisant disparaître le ballon dans les airs, à l'émerveillement de voir son groupe préféré se produire sur une grande scène. Ce sont ces moments magiques qui nous inspirent à prendre un livre de magie et apprendre le French Drop ou pour commencer à jouer des accords de puissance sur une vieille guitare. Comment pourrions-nous créer un sens de l'émerveillement aussi profond et durable qui motivera les gens à pratiquer et à apprendre les bases de la programmation ?

## Moteurs musicaux et notation

Les histoires de la musique et de l'informatique sont intimement liées depuis la création des machines informatiques, ou "moteurs", comme on appelait le puissant moteur analytique de Charles Babbage. En 1842, la mathématicienne Ada Lovelace, qui a travaillé en étroite collaboration avec Babbage, a vu le potentiel créatif de ces moteurs. Alors que ces premiers moteurs avaient été conçus à l'origine pour résoudre avec précision des problèmes mathématiques difficiles, Ada rêvait de faire de la musique avec eux :

"...le moteur pourrait composer des morceaux de musique élaborés et scientifiques de n'importe quel degré de complexité ou d'ampleur." Ada Lovelace, 1842.

Bien sûr, aujourd'hui en 2019, une grande partie de notre musique, quel que soit le genre, a été composée, produite ou masterisée avec un ordinateur numérique. Le rêve d'Ada est devenu réalité. Il est même possible de remonter encore plus loin dans l'histoire. Si vous voyez le codage comme l'art d'écrire des séquences de symboles spéciaux qui ordonnent à un ordinateur de faire des choses spécifiques, alors la composition musicale est une pratique très similaire. Dans la musique occidentale, les symboles sont des points noirs placés sur une portée de lignes qui indiquent au musicien quelles notes jouer et quand. Il est intéressant de noter que si l'on remonte les racines de la notation musicale occidentale jusqu'au moine bénédictin italien Guido d'Arezzo, on constate que le système de points et de lignes utilisé par les orchestres modernes n'est qu'un des nombreux systèmes de notation sur lesquels il a travaillé. Certains des autres systèmes étaient beaucoup plus proches de ce que nous pourrions considérer aujourd'hui comme un code.

Dans le domaine de l'éducation, les expériences magiques et significatives avec les ordinateurs et les langages de programmation ont été explorées depuis la fin des années 60. Les pionniers de l'éducation informatique Seymour Papert, Marvin Minsky et Cynthia Solomon ont exploré des langages simples basés sur le langage Lisp qui permettaient de déplacer des stylos sur de grandes feuilles de papier. Avec quelques commandes simples, il était possible de programmer l'ordinateur pour qu'il dessine n'importe quelle image. Ils ont même expérimenté en étendant leur langage Logo du dessin à la musique. Papert a écrit sur l'apprentissage par l'expérience de la reconstruction du savoir plutôt que de sa transmission. Amener les gens à jouer directement avec les choses était une partie importante du travail de son groupe.


## Performances Sonic Pi

![Jylda Live Coding dans le Sage Gateshead](../../../etc/doc/images/tutorial/articles/A.20-creative-coding-in-the-classroom/jylda-small.png) Jylda et Sam Aaron performant à la conférence "the Thinking Digital Conference" dans le "Sage Gateshead". Crédit photo : TyneSight Photos.

Sonic Pi a été utilisé pour se produire dans un grand nombre de lieux tels que des salles d'école, des boîtes de nuit, sur des scènes extérieures de festivals de musique, des chapelles d'université et des lieux de musique prestigieux. Par exemple, l'étonnant projet Convo qui a réuni 1000 enfants dans le Royal Albert Hall pour interpréter une nouvelle composition ambitieuse de la compositrice Charlotte Harding. La pièce a été écrite pour les instruments traditionnels, les chœurs, les percussions et le code Sonic Pi. L'artiste pop Jylda a également joué avec Sonic Pi dans le Sage Gateshead pour la conférence Thinking Digital, où elle a créé un remix improvisé unique en direct de sa chanson Reeled.

![Sonic Pi dans le Royal Albert Hall](../../../etc/doc/images/tutorial/articles/A.20-creative-coding-in-the-classroom/convo-small.png Sonic Pi utilisé comme un des instruments pour le Convo au Royal Albert Hall. Crédit photo : Pete Jones.


## Codage en direct en classe

Sonic Pi est un outil de création et de performance musicale basé sur le code qui s'appuie sur toutes ces idées. Contrairement à la majorité des logiciels éducatifs informatiques, il est à la fois assez simple à utiliser pour l'éducation et assez puissant pour les professionnels. Il a été utilisé pour se produire dans des festivals de musique internationaux, pour composer dans des styles variés allant du classique au métal lourd en passant par l'EDM, et a même fait l'objet d'une critique dans le magazine Rolling Stone. Il compte une communauté diversifiée de plus d'un million et demi de codeurs live, aux parcours variés, qui apprennent et partagent tous leurs idées et leurs pensées par le biais du code. Il est libre et gratuit à télécharger pour Mac, PC et Raspberry Pi et comprend un tutoriel convivial qui suppose que vous ne connaissez rien au code ou à la musique.

Sonic Pi a été conçu à l'origine comme une réponse au nouveau programme d'informatique britannique publié en 2014. L'objectif était de trouver une manière motivante et amusante d'enseigner les bases de la programmation. Il s'avère qu'il y a beaucoup de points communs et qu'il est très amusant d'expliquer le séquençage comme une mélodie, l'itération comme un rythme, les conditionnels comme une variété musicale. J'ai développé les concepts initiaux et les premières itérations de la plateforme avec Carrie Anne Philbin, qui a apporté le point de vue d'un enseignant au projet. Depuis lors, Sonic Pi a connu des améliorations itératives grâce au retour d'information obtenu en observant les apprenants et en collaborant directement avec les éducateurs dans la classe. L'une des principales philosophies de conception était de ne jamais ajouter une caractéristique qui ne pourrait pas être facilement enseignée à un enfant de 10 ans. Cela signifiait que la plupart des idées devaient être fortement affinées et retravaillées jusqu'à ce qu'elles soient suffisamment simples. Rendre les choses simples tout en les gardant puissantes reste la partie la plus difficile du projet.

Afin de fournir la motivation magique, la conception de Sonic Pi ne s'est jamais limitée à une pure focalisation sur l'éducation. L'idéal serait que des musiciens et des interprètes célèbres utilisent Sonic Pi comme instrument standard aux côtés des guitares, de la batterie, du chant, des synthés, des violons, etc. Ces interprètes serviraient alors de modèles de motivation démontrant le potentiel créatif du code. Pour que cela soit possible, il a donc fallu consacrer suffisamment d'attention et d'efforts pour en faire un instrument puissant tout en le gardant suffisamment simple pour que des enfants de 10 ans puissent s'en saisir. En plus des éducateurs, j'ai également travaillé directement avec différents artistes dans des classes, des galeries d'art, des studios et des lieux de travail au début du développement de Sonic Pi. Cela m'a permis d'obtenir un retour d'information essentiel qui a permis à Sonic Pi de grandir et, en fin de compte, de s'épanouir en tant qu'outil d'expression créative.

Cette double orientation vers l'éducation et les musiciens professionnels a eu un certain nombre d'effets secondaires passionnants et inattendus. Plusieurs des fonctionnalités sont bénéfiques pour les deux groupes. Par exemple, beaucoup d'efforts ont été déployés pour rendre les messages d'erreur plus conviviaux et utiles (plutôt qu'un énorme fouillis de jargon compliqué). Cela s'avère très utile lorsque vous écrivez un bogue en vous produisant devant des milliers de personnes. De plus, des fonctionnalités telles que la lecture d'échantillons audio de qualité studio, l'ajout d'effets audio, l'accès à l'audio en direct depuis le microphone, tout cela s'avère rendre l'expérience d'apprentissage plus amusante, plus gratifiante et finalement plus significative.

La communauté Sonic Pi continue de s'agrandir et de partager d'étonnantes compositions de code, des plans de cours, des algorithmes musicaux et bien plus encore. La plupart de ces échanges se font sur notre forum amical in_thread (in-thread.sonic-pi.net) qui accueille un groupe très diversifié de personnes comprenant des éducateurs, des musiciens, des programmeurs, des artistes et des fabricants. C'est une véritable joie de voir des gens apprendre à utiliser du code pour s'exprimer de manière nouvelle et inspirer en cela d'autres personnes à faire de même.

# Quelques capacités amusantes

Du point de vue de l'informatique, Sonic Pi vous fournit les éléments de base pour vous enseigner les notions de base telles qu'elles figurent dans le programme d'études britannique, comme le séquençage, l'itération, les conditionnels, les fonctions, les structures de données, les algorithmes, etc. Toutefois, il s'appuie également sur un certain nombre de concepts importants et pertinents qui ont été adoptés dans l'industrie courante, tels que la concurrence, les événements, la correspondance de modèles, l'informatique distribuée et le déterminisme - tout en gardant les choses suffisamment simples pour les expliquer à un enfant de 10 ans.

Débuter est aussi simple que cela :

```
play 70
```

Une mélodie peut être construite avec une commande supplémentaire, sleep :

```
play 70
sleep 1
play 72
sleep 0.5
play 75
```

Dans cet exemple, nous jouons la note 70 (environ la 70ème note d'un piano), nous attendons une seconde, nous jouons la note 72, nous attendons une demi-seconde et nous jouons ensuite la note 75. Ce qui est intéressant ici, c'est qu'avec seulement deux commandes, nous avons accès à presque toute la notation occidentale (quelles notes jouer et quand) et les apprenants peuvent coder n'importe quelle mélodie qu'ils ont déjà entendue. Cela conduit à une grande variété de résultats expressifs tout en se concentrant sur le même concept informatique : le séquençage dans ce cas.

En s'inspirant du monde de la musique professionnelle, nous pouvons également reproduire n'importe quel son enregistré. Sonic Pi peut lire n'importe quel fichier audio sur votre ordinateur, mais possède également un certain nombre de sons intégrés pour faciliter la mise en route :

```
sample :loop_amen
```

Ce code permettra de rejouer le break de batterie qui était un pilier du hip-hop des origines, de la drum & bass et de la jungle. Par exemple, un certain nombre d'artistes des débuts du hip-hop ont joué ce break de batterie à mi-vitesse pour lui donner un sentiment plus décontracté :

```
sample :loop_amen, rate: 0.5
```

Dans les années 90, un certain nombre de scènes musicales ont éclaté grâce aux nouvelles technologies qui ont permis aux artistes de démonter des breaks de batteries comme celui-ci et de les remonter dans un ordre différent. Par exemple :

```
live_loop :jungle do
 sample :loop_amen, onset: pick
 sleep 0.125
end
```

Dans cet exemple, nous introduisons une boucle de base appelée : jungle qui prend un coup de batterie aléatoire dans notre échantillon audio, attend un huitième de seconde et prend ensuite un autre coup de batterie. Il en résulte un flux infini de coups de batterie aléatoires sur lesquels vous pouvez danser tout en découvrant ce qu'est une boucle.
