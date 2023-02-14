waitUntil {
	!isNull player
};

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

_rules = "
DE:<br />
Regelwerk MiSim United<br />
<br />
1.    Allgemeines<br />
1.1    Trolling, Beleidigung, Rassismus, sexuelle Belästigung so wie alles, was strafrechtlich verfolgt wird ist verboten und führt zum Ausschluss.<br />
1.2    Das Recycling, Stehlen oder Zerstören von Fahrzeugen anderer Spieler ist untersagt.<br />
1.3    Schießen innerhalb der FOBs ist nur zu deren Verteidigung erlaubt.<br />
1.4    Den Anweisungen von Moderatoren ist Folge zu leisten.<br />
1.5    Bei Verlust von Fahrzeugen durch Bugs etc. liegt es im Ermessen der Moderatoren, eine Erstattung zu gewähren. (Videobeweis hilft hierbei.)<br />
1.6    Bei Streitigkeiten mit Moderatoren ruhig bleiben, einen weiteren hinzuholen und ggf. ein Video machen.<br />
1.7    Ausnutzen von Programmfehlern, Bugs, Exploits etc. ist verboten.<br />
<br />
<br />
2.    Gruppen<br />
2.1    Gruppen haben sich im Gruppenmanager ordentlich einzutragen. (Rufname, Kurzfunk Freq., Funktion)<br />
2.2    Benennung der Gruppen ist militärisch zu halten. (kein Einhorn, Biertrinker etc. Rufnamen)<br />
2.3    Innerhalb der Gruppe hat der Gruppenführer das sagen.<br />
<br />
<br />
3.    Ausrüstung und Slots<br />
3.1    Wer einen Slot belegt, muss ausreichend qualifiziert sein und die jeweilige Dienstleistung auch tatsächlich für andere zur Verfügung stellen. Kampfpiloten müssen CAS durchführen, Engineers müssen reparieren, Medics müssen heilen, etc. und HQ muss ein möglichst angenehmes Spielerlebnis für seine Truppen organisieren.<br />
3.2    Piloten-Slots stehen für die maximale Anzahl der jeweiligen Luftfahrzeuge. Co-Pilot, Gunner oder Crew sind beliebig zu besetzen, sofern dadurch nicht 3.1 verletzt wird.<br />
3.3    Die Ausrüstung der dargestellten Klasse muss in den Bereich Milsim passen. (beispielsweise; keine Ghilli-Medic-Javelin-Sniper oder Panzerbesatzungen mit Javelin auf dem Rücken)<br />
<br />
<br />
4.     Fahrzeuge<br />
4.1     Boden- und Luftfahrzeuge sind Unterstützungselemente, sie dürfen den Feuerkampf ausschließlich zur Selbstverteidigung selbständig aufnehmen, wenn kein Auftrag von Infanterieeinheiten vorliegt.<br />
4.2    Regel der Selbstverteidigung trifft nicht zu, wenn ein Fahrzeug sich fahrlässig und ohne Auftrag der Infanterie zu nah an eine Zone begibt!<br />
4.3    Zum Besetzen der Fahrzeuge darf man als Engineer slotten. (Entsprechende ausnahme zu 3.1)<br />
<br />
<br />
5.    Funk und Funkfrequenzen <br />
5.1    Jede Bodeneinheit muss ein Long Range Radio auf Freq. 50 haben, um dort erreichbar zu sein<br />
 5.2    Jede Lufteinheit muss ein Long Range Radio mit Freq. 51 und 52 haben, um dort erreichbar zu sein. Ausnahmen sind nur gültig, falls ein JTAC die Lufteinheit aktiv einsetzt.<br />
 5.3    Frequenz 50 ist ausschließlich zur Boden-Kommunikation!<br />
 5.4    Frequenz 51 ist ausschließlich zur Boden-Luft-Kommunikation!<br />
 5.5    Frequenz 52 ist ausschließlich zur Luft-Luft-Kommunikation!<br />
 5.6    Funkdisziplin ist einzuhalten, kurze Funksprüche, kein Kaffeeklatsch. (denken, drücken, sprechen)<br />
 <br />
<br />
6.    Teamplay ist Teil der Milsim-Erfahrung, handelt entsprechend!<br />
<br />
<br />
<br />
<br />
EN:<br />
Rules MiSim United<br />
<br />
1. General<br />
1.1 Trolling, insults, racism, sexual harassment as well as anything that will be prosecuted is prohibited and will result in a serverban.<br />
1.2 Recycling, stealing or destroying other players' vehicles is prohibited.<br />
1.3 Shooting within the FOBs is only permitted for defense of said FOB.<br />
1.4 The instructions of moderators must be followed without discussion.<br />
1.5 If vehicles are lost due to bugs etc..., it is at the discretion of the moderators to grant a refund. (Video proof helps with this.)<br />
1.6 Stay calm in the event of disputes with moderators, bring in another player and, if necessary, make a video.<br />
1.7 Using program errors, bugs, exploits, etc. is prohibited.<br />
<br />
<br />
2. Groups<br />
2.1 Groups have to register properly in the group manager. (ACE-selfinteraction -> Teammanagement)<br />
2.2 Naming of the groups is to be kept militarily. (no unicorn, beer drinker etc. first name or any other conflict with rule 1.1)<br />
2.3 Within the group, the group leader has the say.<br />
<br />
<br />
3. Gear and Slots<br />
3.1 If you occupy a slot, you have to be qualified and actually provide the said service for others. Combat pilots have to do CAS, engineers have to repair, medics have to heal, etc. and HQ has to organize an enjoyable gameplay experience for his troops.<br />
3.2    Pilot slots stand for the max amount of air assets. Co-pilots, gunners or crew can be manned as you please as long as it is no violation of 3.1.<br />
3.3    Equipment of the class that was selected in the server lobby must fit within the Milsim area. (e.g.; no Ghilli Medic javelin snipers or tank crews with javelin on their backs)<br />
<br />
<br />
4. Vehicles<br />
4.1 Ground and air vehicles are support elements, they may only engage in firefightings independently for self-defense if there is no order from infantry units.<br />
4.2 Rule of self-defense does not apply if a vehicle negligently and without order of the infantry goes too close to a zone!<br />
4.3 To occupy the vehicles, you may slot as an engineer. (Corresponding exception to 3.1)<br />
<br />
<br />
5. Radio and Radio Frequencies <br />
5.1 Each ground unit must have a long range radio tuned to Freq. 50 to be reachable there.<br />
  5.2 Each air unit must have a Long Range Radio with Freq. 51 and 52 to be reachable there. Exceptions are only valid if a JTAC is actively using the air unit.<br />
  5.3 Frequency 50 is for ground communication only!<br />
  5.4 Frequency 51 is for ground-to-air communications only!<br />
  5.5 Frequency 52 is for air-to-air communications only!<br />
  5.6 Radio discipline must be observed, short radio messages, no coffee gossip. (think, press, speak)<br />
 <br />
<br />
6. Team play is part of the Milsim experience, act accordingly!<br />
<br />
<br />
<br />
<br />
";

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

player createDiarySubject ["Regeln / Rules","Regeln / Rules"];
player createDiaryRecord ["Regeln / Rules", ["Regeln / Rules", _rules]];

// player createDiaryRecord ['Diary', ['Regeln / Rules', _rules], taskNull, '', false];
// player createDiaryRecord ['Diary', ['Situation', _situation], taskNull, '', false];

sleep 10;

execVM "scripts\client\misc\vehicle_restriction.sqf";
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
