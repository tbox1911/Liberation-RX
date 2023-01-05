_fobpos = _this select 0;

private _classnames_to_destroy = [];
private _near_outpost = (count (_fobpos nearObjects [FOB_outpost, 50]) > 0);
if (_near_outpost) then {
	_classnames_to_destroy = [FOB_outpost, FOB_sign];
} else {
	_classnames_to_destroy = [FOB_typename, FOB_sign];
};

{ _classnames_to_destroy pushBack (_x select 0) } foreach buildings;

private _all_buildings_to_destroy = [(_fobpos nearobjects 200) , { getObjectType _x >= 8 && (typeOf _x) in _classnames_to_destroy }] call BIS_fnc_conditionalSelect;

{
	sleep 0.5;
	deleteVehicle _x;
} foreach _all_buildings_to_destroy