params ["_vehicle", "_list", "_dist", "_includeFOB"];

private _ret = false;
private _classlist = [];
private _near = [];
private _vehpos = getPosATL _vehicle;

if (isNil "_list") exitWith {_ret};
if (isNil "_dist") then {_dist = 15};
if (isNil "_includeFOB") then {_includeFOB = true};

switch ( _list ) do {
	case "SRV" : { _classlist = GRLIB_Marker_SRV};
	case "ATM" : { _classlist = GRLIB_Marker_ATM};
	case "FUEL" : { _classlist = GRLIB_Marker_FUEL};
	case "REPAIR" : { _classlist = GRLIB_Marker_REPAIR};
	case "SHOP" : { _classlist = GRLIB_Marker_SHOP};
	case "SPAWNT" : { _classlist = GRLIB_mobile_respawn};
	case "SPAWNV" : { _classlist =  [Respawn_truck_typename, huron_typename]};
	case "MEDIC" : { _classlist = ai_healing_sources};
	case "ARSENAL" : { _classlist = [Arsenal_typename]};
	case "REAMMO" : { _classlist = vehicle_rearm_sources};
	case "REAMMO_AI" : { _classlist = ai_resupply_sources};
	case "REPAIR_AI" : { _classlist = vehicle_repair_sources};
};

// Include FOB
if (_includeFOB) then {
	_nearfob = [] call F_getNearestFob;
	_fobdistance = round (_vehpos distance2D _nearfob);
	if (_fobdistance <= (_dist * 2) ) then {_ret = true};
};

if (_ret) exitWith {true};
if (count(_classlist) == 0) exitWith {false};

if (typeName (_classlist select 0) == "STRING") then {
	// From Objects classname
	_near = [ _vehpos nearEntities [_classlist, _dist], {
			alive _x &&
			( 
			  typeOf _x in [Arsenal_typename] || 
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