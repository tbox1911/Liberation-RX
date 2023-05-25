// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_RoadBlock.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_bunker", "_def1", "_def2", "_veh1", "_veh2"];

_setupVars =
{
	_missionType = localize "STR_ROADBLOCK";
	_locationsArray = nil;
	GRLIB_A3W_Mission_BR = (10 * 60);
};

_setupObjects =
{
	// find a pos near a road, between opfor sector and blufor
	_missionPos = [];
	private _opfor_sectors = (sectors_allSectors - blufor_sectors);
	{
		_sector_pos = markerpos _x;
		_info = [_sector_pos, false] call F_getNearestBluforObjective;
		_dist = _info select 1;
		_found = false;
		if (_dist > (GRLIB_sector_size + 100) && _dist < 3000) then {
			_idx = 100;
			while {count _missionPos == 0 && _idx > 0} do {
				_missionPos = _sector_pos getPos [300 + (round(random 100) -50), random 360];
				_no_road = (!isOnRoad _missionPos);
				_no_water = (!surfaceIsWater _missionPos);
				_no_build = (count (nearestTerrainObjects [_missionPos, ["BUILDING","HOUSE","QUAY","ROCKS"], 30, false, true]) == 0);
				_no_blu = (([_missionPos, false] call F_getNearestBluforObjective) select 1 > (GRLIB_sector_size + 100));

				if (_no_road && _no_water && _no_build && _no_blu) then {
					_roads = _missionPos nearRoads 40;
					_valid = true;
					{
						if (_missionPos distance2D _x < 20) exitWith { _valid = false };
					} forEach _roads;

					{
						if (_valid && (getRoadInfo _x select 0) in ["TRACK","ROAD","MAIN ROAD"]) exitWith { _found = true };
					} forEach _roads;
				};
				if !(_found) then { _missionPos = [] };
				_idx = _idx - 1;
			};
		};
		if (_found) exitWith { _missionPos };
	} foreach (_opfor_sectors call BIS_fnc_arrayShuffle);

	if (count _missionPos == 0) exitWith { false };		// no location found

	//----- build Check point ---------------------------------
	_road_dir = _missionPos getDir ((_missionPos nearRoads 40) select 0);
	_bunker_typename = selectRandom ["Land_BagBunker_Small_F"];
	_bunker = createVehicle [_bunker_typename, _missionPos, [], 0, "None"];
	_bunker setVectorDirAndUp [[-cos (_road_dir - 180), sin (_road_dir - 180), 0] vectorCrossProduct surfaceNormal _missionPos, surfaceNormal _missionPos];
	_bunker setVariable ["R3F_LOG_disabled", true, true];

	_bunker_dir = (90 + getdir _bunker);
	_def1_pos = (getPos _bunker) vectorAdd ([[0, 12, 0], -_bunker_dir] call BIS_fnc_rotateVector2D);
	_def1 = createVehicle ["Land_BagFence_Round_F", _def1_pos, [], 1, "None"];
	_def1 setVectorDirAndUp [[-cos (_bunker_dir - 180), sin (_bunker_dir - 180), 0] vectorCrossProduct surfaceNormal _def1_pos, surfaceNormal _def1_pos];
	_def1 setPosATL _def1_pos;
	_def1 setVariable ["R3F_LOG_disabled", true, true];

	_def2_pos = (getPosATL _bunker) vectorAdd ([[0, -12, 0], -_bunker_dir] call BIS_fnc_rotateVector2D);
	_def2 = createVehicle ["Land_BagFence_Round_F", _def2_pos, [], 1, "None"];
	_def2 setVectorDirAndUp [[-cos _bunker_dir, sin _bunker_dir, 0] vectorCrossProduct surfaceNormal _def2_pos, surfaceNormal _def2_pos];
	_def2 setPosATL _def2_pos;
	_def2 setVariable ["R3F_LOG_disabled", true, true];

	_veh1_class = selectRandom (opfor_statics select {!(_x isKindOf "StaticMortar")});
	_veh1_pos = (getPosATL _def1) vectorAdd ([[0, -1, 0.1], - _bunker_dir] call BIS_fnc_rotateVector2D);
	_veh1 = createVehicle [_veh1_class, _veh1_pos, [], 0, "None"];
	_veh1 disableCollisionWith _def1;
	_veh1 setDir _bunker_dir;
	_veh1 setPos _veh1_pos;

	_veh2_class = selectRandom (opfor_statics select {!(_x isKindOf "StaticMortar")});
	_veh2_pos = (getPosATL _def2) vectorAdd ([[0, 1, 0.1], - _bunker_dir] call BIS_fnc_rotateVector2D);
	_veh2 = createVehicle [_veh2_class, _veh2_pos, [], 0, "None"];
	_veh2 disableCollisionWith _def2;
	_veh2 setDir (_bunker_dir -180);
	_veh2 setPos _veh2_pos;

	//----- spawn units ---------------------------------
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	_nbUnits = 3;
	[_aiGroup, _missionPos, _nbUnits, "guard"] call createCustomGroup;

	_guard = (units _aiGroup) select 0;
	_guard setPos (getPos _bunker);
	[_guard, ""] spawn building_defence_ai;

	_gunner = (units _aiGroup) select 1;
	_gunner assignAsGunner _veh1;
	_gunner moveInGunner _veh1;
	[_gunner] orderGetIn true;
	_veh1 setVariable ["GRLIB_vehicle_gunner", [_gunner]];

	_gunner = (units _aiGroup) select 2;
	_gunner assignAsGunner _veh2;
	_gunner moveInGunner _veh2;
	[_gunner] orderGetIn true;
	_veh2 setVariable ["GRLIB_vehicle_gunner", [_gunner]];

	_nbUnits = [] call getNbUnits;
	[_aiGroup, _missionPos, _nbUnits, "infantry"] call createCustomGroup;

	_missionPicture = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa";
	_missionHintText = localize "STR_ROADBLOCK_MESSAGE1";
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = {
	if ((count ([_missionPos, 500] call F_getNearbyPlayers) > 0) ) then {
		GRLIB_A3W_Mission_BR = GRLIB_A3W_Mission_BR - 1;
		if (GRLIB_A3W_Mission_BR == 0) then {
			{
				if (_x distance2D _missionPos < GRLIB_capture_size) then {
					_msg = ["<t color='#FFFFFF' size='2'>You have been Detected!!<br/><br/>Enemies launch the </t><t color='#ff0000' size='3'>RED ALERT</t><t color='#FFFFFF' size='2'> !!</t>", "PLAIN", -1, false, true];
					[_msg] remoteExec ["titleText", owner _x];
				};
			} forEach (AllPlayers - (entities "HeadlessClient_F"));
			[_missionPos] spawn send_paratroopers;
			GRLIB_A3W_Mission_BR = (30 * 60);
		};
	};
};
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_bunker, _def1, _def2, _veh1, _veh2];
};

_successExec = {
	// Mission completed
	private _rwd_ammo = (100 + floor(random 100));
	private _rwd_fuel = (10 + floor(random 10));
	private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];
	{
		if (_x distance2D _missionPos < GRLIB_capture_size) then {
			[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
			[gamelogic, _text] remoteExec ["globalChat", owner _x];
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));

	_successHintMessage = localize "STR_ROADBLOCK_MESSAGE2";
};

_this call sideMissionProcessor;
