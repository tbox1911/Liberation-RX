if (!isServer && hasInterface) exitWith {};
params [ "_player", "_tunnel_name" ];
diag_log format ["--- LRX SoG: Tunnel %1 started", _tunnel_name];

private _grp = grpNull;
private _start_pos = getPosATL _player;
private _active_players = 0;
private _active_enemy = 0;
private _tunnel_building = nearestObjects [_start_pos, ["Land_vn_tunnel_01_building_01_01","Land_vn_tunnel_01_building_04_01","Land_vn_tunnel_01_building_03_01","Land_vn_tunnel_01_building_02_01"], 200];
private _tunnel = missionNameSpace getVariable [_tunnel_name, "error_no_tunnel"];

// count players
_active_players = { alive _x && (_x distance2D _start_pos) < 200} count (units GRLIB_side_friendly);

if (_active_players > 1) exitWith {
	private _first_grp = _tunnel getVariable ["SOG_enemy_group", grpNull];
	private _new_grp = [_tunnel_building, GRLIB_side_enemy, 5, ['vn_o_men_vc_regional_05','vn_o_men_vc_regional_07']] call vn_fnc_tunnel_spawn_units;
	sleep 0.5;
	(units _new_grp) joinSilent _first_grp;
	deletegroup _new_grp;
};

if (_active_players == 1) then {
	_grp = [_tunnel_building, GRLIB_side_enemy, 10, ['vn_o_men_vc_regional_01','vn_o_men_vc_regional_04','vn_o_men_vc_regional_08']] call vn_fnc_tunnel_spawn_units;
	sleep 0.5;
	_tunnel setVariable ["SOG_enemy_group", _grp];
};

// loop
private _mission_continue = true;
while { _mission_continue } do {
	_active_players = { alive _x && (_x distance2D _start_pos) < 200} count (units GRLIB_side_friendly);
	_active_enemy = { alive _x && (_x distance2D _start_pos) < 200} count (units _grp);
	if (_active_players == 0 || _active_enemy == 0) then { _mission_continue = false };
	sleep 2;
};

// victory
if (_active_enemy == 0) then {
	private _position = (_tunnel getVariable ["tunnel_position", 0]) + 1;
	private _bonus = 100;
	{
		[_x, _bonus] call F_addScore;
		[_position, _bonus] remoteExec ["remote_call_tunnel_success", owner _x];
	} forEach (allPlayers select { alive _x && (_x distance2D _start_pos) < 200});
};

// cleanup
{ deleteVehicle _x} foreach (units _grp);
deletegroup _grp;
_tunnel setVariable ["SOG_enemy_group", nil];

diag_log format ["--- LRX SoG: Tunnel %1 finsished", _tunnel_name];