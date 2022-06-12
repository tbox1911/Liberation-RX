waitUntil {
	!isNull player
};

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

_rules = '
DE<br /><br />
Natürlich gelten hier wie auch auf dem Server die üblichen (Verhaltens)Regeln.<br /><br />
- Spielt zusammen und versucht stets, ein gemeinsames Spiel zu ermöglichen<br />
- Respawn oder Disconnect, während man bewusstlos ist, kostet Euch Geld -> Wartet also nach Möglichkeit immer auf Rettung<br />
- Jeder Spieler muss mittels TFAR auf dem Teamspeak-Server 193.111.198.84 erreichbar sein<br />
- Infos über Fahrzeug- und Baurechte erhaltet ihr auf dem MilSim United Discord.<br />
- Nur signierte Mods aus dem Workshop oder unserem Repository nutzen<br />
- Spass haben und lieb sein zueinander
<br /><br />
Spielregeln:<br /><br />
1. Bewusstes Teamkilling ist strengstens untersagt, unbewusstes wird immer untersucht.<br />
2. Wir setzen ein funktionierendes und qualitatives Mikrofon zur Spielteilnahme voraus.<br />
3. Trolling ist untersagt, Beleidigungen, Rassismus ebenso, verhaltet euch freundlich.<br />
4. Eine gute Kommunikation ist alles, ihr seid daher angewiesen die zugewiesenen Kanäle strikt einzuhalten und zu benutzen.<br />
5. Der Teamleader darf über die Waffenklasse einzelner seines Trupps, wie auch über die zu Spielende Fraktion bestimmen.<br />
6. Boden-teams sind von außen immer LR(“Long-Range”) auf der 50 für Bodenstreitkräfte zu erreichen.<br />
7. Boden-Luft Kommunikation ist immer auf der 51.<br />
8. Luft-Luft Kommunikation ist auf der 52.<br />
8.1 Innerhalb des teams sind außer den Hauptkanälen 50, 51, 52 alle anderen Kanäle frei wählbar.<br />
9. ALLE Elemente müssen sich mit dem Groupmanager eintragen. Der Rufname ist Sinnvoll/Seriös zu wählen. (ACE Self Interaction Menü -> Groupmanager)<br />
10. Wir behalten uns Änderungen des Regelwerkes vor.<br />
11. Jeder ist angehalten sich selbst über Änderungen des Regelwerkes zu informieren.<br />

<br /><br />
EN<br /><br />
Of course, the usual (behavioural) rules apply here as well as on the server. We refrain from listing them all here. However, some points should be emphasised, especially from a gameplay point of view:<br /><br />
- Play together as a group.<br />
- Respawning or disconnecting while unconscious costs you money -> always wait for rescue if possible.<br />
- Every player must be reachable via TFAR on the teamspeak server 193.111.198.84 <br />
- Informations on vehicle- and building can be found on the MilSim United Discord.<br />
- Only use signed mods from the workshop or our repository<br />
- Have fun and be nice to each other
<br /><br />

Gameplay Rules:<br /><br />
1. Killing Friendly units is strictly forbidden, accedents will always be looked at.<br />
2. It is required to have a working and a good quality microphone.<br />
3. Trolling, insults and racism are strictly forbidden.<br />
4. Good communication is everything. You are required to use the assigned channels.<br />
5. The group leader can dictate the weapon class of group members, as well as the faction that is played.<br />
6. Infantryteams are required to be on the Long-Range-Radio channel 50 for ground to ground communication.<br />
7. Ground to Air communication is on Long-Range-Radio channel 51.<br />
8. Air to Air communication is on Long-Range-Radio channel 52.<br />
9. All elements must be named correctly in the Groupmanager. Chose your callsign sensibly/serious.(ACE Self Interaction Menü -> Groupmanager)<br />
10. We reserve the right to change the rules.<br />
11. Everyone should keep himself up to date with changes made to the rules.<br />

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
for reasons of efficiency, all armed forces are increasingly making use of the international arms market.
<br /><br /><br />
';

player createDiaryRecord ['Diary', ['Regeln / Rules', _rules], taskNull, '', false];
player createDiaryRecord ['Diary', ['Situation', _situation], taskNull, '', false];

sleep 10;

