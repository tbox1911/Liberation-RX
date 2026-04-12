params [
	"_vehicle",
	"_list",
	["_dist", 15],
	["_includeFOB", true]
];

if (isNil "_list") exitWith { false };

private _vehpos = _vehicle;
if (typeName _vehicle == "OBJECT") then {
	_vehpos = getPosATL _vehicle;
	if (surfaceIsWater _vehpos) then { _vehpos = getPosASL _vehicle };
};

private _classlist = [];
private _use_fast = true;

switch ( _list ) do {
	case "FOB" : { _classlist = [FOB_typename] };
	case "OUTPOST" : { _classlist = [FOB_outpost] };
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
	case "REPAINT" : { _classlist = vehicle_repaint_sources };
	case "REAMMO" : { _classlist = vehicle_rearm_sources };
	case "REAMMO_AI" : { _classlist = ai_resupply_sources };
	case "REFUEL" : { _classlist = vehicle_refuel_sources };
	case "REFUEL_DISP" : { _classlist = [canister_fuel_typename, fuelbarrel_typename] };
	case "REPAIR" : { _classlist = vehicle_repair_sources };
	case "REPAIR_BOX" : { _classlist = vehicle_repair_box; _use_fast = false };
	case "WAREHOUSE" : { _classlist = [Warehouse_typename]; _use_fast = false };
};
if (count _classlist == 0) exitWith { false };

// Include FOB / Outpost
private _ret = false;
if (_includeFOB) then {
	_ret = ((_vehpos distance2D ([_vehpos, (_list == "OUTPOST")] call F_getNearestFob)) <= _dist);
};
if (_ret) exitWith { true };
if (_list in ["FOB", "OUTPOST"]) exitWith { _ret };
if (_list == "LHD") exitWith { (_vehpos distance2D lhd <= _dist) };

// Supply Always ON
private _ignore_disabled = (_list in ["MEDIC","ARSENAL","REFUEL","REAMMO","REAMMO_AI","REPAIR","REPAIR_BOX"]);

// Search
private _near = 0;
if (typeName (_classlist select 0) == "STRING") then {
	private _obj_list = [];
	// From Objects classname
	if (_use_fast) then {
		// fast but don't detect everything
		_obj_list = _vehpos nearEntities [_classlist, _dist];
	} else {
		// powerfull but slower
		_obj_list = nearestObjects [_vehpos, _classlist, _dist];
	};
	if (count _obj_list > 0) then {
		if (_ignore_disabled) then {
			_near = ({
				alive _x && getObjectType _x >= 8
			} count _obj_list);
		} else {
			_near = ({
				alive _x && getObjectType _x >= 8 &&
				(
					!(_x getVariable ['R3F_LOG_disabled', false]) ||
					!(isNull (attachedTo  _x))
				);
			} count _obj_list);
		};
	};
} else {
	// From Position
	_near = ({ (_vehpos distance2D _x) <= _dist } count _classlist);
};

(_near > 0);
