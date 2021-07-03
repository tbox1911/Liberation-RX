disableUserInput true;
titleText ["Loading...","BLACK FADED", 1000];

waitUntil {sleep 1; alive player};
player setPos ((getmarkerpos GRLIB_respawn_marker) findEmptyPosition [0,20, "B_soldier_F"]);
if (GRLIB_mod_west in ["A3_OPF","RHS_AFRF"]) then {
    // an ugly workaround to change player spawn class from B_xxx to O_xxx
	_player = player;
	private _r1 = (typeOf player) splitString "";
	_r1 set [0, "O"];
	_group = createGroup [GRLIB_side_friendly, true];
	(_r1 joinString "") createUnit [position player, _group, ""];
	sleep 2;
	selectPlayer (units _group select 0);
	deleteVehicle _player;
    [] call compile preprocessFileLineNumbers "addons\SDB_DALE\functions\fn_initBriefing.sqf";
    [] call compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
    
};