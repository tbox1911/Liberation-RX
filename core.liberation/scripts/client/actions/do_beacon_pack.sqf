_tent = _this select 3;
if (isNull _tent) exitWith {};

[_tent] call is_local;

//only one at time
if ((_tent getVariable ["tent_in_use", false])) exitWith {};
_tent setVariable ["tent_in_use", true, true];

_tent setVariable ["R3F_LOG_disabled", true, true];
_pos = getPosATL _tent;

disableUserInput true;
player playMove "AinvPknlMstpSlayWnonDnon_medic";
sleep 7;
deleteVehicle _tent;
sleep 1;
if (backpack player == "") then {
	player addBackpack "B_Kitbag_Base";
} else {
	sleep 1;
	createVehicle ["B_Kitbag_Base", _pos, [], 0, "CAN_COLLIDE"];
};
disableUserInput false;
disableUserInput true;
disableUserInput false;
