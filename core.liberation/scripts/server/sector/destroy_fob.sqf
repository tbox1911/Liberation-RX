params ["_fob_pos"];

private _classnames_to_destroy = [
	FOB_typename,
	FOB_outpost,
	FOB_carrier,
	FOB_sign,
	Warehouse_typename,
	Warehouse_desk_typename,
	"Land_RepairDepot_01_civ_F",
	"Land_MedicalTent_01_base_F",
	"Helipad_base_F",
	"Land_fs_feed_F"
];

private _classnames_to_destroy_naval = [
	"FlagCarrier",
	"Land_Destroyer_01_hull_base_F",
	"Land_Carrier_01_hull_base_F"
];	

_classnames_to_destroy append all_buildings_classnames + fob_defenses_classnames + list_static_weapons;

private _sleep = 0.05;
if (surfaceIsWater _fob_pos) then {
	_classnames_to_destroy append support_vehicles_classname;
	_sleep = 0;
};

private _all_buildings_to_destroy = (nearestObjects [_fob_pos, _classnames_to_destroy, (GRLIB_fob_range * 2)]) select { getObjectType _x >= 8 };
_all_buildings_to_destroy = _all_buildings_to_destroy + (nearestObjects [_fob_pos, _classnames_to_destroy_naval, 350]) select { getObjectType _x >= 8 };
if (count _all_buildings_to_destroy > 300) then { _sleep = 0 };

{
	_building = _x;
	if (typeOf _building == Warehouse_typename) then {
		{
			if (_x distance2D _building < 30) then { deleteVehicle _x };
		} foreach allSimpleObjects [waterbarrel_typename,fuelbarrel_typename,foodbarrel_typename,basic_weapon_typename];

		deleteVehicle (_building getVariable ["GRLIB_WarehouseOwner", objNull]);
	};

	if (typeOf _building == FOB_typename) then {
		{ deleteVehicle _x } forEach (_building getVariable ["GRLIB_FOB_Objects", []]);
		deleteVehicle (_building getVariable ["GRLIB_FOB_Officer", objNull]);
	};
	deleteVehicle _building;
	sleep _sleep;
} foreach _all_buildings_to_destroy;

_all_buildings_to_destroy = (_fob_pos nearObjects (GRLIB_fob_range * 2)) select { getObjectType _x >= 8 && (getPos _x select 2) >= 2 };
{ _x setPos (getPos _x)} forEach _all_buildings_to_destroy;

private _sector = format ["fobmarker%1", (GRLIB_all_fobs find _fob_pos)];
[_sector, 0] call sector_defenses_remote_call;

diag_log format ["FOB %1 destroyed at %2", _fob_pos, time];

GRLIB_all_fobs = GRLIB_all_fobs - [_fob_pos];
publicVariable "GRLIB_all_fobs";
GRLIB_all_outposts = GRLIB_all_outposts - [_fob_pos];
publicVariable "GRLIB_all_outposts";

stats_fobs_lost = stats_fobs_lost + 1;

if (GRLIB_Commander_mode) then { [] call manage_sectors_commander };
