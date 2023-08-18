params [
	"_vehicle",
	"_list",
	["_dist", 15],
	["_includeFOB", true]
];

private _ret = false;
private _only_outpost = false;
private _use_fast = true;
private _classlist = [];
private _obj_list = [];
private _near = [];
private _vehpos = _vehicle;
if (typeName _vehicle == "OBJECT" ) then {
	_vehpos = getPosATL _vehicle;
};

if (isNil "_list") exitWith {_ret};

switch ( _list ) do {
	case "LHD" : { _classlist = [lhd]};	
	case "SRV" : { _classlist = GRLIB_Marker_SRV};
	case "ATM" : { _classlist = GRLIB_Marker_ATM};
	case "FUEL" : { _classlist = GRLIB_Marker_FUEL};
	case "REPAIR" : { _classlist = [repair_offroad]};
	case "SHOP" : { _classlist = GRLIB_Marker_SHOP};
	case "SPAWNT" : { _classlist = GRLIB_mobile_respawn};
	case "SPAWNV" : { _classlist = [Respawn_truck_typename, huron_typename]};
	case "MEDIC" : { _classlist = ai_healing_sources};
	case "ARSENAL" : { _classlist = [Arsenal_typename]};
	case "REFUEL" : { _classlist = [canister_fuel_typename, fuelbarrel_typename]};
	case "REAMMO" : { _classlist = vehicle_rearm_sources};
	case "REAMMO_AI" : { _classlist = ai_resupply_sources};
	case "REPAIR_AI" : { _classlist = vehicle_repair_sources};
	case "REPAINT" : { _classlist = [repair_offroad, "Land_RepairDepot_01_civ_F"]};
	case "WAREHOUSE" : { _classlist = [Warehouse_typename]; _use_fast = false};
	default { _classlist = [] };
};

// Include FOB / Outpost
if (_includeFOB) then {
	if (_list == "OUTPOST") then { _only_outpost = true };
	if ((_vehpos distance2D ([_vehpos, _only_outpost] call F_getNearestFob)) <= _dist) then { _ret = true };
};
if (_ret) exitWith {true};
if (_list in ["FOB", "OUTPOST"]) exitWith {_ret};
if (count(_classlist) == 0) exitWith {false};

if (typeName (_classlist select 0) == "STRING") then {
	// From Objects classname
	if (_use_fast) then {
		// fast but don't detect everything		
		_obj_list = _vehpos nearEntities [_classlist, _dist];
	} else {
		// powerfull but slower		
		_obj_list = nearestObjects [_vehpos, _classlist, _dist];
	};
	if (count _obj_list > 0) then {
		_near = [ _obj_list, {
			alive _x && getObjectType _x >= 8 &&
			( 
				isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) || 
				!(_x getVariable ['R3F_LOG_disabled', true])
			)
		}] call BIS_fnc_conditionalSelect;
	};
} else {
	// From Position
	_near = _classlist select { (_vehpos distance2D _x) <= _dist };
};

if (count _near > 0) then {_ret = true};

_ret;