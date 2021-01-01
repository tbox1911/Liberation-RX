# Liberation RX (en)

## ARMA-3 Liberation RX - Extendend Version

![alt text](https://raw.githubusercontent.com/tbox1911/Liberation-RX/master/liberation.png "Liberation RX")

## Features

+ Personal Progression
+ Personal Economy
+ Personal Vehicles (can be abandoned)
+ R3F Logistic (can tow vehicles and load item)
+ LARs (Larrow) Arsenal (Customisable Arsenal)
+ pSiKO AI Revive Addon (AI revive SP/MP)
+ TK Protect + AutoBAN
+ Extra Action keys: Hearplug, Always Run, etc..
+ Magazine Repack
+ Robust Unstuck AI/Player
+ Robust Air Taxi Service
+ AI follow you when Redeploy/HALO jump
+ Extended Air Support (Taxi, Air drop, etc...)
+ A Virtual Garage + Repaint Menu
+ Vehicles Cargo & Inventory saved on server
+ Keep/recover your AI in game, even if your client restart (crash/ reboot) in MP
+ Wildlife Manager
+ A dog to help you 😉
+ Support Squad
+ And much, much more !!

+ RP oriented
  with ranking system based on player action
  automatic permission granting (build/tank/air)
  unlocking arsenal/units according to rank
  send or receive Ammo from players

+ Dynamic Sides Missions
+ Special Missions
+ lots of performance fix / update
+ Admin Menu (unban/ammo/score/teleport/skiptime/God/spawn obj)

+ MULTI 6 - English, French, German, Spanish, Russian, Chinesesimp

This mission is designed to avoid the need for a commander, even at first boot, proper rights management, and player permissions are automatically granted.

Most of the important options can be configured via the "Settings" menu (in lobby)
They can change the mission experioence radically.

Zeus mode can be used when your are both admin of the server and logged as Commander.

Have Fun !

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Mission available for

+ Altis
+ Malden
+ Stratis (Air Carrier)
+ Tanoa
+ Enoch

with CUP Terrain:

+ Chernarus (+ Winter)
+ Takistan
+ Sarahni
+ Sarahni South
+ Utes

+ Virolahti 7 (vt7)
+ Isla Duala

with GlobalMobilization

+ Wefer Lingen

with Operation Trebuchet

+ Iberius

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
      Edit / Create the server configuration file (look at: <https://community.bistudio.com/wiki/server.cfg>)
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