execVM "scripts\client\misc\vehicle_restriction.sqf";
execVM "MilSimUnited\create_arsenal_Itemlist.sqf";

if (isNil "global_arsenal") then {
	global_arsenal = true;
};

if (global_arsenal) then {
	_glob_box  = missionnamespace getVariable ["myLARsBox", objNull];
	[_glob_box, false] call ace_arsenal_fnc_initBox;
	[_glob_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
	[_glob_box, pub_arsenal_box] call ace_arsenal_fnc_addVirtualitems;
	[_glob_box, item_blacklist] call ace_arsenal_fnc_removeVirtualitems;
} else {
	_box = missionnamespace getVariable ["myLARsBox", objNull];
	[_box, false] call ace_arsenal_fnc_initBox;
	[_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
};

if (isNil "limit_hc_gr") then {
	limit_hc_gr = true;
};

if (!hasInterface && !isDedicated) then {
	while(limit_hc_gr) do {
		{
			if ((count units _x) isEqualTo 0) then {
				deleteGroup _x;
			};
		} count allGroups;
		sleep 1;
	};

	["O_Plane_Fighter_02_F", "initPost", {
    	params ["_vehicle"];
    	[
        	_vehicle,
        	["Su57_Style1", 1],
        	true
    	] call BIS_fnc_initvehicle;
    	_loadout_fighter = ["FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_RBK250_P_1rnd_M", "FIR_RBK250_P_1rnd_M", "PylonRack_3Rnd_ACE_Hellfire_AGM114L", "PylonRack_3Rnd_ACE_Hellfire_AGM114L", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM7F_2_P_1rnd_M", "FIR_AIM7F_2_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M"];
    
    	{
        	vehicle _vehicle setPylonLoadout [_forEachindex, _x, true];
    	} forEach _loadout_fighter;
	
	}, nil, nil, true] call CBA_fnc_addClassEventHandler;

	["O_Plane_CAS_02_Cluster_F", "initPost", {
    	params ["_vehicle"];
    	[
        	_vehicle,
        	["Su57_Style1", 1],
        	true
    	] call BIS_fnc_initvehicle;
    
    	_loadout_CAS = ["FIR_AIM120_P_1rnd_M", "CUP_PylonPod_1Rnd_R73_Vympel", "PylonRack_20Rnd_Rocket_03_HE_F", "FIR_RBK250_P_1rnd_M", "PylonRack_3Rnd_ACE_Hellfire_AGM114L", "PylonRack_3Rnd_ACE_Hellfire_AGM114L", "FIR_RBK250_P_1rnd_M", "PylonRack_20Rnd_Rocket_03_HE_F", "CUP_PylonPod_1Rnd_R73_Vympel", "FIR_AIM120_P_1rnd_M"];
    
    	{
     	   vehicle _vehicle setPylonLoadout [_forEachindex, _x, true];
    	} forEach _loadout_CAS;
	}, nil, nil, true] call CBA_fnc_addClassEventHandler;

};

all_arsenals = [];

{
	_prc1 = format ["FAC_MSU\%1\arsenal.sqf", _x];
	_handle1 = player execVM _prc1;
	waitUntil {
		scriptDone _handle1
	};
	all_arsenals = all_arsenals + arsenal;
} forEach ['USMC', 'USARMY', 'BW', 'BAF', 'FFAA', 'PMC'];

hint format['
	Karte öffnen, Regeln lesen! \n
	Open map, read rules! \n
	TeamSpeak Server: 193.111.198.84 \n
'];

sleep 180;
hint format['
	Karte öffnen, Regeln lesen! \n
	Open map, read rules! \n
	TeamSpeak Server: 193.111.198.84 \n
'];

while { true } do {
	sleep 300;
	_hs_time = systemTime;

	if (((_hs_time select 3) == 18) && ((_hs_time select 4) >= 30)) then {
		hint format['Server restart 19:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
	if (((_hs_time select 3) == 2) && ((_hs_time select 4) >= 30)) then {
		hint format['Server restart 03:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
	if (((_hs_time select 3) == 10) && ((_hs_time select 4) >= 30)) then {
		hint format['Server restart 11:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
};

// hint format['%1:%2', (_hs_time select 3), (_hs_time select 4)];
