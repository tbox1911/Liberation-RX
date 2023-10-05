_fobpos = _this select 0;

GRLIB_all_fobs = GRLIB_all_fobs - [_fobpos];

private _classnames_to_destroy = [FOB_typename, FOB_outpost, FOB_sign, Warehouse_desk_typename];
_classnames_to_destroy append all_buildings_classnames;

publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

private _all_buildings_to_destroy = [];
_all_buildings_to_destroy = [(_fobpos nearobjects 200), { getObjectType _x >= 8 && (typeOf _x) in _classnames_to_destroy }] call BIS_fnc_conditionalSelect;

{
	sleep 0.2;
	_building = _x;
	if (typeOf _building == Warehouse_typename) then {
		{
			if ((getPosATL _x) distance2D (getPosATL _building) < GRLIB_fob_range) then { deleteVehicle _x };
		} foreach allSimpleObjects [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename,basic_weapon_typename];

		private _owner = _building getVariable ["GRLIB_WarehouseOwner", objNull];
		deleteVehicle _owner;
	};

	if (typeOf _building == FOB_typename) then {
		deleteVehicle (_building getVariable ["GRLIB_FOB_Officer", objNull]);
		{ deleteVehicle _x } forEach (_building getVariable ["GRLIB_FOB_Objects", []]);
	};

	deleteVehicle _building;
} foreach _all_buildings_to_destroy;

stats_fobs_lost = stats_fobs_lost + 1;
sleep 1;
