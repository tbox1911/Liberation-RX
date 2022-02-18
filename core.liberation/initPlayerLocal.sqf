waitUntil {!isNull player};

_rules = '
DE<br /><br />
Natürlich gelten hier wie auch auf dem Server die üblichen (Verhaltens)Regeln. Wir verzichten darauf, diese hier alle aufzuführen. Einige Punkte sind aber vor allem spielerisch hervorzuheben:<br /><br />
- Spielt zusammen und versucht stets, ein gemeinsames Spiel zu ermöglichen<br />
- Respawn oder Disconnect, während man bewusstlos ist, kostet Ressourcen -> Wartet also nach Möglichkeit immer auf Rettung<br />
- Jeder Spieler muss mittels TFAR auf dem Teamspeak-Server 94.130.39.20 erreichbar sein<br />
- Die Gruppen sprechen sich gegenseitig ab und schreiben ihre Frequenz auf den Kartenrand (50 ist normalerweise Zugfunk)<br />
- Infos über Fahrzeug- und Baurechte erhaltet ihr auf dem MilSim United Discord.<br />
- Nur signierte Mods aus dem Workshop oder unserem Repository nutzen<br />
- Spass haben und lieb sein zueinander

<br /><br />
EN<br /><br />
Of course, the usual (behavioural) rules apply here as well as on the server. We refrain from listing them all here. However, some points should be emphasised, especially from a gameplay point of view:<br /><br />
- Play together as a group.<br />
- Respawning or disconnecting while unconscious costs resources -> always wait for rescue if possible.<br />
- Every player must be reachable via TFAR on the teamspeak server 94.130.39.20<br />
- The groups talk to each other and write their frequency on the edge of the card (LR50 is usually the platoon-frequency)<br />
- Informations on vehicle- and building can be found on the MilSim United Discord.<br />
- Only use signed mods from the workshop or our repository<br />
- Have fun and be nice to each other
<br /><br /> 
<br /><br />
';

_situation = '
DE <br /><br />
Das neue Militärbündnis CSAT unterstützt Konfliktparteien in strategisch und wirtschaftlich relevanten Regionen, um dort an Einfluss zu gewinnen. NATO und OVKS kooperieren gegen diesen gemeinsamen Feind.<br /><br />
Kriegsführung: Symetrisch <br />
Feind: Örtliche Truppen<br />
Feind verfügt über:<br />
Panzer: Ja<br />
IFV: Ja<br />
Luftwaffe: Ja<br /><br />

Als Basis dient der "Liberation" Modus von den Killah Potatoes. Allerdings wurden von uns einige Änderungen vorgenommen, so dass das Gameplay mehr MilSim Charakter erhält.<br />
- Ziel ist es, die komplette Karte einzunehmen<br />
- Die Ressourcen können von Admins und trusted Spielern für Fahrzeuge ausgegeben werden<br />
- Respawn und Disconnect, während man bewusstlos ist, kosten Ressourcen. Wartet also wenn immer möglich auf Hilfe!
<br /><br /><br />
EN <br /><br />
The new military alliance CSAT supports conflict parties in strategically and economically relevant regions in order to gain influence there. NATO and CSTO cooperate against this common enemy.<br /><br />
Warfare: Symetric<br />
Enemy: Local troops<br />
Enemy has:<br />
Tanks: Yes<br />
IFV: Yes<br />
Air Force: Yes<br /><br />

The "Liberation" mode from the Killah Potatoes serves as the basis. However, we have made some changes so that the gameplay has more MilSim character.<br /> 
- The goal is to capture the entire map.<br /> 
- Resources can be spent on vehicles by admins and trusted players.<br /> 
- Respawn and disconnect while unconscious costs resources, so wait for help whenever possible!
<br /><br />
';

player createDiaryRecord ['Diary', ['Regeln / Rules', _rules], taskNull, '', false];
player createDiaryRecord ['Diary', ['Situation', _situation], taskNull, '', false];

sleep 10;




hint format['
Karte öffnen, Regeln lesen! \n
Open map, read rules! \n
TeamSpeak Server: 94.130.39.20 \n
'];

sleep 180;
hint format['
Karte öffnen, Regeln lesen! \n
Open map, read rules! \n
TeamSpeak Server: 94.130.39.20 \n
'];

while {true} do{
	sleep 300;
	_hs_time = systemTime;
	
	if ( ((_hs_time select 3) == 18) &&  ((_hs_time select 4) >= 30) ) then {
		hint format['Server restart 19:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
	if ( ((_hs_time select 3) == 2) && ((_hs_time select 4) >= 30) ) then {
		hint format['Server restart 03:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
	if ( ((_hs_time select 3) == 10) && ((_hs_time select 4) >= 30) ) then {
		hint format['Server restart 11:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
};

// hint format['%1:%2', (_hs_time select 3), (_hs_time select 4)];
