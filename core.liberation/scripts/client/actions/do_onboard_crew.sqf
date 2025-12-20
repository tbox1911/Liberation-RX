params ["_target", "_caller", "_actionId", "_arguments"];

private _vehicle = objectParent _target;
if (isNull _vehicle) exitWith {};

gamelogic globalChat format [localize "STR_ONBOARD_ALL_CREW", [_vehicle] call F_getLRXName];

private _list_board = (units _target) select {
    !(isPlayer _x) && (isNull objectParent _x) &&
    (_x distance2D player <= 30) && !(captive _x)
};

[_vehicle, _list_board, false] call F_manualCrew;
