params [
	"_vehicle",
	"_list",
	["_dist", 15],
	["_includeFOB", true]
];

private _ret = false;
private _classlist = [];
private _near = [];
private _vehpos = getPosATL _vehicle;

if (isNil "_list") exitWith {_ret};

switch ( _list ) do {
	case "LHD" : { _classlist = [lhd]};	
	case "SRV" : { _classlist = GRLIB_Marker_SRV};
	case "ATM" : { _classlist = GRLIB_Marker_ATM};
	case "FUEL" : { _classlist = GRLIB_Marker_FUEL};
	case "REPAIR" : { _classlist = [repair_offroad]};
	case "SHOP" : { _classlist = GRLIB_Marker_SHOP};
<<<<<<< HEAD
<<<<<<< HEAD
	case "SPAWNT" : { _classlist = GRLIB_mobile_respawn};
<<<<<<< HEAD
	case "SPAWNV" : { _classlist =  [Respawn_truck_typename, huron_typename]};
=======
	case "RESPAWN" : { _classlist = [Respawn_truck_typename, huron_typename]};
>>>>>>> 4283ee4f (fix redeploy)
=======
	case "SPAWNV" : { _classlist = [Respawn_truck_typename, huron_typename]};
>>>>>>> 1654507b (check near)
=======
	case "SPAWNT" : { _classlist = GRLIB_mobile_respawn};
	case "SPAWNV" : { _classlist = [Respawn_truck_typename, huron_typename]};
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04
	case "MEDIC" : { _classlist = ai_healing_sources};
	case "ARSENAL" : { _classlist = [Arsenal_typename]};
	case "REFUEL" : { _classlist = [canister_fuel_typename, fuelbarrel_typename]};
	case "REAMMO" : { _classlist = vehicle_rearm_sources};
	case "REAMMO_AI" : { _classlist = ai_resupply_sources};
	case "REPAIR_AI" : { _classlist = vehicle_repair_sources};
	case "REPAINT" : { _classlist = [repair_offroad, "Land_RepairDepot_01_civ_F"]};
	default { _classlist = [] };
};

// Include FOB
if (_includeFOB) then {
	if ((_vehpos distance2D ([] call F_getNearestFob)) <= (_dist * 2)) then { _ret = true };
};

if (_ret) exitWith {true};
if (_list == "FOB") exitWith {_ret};
if (count(_classlist) == 0) exitWith {false};

if (typeName (_classlist select 0) == "STRING") then {
	// From Objects classname
	_near = [ _vehpos nearEntities [_classlist, _dist], {
	//_near = [ nearestObjects [_vehpos, _classlist, _dist], {
		alive _x &&
		( 
			isNull (_x getVariable ["R3F_LOG_est_transporte_par", objNull]) || 
			!(_x getVariable ['R3F_LOG_disabled', true])
		)
	}] call BIS_fnc_conditionalSelect;
} else {
	// From Position
	_near = _classlist select { (_vehpos distance2D _x) <= _dist };
};

if (count _near > 0) then {_ret = true};

_ret;