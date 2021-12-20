_tent = _this select 3;
if (isNull _tent) exitWith {};

//only one at time
if ((_tent getVariable ["tent_in_use", false])) exitWith {};
player setVariable ["GRLIB_action_inuse", true];
_tent setVariable ["tent_in_use", true, true];
_tent setVariable ["R3F_LOG_disabled", true, true];
_pos = getPosATL _tent;

disableUserInput true;
player playMove "AinvPknlMstpSlayWnonDnon_medic";
sleep 7;
[_tent, "del"] remoteExec ["addel_beacon_remote_call", 2];
sleep 1;
if (backpack player == "") then {
	player addBackpack mobile_respawn_bag;
} else {
	sleep 1;
	createVehicle [mobile_respawn_bag, _pos, [], 0, "CAN_COLLIDE"];
};
disableUserInput false;
disableUserInput true;
disableUserInput false;
player setVariable ["GRLIB_action_inuse", false];