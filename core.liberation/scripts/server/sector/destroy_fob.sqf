_fobpos = _this select 0;

private _classnames_to_destroy = [];
GRLIB_all_fobs = GRLIB_all_fobs - [_fobpos];
if (_fobpos in GRLIB_all_outposts) then {
	_classnames_to_destroy = [FOB_outpost, FOB_sign];
	GRLIB_all_outposts = GRLIB_all_outposts - [_fobpos];
} else {
	_classnames_to_destroy = [FOB_typename, FOB_sign];
};
publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

{ _classnames_to_destroy pushBack (_x select 0) } foreach buildings;

private _all_buildings_to_destroy = [];
_all_buildings_to_destroy = [(_fobpos nearobjects 200), { getObjectType _x >= 8 && (typeOf _x) in _classnames_to_destroy }] call BIS_fnc_conditionalSelect;
_all_buildings_to_destroy = _all_buildings_to_destroy + ([(_fobpos nearobjects 200), { (typeOf _x) in GRLIB_Ammobox_keep && [_x] call is_public }] call BIS_fnc_conditionalSelect);

{
	sleep 0.2;
	_building = _x;
	if (typeOf _building == Warehouse_typename) then {
		{
			if ((getPosATL _x) distance2D (getPosATL _building) < GRLIB_fob_range) then { deleteVehicle _x };
		} foreach allSimpleObjects ["Land_PortableDesk_01_black_F",waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename,basic_weapon_typename];

		_owner = _building getVariable ["GRLIB_WarehouseOwner", objNull];
		deleteVehicle _owner;
	};
	deleteVehicle _building;
} foreach _all_buildings_to_destroy;

stats_fobs_lost = stats_fobs_lost + 1;
sleep 1;
