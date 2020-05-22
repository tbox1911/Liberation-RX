# Liberation RX (en)

## ARMA-3 Liberation RX - Extendend Version

![alt text](https://raw.githubusercontent.com/tbox1911/Liberation-RX/master/liberation.png "Liberation RX")

Feature:

+ SP / MP with Automatic Save Game
+ Private Economy
+ Private Vehicles
+ TK Protection
+ Player FAR Revive (revive/drag)
+ MGI AI Revive (AI revive player)
+ R3F Logistic (tow or load objects into vehicles)
+ LARs Arsenal
+ Auto Hearplug
+ MagRepack Ammo
+ Robust Unblock system (Player / AI)
+ Medic / Respawn / Arsenal Box (can be loaded into vehicle)
+ AI follow player when Halo Jump / Redeploy
+ And much, much more....

RP oriented

> With ranking system based on player score and actions
> automatic permission granting (build/tank/air)
> unlocking arsenal/units according to the rank.

+ Local SELL / FUEL / ATM points on the Map
+ Dynamic Events
+ Special Missions
+ FPS fix and perf
+ Admin Menu (teleport/skiptime/God/spawn)
+ Lots of Customization (shorter night, anti mine, recycling ammobox....)
+ No need of admin/commander (including fresh start)


Engine and map available for:

+ Altis
+ Malden
+ Stratis (Air Carrier)
+ Tanoa
+ Livonie (Enoch)
+ Takistan (CUP + CBA)

## Installation

+ Direct Play:
      Copy the pbo file to your "Steam\SteamApps\common\Arma3\MPMissions\" directory
      Launch Arma 3, Host MP Game, Select Island and Liberation RX mission, Start

+ Build from Source:
      Launch "build.bat" in the build directory to build PBOs
      Or merge the core.liberation folder with the island mission folder
      and build the pbo by yourself.

+ Dedicated Server
      Copy the pbo file to your "Steam\SteamApps\common\Arma3 Server\MPMissions\" directory
      Edit / Create the server configuration file (https://community.bistudio.com/wiki/server.cfg),
      and add this:

            // MISSIONS CYCLE
            class Missions
            {
                  class Mission1
                  {
                        template="liberation_RX.Altis";
                        difficulty="Regular";
                        class Params
                        {
                              Difficulty = 1.25;
                              Aggressivity = 2;
                              MaximumFobs = 5;
                              Whitelist = 1;
                        };
                  };
            };

      + All mission's parameters can be found in the file "mission_param.cfg"

      Start the server
            arma3server_x64.exe -high -name=server -nosound -port=2302 -config=server.cfg
            arma3server -high -name=server -nosound -port=2302 -config=server.cfg

## Thanks

   I want to thank :
   Zbug, who did a very good job, AgentRev and Larrow and all contributors of  [Bohemia Interactive Forums](https://forums.bohemia.net/). for the countless messages I read from them and gave me a real code lesson!

--------------------------------------------------------------------------------------------------------------------------
# Liberation RX (fr)

## ARMA-3  Liberation RX - Version Etendu

![alt text](https://raw.githubusercontent.com/tbox1911/Liberation-RX/master/liberation.png "Liberation RX")

Sur la base de la version 0.924 par [GREUH] Zbug

Addon:

+ SP / MP avec sauvegarde du jeu automatique
+ Economie Privé
+ Vehicules Privé
+ TK Protection
+ R3F Logistic (tracter ou charger des objets dans les vehicules)
+ LARs Arsenal
+ Player FAR Revive (revive/drag)
+ MGI AI Revive (les AI revive le joueur)
+ Automatique Hearplug
+ MagRepack Ammo
+ Robust Unblock systeme (Player / IA)
+ Caisses de Medic / Respawn / Arsenal (peuvent etre charger dans les vehicules)
+ Les IA suivent le joueur lors des  Saut Halo / Redeploy
+ Et beaucoup, beaucoup plus ...

Ranking:
      Un systeme de Grade permet de debloquer les Permissions des joueurs automatiquement.
      Cette Mission est concu afin de ne pas avoir besoin d'un Commandeur.

Moteur et carte disponible pour:

+ Altis
+ Malden
+ Stratis (Porte Avion)
+ Tanoa
+ Livonie (Enoch)
+ Takistan (CUP + CBA)

## Installation

+ Direct:
     Copiez le fichier pbo dans votre répertoire "Steam\SteamApps\common\Arma3\MPMissions\"

+ Source:
    Lancez "build.bat" dans le repertoire build pour fabriquer les PBO
    Ou fusionnez le dossier core.liberation avec le dossier de mission de l'ile
    et construisez le pbo par vous meme.

## Thanks

  Je veux remercier :
  Zbug, qui a fait une trés bonne mission, AgentRev et Larrow et tous les contributeurs de [Bohemia Interactive Forums](https://forums.bohemia.net/). pour les innombrables messages que j'ai lu d'eux et qui mon donné une veritable leçon de code !

--------------------------------------------------------------------------------------------------------------------------
