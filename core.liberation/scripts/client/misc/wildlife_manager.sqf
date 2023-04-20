// Dynamic Animal - by vandeanson
// https://forums.bohemia.net/forums/topic/218268-dynamic-animalgame-spawn-script-by-vandeanson/
// updated by: pSiKO

waituntil {sleep 1;!isNull player};
waitUntil {sleep 1;GRLIB_player_spawned};

GRLIB_wildlife_max = 4;
GRLIB_wildlife_group = 0;

while {true} do {

	_nearestMarker = [(sectors_capture + sectors_bigtown + sectors_factory + sectors_military), player] call BIS_fnc_nearestPosition;
	_secdistance = round (player distance2D (markerpos _nearestMarker));
	_fobdistance = round (player distance2D ([] call F_getNearestFob));

	if (GRLIB_wildlife_group <= GRLIB_wildlife_max && (player distance lhd >= 1000) && _secdistance > (GRLIB_sector_size / 2) && _fobdistance > GRLIB_sector_size && vehicle player == player) then {

		_pos = [getPosATL player, 120, 350, 0, 0, 100 , 0] call BIS_fnc_findSafePos;
		_wildlife_grp = createGroup [GRLIB_side_civilian, true];
		if(isNil("_wildlife_grp")) exitWith {diag_log "DBG: Cannot create Animals group."};

		_type = ["Hen_random_F","Goat_random_F","Cock_random_F","Fin_random_F","Sheep_random_F"] call BIS_fnc_selectRandom;
		_nbUnits = round (2 + random 4);
		if (_type == "Fin_random_F") then {_nbUnits = 2};
		if (_type == "Hen_random_F") then {_nbUnits = _nbUnits + 3};

		for "_i" from 1 to _nbUnits do {
			_unit = _wildlife_grp createUnit [_type, _pos, [], 1, "FORM"];
			_unit setName "Animal";
			_unit setVariable ["BIS_fnc_animalBehaviour_disable", true];
			_unit addMPEventHandler ["MPKilled", {[_this select 0] spawn {sleep 60;deleteVehicle (_this select 0)}}];
			_unit setSpeaker "NoVoice";
			//_unit disableAI "FSM";
			_unit disableAI "AIMINGERROR";
			_unit disableAI "SUPPRESSION";
			_unit disableAI "AUTOTARGET";
			_unit disableAI "TARGET";
			_unit setCombatMode "BLUE";
			_unit setBehaviour "SAFE";
		};

		GRLIB_wildlife_group = GRLIB_wildlife_group + 1;
		while {(count (waypoints _wildlife_grp)) != 0} do {deleteWaypoint ((waypoints _wildlife_grp) select 0)};
		[_wildlife_grp, _pos, GRLIB_sector_size] call BIS_fnc_taskPatrol;
		sleep 2;

		[_wildlife_grp] spawn {
			params ["_grp"];
			while {count units _grp > 0} do {
				sleep (60 + random 60);
				{
					if (player distance2D _x > (GRLIB_sector_size * 2)) then { deleteVehicle _x };
				} forEach units _grp;
			};
			GRLIB_wildlife_group = GRLIB_wildlife_group - 1;
		};
	};
 	sleep (60 + random 60);
};