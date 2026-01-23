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
if (typeName _vehicle == "OBJECT") then { _vehpos = getPos _vehicle };

if (isNil "_list") exitWith { false };

switch ( _list ) do {
	case "LHD" : { _classlist = [lhd] };
	case "SRV" : { _classlist = GRLIB_Marker_SRV };
	case "ATM" : { _classlist = GRLIB_Marker_ATM };
	case "FUEL" : { _classlist = GRLIB_Marker_FUEL };
	case "SHOP" : { _classlist = GRLIB_Marker_SHOP };
	case "REP" : { _classlist = GRLIB_Marker_REP };
	case "SPAWN" : { _classlist = ([] call F_getMobileRespawns) select {typeOf _x != mobile_respawn} };
	case "SPAWNT" : { _classlist = ([] call F_getMobileRespawns) select {typeOf _x == mobile_respawn} };
	case "MEDIC" : { _classlist = ai_healing_sources };
	case "ARSENAL" : { _classlist = [Arsenal_typename] };
	case "REFUEL" : { _classlist = vehicle_refuel_sources; _use_fast = false };
	case "REAMMO" : { _classlist = vehicle_rearm_sources };
	case "REAMMO_AI" : { _classlist = ai_resupply_sources };
	case "REPAIR" : { _classlist = vehicle_repair_sources };
	case "REPAIR_BOX" : { _classlist = vehicle_repair_box };
	case "REPAINT" : { _classlist = vehicle_repaint_sources };
	case "WAREHOUSE" : { _classlist = [Warehouse_typename]; _use_fast = false };
	case "TRANSPORT" : { _classlist = transport_vehicles; _use_fast = false };
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
		_near = _obj_list select {
			alive _x && getObjectType _x >= 8 &&
			(
				(_x getVariable ["GRLIB_vehicle_owner", ""] == "server") ||
				!(_x getVariable ['R3F_LOG_disabled', false]) ||
				!(isNull (attachedTo  _x))
			)
		};
	};
} else {
	// From Position
	_near = _classlist select { (_vehpos distance2D _x) <= _dist };
};

if (count _near > 0) then {_ret = true};

_ret;