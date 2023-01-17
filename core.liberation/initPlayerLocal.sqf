waitUntil {
	!isNull player
};

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

_rules = '
DE<br />
<br />
Verbote:<br />
- Trolling, Beleidigungen, Rassismus, Pornographie, sexuelle Belästigung, alles andere, weswegen die Polizei kommt<br />
- Angriffe auf Verbündete und Zivilisten<br />
- Boden- und Luftfahrzeuge dürfen ohne Auftrag der Infanterie nicht angreifen.<br />
- Anderen Spielern das Fahrzeug klauen<br />
- In FOBs rumballern und Müll auf den Boden schmeißen<br />
- Übertrieben dumm aufführen, so dass der Server die Bezeichnung "MilSim" nicht mehr verdient.<br />
- Programfehler ausnutzen<br />
<br />
Pflichten:<br />
+ Eigene Gruppen-Infos in den Groupmanager eintragen. (ACE Self Interaction Menü -> Groupmanager)<br />
+ Machen, was der Gruppenführer sagt oder sich eine andere Gruppe suchen.<br />
+ Funktionierendes Mikrofon und TFAR<br />
+ Funkdisziplin: Nur das nötigste, ordentlich formuliert<br />
+ Alle Bodeneinheiten müssen über Kanal 50 erreichbar sein.<br />
+ Alle Lufteinheiten müssen über Kanal 51 (Boden-Luft) und 52 (Luft-Luft) erreichbar sein.<br />
+ Bei Regelverstößen oder Bugs muss ein Beweisvideo vorgelegt werden. (z.B. mit: Nvida Shadow Play, X-Box-Game-Bar)<br />
<br />
<br />
EN<br /><br />
Prohibited:<br />
- Trolling, insults, racism, pornography, sexual harassment, anything else the police would come for<br />
- Attacks on allies and civilians<br />
- Ground and air vehicles are not allowed to attack without infantry order.<br />
- Stealing other players´ vehicles<br />
- Shooting around in FOBs and throwing garbage on the ground<br />
- Acting overly stupid so that the server no longer deserves the name "MilSim".<br />
- Exploit program bugs<br />
<br />
Duties:<br />
+ Add own group info to group manager. (ACE self interaction menu -> Groupmanager).<br />
+ Do what the group leader says or find another group.<br />
+ Working microphone and TFAR<br />
+ Radio discipline: only the most necessary, properly formulated.<br />
+ All ground units must be reachable via channel 50.<br />
+ All air units must be reachable via channel 51 (ground-air) and 52 (air-air).<br />
+ In case of rule violations or bugs, a proof video must be presented. (e.g. with: Nvida Shadow Play, X-Box Game Bar).<br />
<br />
<br />
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

// execVM "scripts\client\misc\vehicle_restriction.sqf";
execVM "MilSimUnited\create_arsenal_Itemlist.sqf";

if (isNil "global_arsenal") then {
	global_arsenal = true;
};

if (global_arsenal) then {
	sleep 10;
	_glob_box  = missionnamespace getVariable ["myLARsBox", objNull];
	[_glob_box, false] call ace_arsenal_fnc_initBox;
	[_glob_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
	[_glob_box, pub_arsenal_box] call ace_arsenal_fnc_addVirtualitems;
	[_glob_box, item_blacklist] call ace_arsenal_fnc_removeVirtualitems;
	[_glob_box, item_whitelist] call ace_arsenal_fnc_addVirtualitems;
} else {
	_box = missionnamespace getVariable ["myLARsBox", objNull];
	[_box, false] call ace_arsenal_fnc_initBox;
	[_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
};

if (isNil "limit_hc_gr") then {
	limit_hc_gr = false;
};

if (!hasInterface && !isDedicated) then {



	[] execVM "MilSimUnited\delete_empty_groups.sqf";


	

	["O_Plane_Fighter_02_F", "initPost", {
    	params ["_vehicle"];
    	[
        	_vehicle,
        	["Su57_Style1", 1],
        	true
    	] call BIS_fnc_initvehicle;
    	_loadout_fighter = ["FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM7F_2_P_1rnd_M", "FIR_AIM7F_2_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M"];
    
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
    
    	_loadout_CAS = ["FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "PylonRack_20Rnd_Rocket_03_HE_F", "CUP_PylonPod_1Rnd_R73_Vympel", "FIR_AIM120_P_1rnd_M"];
    
    	{
     	   vehicle _vehicle setPylonLoadout [_forEachindex, _x, true];
    	} forEach _loadout_CAS;
	}, nil, nil, true] call CBA_fnc_addClassEventHandler;

};
if (isNil "tk_active") then {
	tk_active = false
};

if (tk_active) then {
	last_shooter = objNull;
	got_shooted = objNull;
	player addEventHandler ["Dammaged", {
		params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
		if ((isPlayer _shooter) && (_shooter != _unit) && (alive _unit) && (side _shooter == west)) then {
			_msg = format ["Friendly fire from %1. Cease Fire!!!!", name _shooter];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			if(isPlayer _shooter) then {last_shooter = _shooter};
			if(isPlayer _unit) then {got_shooted = _unit};
		};
	}];
};

if (isNil "KPFC_active") then {
	KPFC_active = false
};

if (KPFC_active) then {
	player addEventHandler ["GetInMan", {[ _this select 2] execVM "KP\KPFC\kp_fuel_consumption.sqf";}];
};

all_arsenals = [];
/*
{
	_prc1 = format ["FAC_MSU\%1\arsenal.sqf", _x];
	_handle1 = player execVM _prc1;
	waitUntil {
		scriptDone _handle1
	};
	all_arsenals = all_arsenals + arsenal;
} forEach ['USMC', 'USARMY', 'BW', 'BAF', 'FFAA', 'PMC'];
*/
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



/*
if (isNil "trait_restrictions") then {
	trait_restrictions = false
};

if (trait_restrictions) then {
	//with init set no medical, or engineer, or EOD
	Player setVariable ["ace_medical_medicclass", 0, true];
	Player setVariable ["ACE_isEngineer", 0, true];
	Player setVariable ["ACE_isEOD", 0, true];
};
*/




while { true } do {
	sleep 300;
	_hs_time = systemTime;

	if (((_hs_time select 3) == 16) && ((_hs_time select 4) >= 30)) then {
		hint format['Server restart 17:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
	if (((_hs_time select 3) == 2) && ((_hs_time select 4) >= 30)) then {
		hint format['Server restart 03:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
	if (((_hs_time select 3) == 10) && ((_hs_time select 4) >= 30)) then {
		hint format['Server restart 11:00 \nFahrzeuge zurück zur FOB! \nReturn vehicles to FOB!'];
	};
};

// hint format['%1:%2', (_hs_time select 3), (_hs_time select 4)];
