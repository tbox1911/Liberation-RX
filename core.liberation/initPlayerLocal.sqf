waitUntil {!isNull player};

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

_rules = '
DE<br /><br />
Natürlich gelten hier wie auch auf dem Server die üblichen (Verhaltens)Regeln. Wir verzichten darauf, diese hier alle aufzuführen. Einige Punkte sind aber vor allem spielerisch hervorzuheben:<br /><br />
- Spielt zusammen und versucht stets, ein gemeinsames Spiel zu ermöglichen<br />
- Respawn oder Disconnect, während man bewusstlos ist, kostet Euch Geld -> Wartet also nach Möglichkeit immer auf Rettung<br />
- Jeder Spieler muss mittels TFAR auf dem Teamspeak-Server 94.130.39.20 erreichbar sein<br />
- Die Gruppen sprechen sich gegenseitig ab und schreiben ihre Frequenz auf den Kartenrand (50 ist normalerweise Zugfunk)<br />
- Infos über Fahrzeug- und Baurechte erhaltet ihr auf dem MilSim United Discord.<br />
- Nur signierte Mods aus dem Workshop oder unserem Repository nutzen<br />
- Spass haben und lieb sein zueinander

<br /><br />
EN<br /><br />
Of course, the usual (behavioural) rules apply here as well as on the server. We refrain from listing them all here. However, some points should be emphasised, especially from a gameplay point of view:<br /><br />
- Play together as a group.<br />
- Respawning or disconnecting while unconscious costs you money -> always wait for rescue if possible.<br />
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
Ein in naher Zukunft neu entstandenes Militärbündnis unterstützt Konfliktparteien in strategisch und wirtschaftlich relevanten Regionen, um dort an Einfluss zu gewinnen. Eine multinationale Koalition leistet Widerstand.
<br /><br />
Sämtliche Streitkräfte bedienen sich aus Effizienzgründen zunehmend am internationalen Rüstungsmarkt.
<br /><br /><br />

EN <br /><br />
A newly formed military alliance in the near future supports conflicting parties in strategically and economically relevant regions in order to gain influence there. A multinational coalition is putting up resistance.
<br /><br />
For reasons of efficiency, all armed forces are increasingly making use of the international arms market.
<br /><br /><br />
';

player createDiaryRecord ['Diary', ['Regeln / Rules', _rules], taskNull, '', false];
player createDiaryRecord ['Diary', ['Situation', _situation], taskNull, '', false];

sleep 10;

execVM "scripts\client\misc\vehicle_restriction.sqf";
execVM "MilSimUnited\create_arsenal_Itemlist.sqf";


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

