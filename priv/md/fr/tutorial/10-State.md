10 État du temps

# État du temps

Il est souvent utile d'avoir de l'information qui est *partagée à travers plusieurs fils d'exécution ou boucles en direct*. Par exemple, vous pourriez vouloir partager une notion de la clef courante, de BPM, ou des concepts encore plus abstraits comme la 'complexité' courante (que vous pourriez potentiellement interpréter de manière différente à travers divers fils). Nous ne voulons pas non plus perdre aucune nos garanties existantes de déterminisme en faisant cela. En d'autres mots, nous aimerions être toujours capable de partager du code avec d'autres, et savoir exactement ce qu'ils vont entendre en l'exécutant. À la fin de la Section 5.6 de ce tutoriel, nous avons discuté brièvement de pourquoi nous *ne devrions pas utiliser des variables pour partager l'information à travers les fils d'exécution* à cause d'une perte de déterminisme (ce qui est dû à la concurrence).

Sonic Pi's solution to the problem of easily working with global variables in a deterministic way is through a novel system it calls Time State. This might sound complex and difficult (in fact, in the UK, programming with multiple threads and shared memory is typically a university level subject). However, as you'll see, just like playing your first note, *Sonic Pi makes it incredibly simple to share state across threads* whilst still keeping your programs *thread-safe and deterministic*.

Rencontrez `get` et `set`...
