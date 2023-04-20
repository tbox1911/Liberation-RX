_fobpos = _this select 0;

private _classnames_to_destroy = [];
private _near_outpost = (count (_fobpos nearObjects [FOB_outpost, 100]) > 0);
if (_near_outpost) then {
	_classnames_to_destroy = [FOB_outpost];
} else {
	_classnames_to_destroy = [FOB_typename];
};

{
	_classnames_to_destroy = _classnames_to_destroy + [(_x select 0)];
} foreach buildings;

_nextbuildingsdestroy = [ (_fobpos nearobjects 150) , { getObjectType _x >= 8 } ] call BIS_fnc_conditionalSelect;
_all_buildings_to_destroy = [];
{
	if ( (typeof _x) in _classnames_to_destroy ) then {
		_all_buildings_to_destroy = _all_buildings_to_destroy + [_x];
	};
} foreach _nextbuildingsdestroy;

{
	_x setdamage 1;
	sleep floor(random 4);
	deleteVehicle _x;
} foreach _all_buildings_to_destroy