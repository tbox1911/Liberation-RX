private _msg = format [localize "STR_CLEAR_DEFENSE_MSG"];
private _result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if !(_result) exitWith {};

private _fob = (player nearObjects [FOB_typename, 20] select 0);
if (isNil "_fob") exitWith {};

private _fob_pos = getPosATL _fob;
private _objects_to_delete = fob_defenses_classnames - (GRLIB_recycleable_blacklist + all_friendly_classnames);
{
    if (getObjectType _x >= 8 && _x distance2D _fob_pos > 14) then { deleteVehicle _x };
    sleep 0.05;
} foreach (nearestObjects [_fob_pos, _objects_to_delete, GRLIB_fob_range]);

gamelogic globalChat format ["FOB %1 Defenses Removed...", ([_fob_pos] call F_getFobName)];
