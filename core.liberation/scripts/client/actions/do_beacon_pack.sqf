private _tent = cursorObject;

//only one at time
if ((_tent getVariable ["tent_in_use", false])) exitWith {};
if (player getVariable ["GRLIB_action_inuse", false]) exitWith {};

player setVariable ["GRLIB_action_inuse", true, true];
_tent setVariable ["tent_in_use", true, true];
_tent setVariable ["R3F_LOG_disabled", true, true];

disableUserInput true;
player switchMove "AinvPknlMstpSlayWnonDnon_medic";
player playMoveNow "AinvPknlMstpSlayWnonDnon_medic";
sleep 6;
[_tent, "del"] remoteExec ["mobile_respawn_remote_call", 2];
sleep 2;
if (backpack player == "") then {
	player addBackpack mobile_respawn_bag;
	(backpackContainer player) setVariable ["GRLIB_mobile_respawn_bag", true, true];
	[(backpackContainer player), 0] remoteExec ["setMaxLoad", 2];
} else {
	sleep 1;
	private _backpack = createVehicle [mobile_respawn_bag, (player getRelPos[3, 0]), [], 0, "NONE"];
	_backpack setVariable ["GRLIB_mobile_respawn_bag", true, true];
	[_backpack, 0] remoteExec ["setMaxLoad", 2];
};
disableUserInput false;
disableUserInput true;
disableUserInput false;
sleep 3;
player setVariable ["GRLIB_action_inuse", false, true];
