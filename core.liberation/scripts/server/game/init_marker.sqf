if (!isServer) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_init_server"};

// Load fixed positions
[] call compileFinal preprocessFileLineNumbers "fixed_position.sqf";

// REPAIR
private ["_vehicle", "_spawn_pos"];
{
	// Add repair pickup
	_spawn_pos = [(markerPos _x), 5, 0, 80, false] call F_findSafePlace;
	if (count _spawn_pos > 0) then {
		_vehicle = createVehicle [repair_offroad, _spawn_pos, [], 1, "NONE"];
		_vehicle allowDamage false;
		_vehicle setPos _spawn_pos;
		[_vehicle, "lock", "server"] call F_vehicleLock;
		[_vehicle] call F_clearCargo;
		_vehicle enableSimulationGlobal true; // enable to keep facility
	} else {
		diag_log format ["--- LRX Error: No place to build %1 at sector %2", repair_offroad, _x];
	};
	sleep 0.2;
} forEach sectors_factory;

// SELL
private ["_man", "_manPos"];
{
	_manPos = _x;
	_man = createAgent [SELL_Man, _manPos, [], 5, "NONE"];
	_man setVariable ["GRLIB_SELL_group", true, true];
	_man allowDamage false;
	_man setPosATL (_manPos vectorAdd [0, 0, 0.1]);
	doStop _man;
	[_man, "LHD_krajPaluby"] spawn F_startAnimMP;
	sleep 0.2;
} forEach GRLIB_Marker_SRV;

// SHOP
private ["_shop", "_desk_dir", "_desk_pos", "_desk", "_man", "_offset", "_str"];
{
	_shop = nearestObjects [_x, ["House"], 10] select 0;
	if (isNil "_shop") then { diag_log format ["--- LRX Error: no building found at pos %1", _x]; _shop = objNull };

	// Specific position
	_desk_dir = getDir _shop;
	_offset = [-0.7, 1, 0.25];      // Default shop_01_v1_f
	_str =  toLower str _shop;
	if (_str find "warehouse_03" > 0) then { _offset = [-2, 0, 0] };             // Tanoa
	if (_str find "metalshelter_02" > 0) then { _desk_dir = (180 + _desk_dir); _offset = [2, 0, 0] };  // Tanoa
	if (_str find "villagestore" > 0) then { _offset = [4, 2, 0.70] };           // Enoch
	if (_str find "ind_workshop01_02" > 0) then { _offset = [0, 2, 0] };         // Chernarus
	if (_str find "house_c_4_ep1" > 0) then { _offset = [1, 0, 0.60] };          // Isladuala
	if (_str find "sara_domek_sedy" > 0) then { _offset = [2.5, 1.8, 0.6] };     // Sarahni
	if (_str find "dum_istan3_hromada" > 0) then { _desk_dir = (90 + _desk_dir); _offset = [2.6, -0.6, -0.1] };  // Sarahni
	if (_str find "house_c_1_v2_ep1" > 0) then { _offset = [5.5, 1, 0.10] };     // Takistan
	if (_str find "vn_shop_town_03" > 0) then { _offset = [1.5, -1, 0.10] };     // Cam Lao
	if (_str find "house_big_02" > 0) then { _desk_dir = (180 + _desk_dir); _offset = [-0.7, -2, 0.25] };
	if (_str find "workshop_02_grey" > 0) then { _desk_dir = (180 + _desk_dir); _offset = [0, 0, 0] };		// Yukalia
	if (_str find "shop_town_01_f" > 0) then { _desk_dir = (270 + _desk_dir); _offset = [-0.7, 3, 0] };		// Yukalia
	if (_str find "spe_corner_house_02" > 0) then { _desk_dir = (270 +_desk_dir); _offset = [4.5, 5, 0.3] };	// SPE
	if (_str find "spe_shop_02" > 0) then { _desk_dir = (180 +_desk_dir); _offset =  [-1.7, -0.5, 0.7] };		// SPE

	// Create Desk
	_desk_pos = (getposASL _shop) vectorAdd ([_offset, -_desk_dir] call BIS_fnc_rotateVector2D);
	_desk = createVehicle ["Land_CashDesk_F", ([] call F_getFreePos), [], 0, "CAN_COLLIDE"];
	_desk allowDamage false;
	_desk enableSimulationGlobal false;
	_desk setDir _desk_dir;
	_desk setPosASL _desk_pos;
	_desk setVariable ["R3F_LOG_disabled", true, true];

	// Create Man
	_desk_dir = (180 + _desk_dir);
	_manPos = (ASLToATL _desk_pos) vectorAdd ([[0, -0.7, 0.1], -_desk_dir] call BIS_fnc_rotateVector2D);
	_man = createAgent [SHOP_Man, zeropos, [], 5, "CAN_COLLIDE"];
	_man setVariable ["GRLIB_SHOP_group", true, true];
	_man allowDamage false;
	_man disableCollisionWith _desk;

	_man setDir _desk_dir;
	_man setPosATL _manPos;
	doStop _man;
	[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;
	//_man enableSimulationGlobal false; // disabled to keep animation
	sleep 0.2;
} forEach GRLIB_Marker_SHOP;

// LRX Auto Name Sector
{
	private _marker = _x;
	private _marker_dist = 999;
	private _marker_text = "";
	if (markerText _marker == "") then {
		{
			_loc = nearestLocations [markerPos _marker, [_x], GRLIB_sector_size] select 0;
			if (!isNil "_loc") then {
				_dist = round (markerPos _marker distance _loc);
				if (_dist < _marker_dist ) then {
					_marker_text = text _loc;
					_marker_dist = _dist;
				};
			};
		} forEach ["NameCityCapital", "NameCity", "NameVillage", "NameLocal", "Hill"];

		if (_marker_text == "") then {
			if (_marker in sectors_capture) then {_marker_text = format ["Town #%1", _forEachIndex]};
			if (_marker in sectors_military) then {_marker_text = format ["Military Base #%1", _forEachIndex]};
			if (_marker in sectors_factory) then {_marker_text = format ["Fuel Depot #%1", _forEachIndex]};
			diag_log format ["--- LRX World: %1 - Auto-Name failed for marker: %2", worldname, _marker]
		};
		_marker setMarkerText _marker_text;
 };
} forEach (sectors_capture + sectors_bigtown + sectors_factory + sectors_military);

sleep 3;
GRLIB_marker_init = true;
publicVariable "GRLIB_marker_init";

/*
// test desk + man position in building

[] spawn {
_shop = cursorObject; // point building
_desk_dir = getDir _shop;

_offset = [-0.7, 3, 0];  // edit
_desk_dir = (270 + _desk_dir); // edit

_desk_pos = (getposASL _shop) vectorAdd ([_offset, -_desk_dir] call BIS_fnc_rotateVector2D);
_desk = createVehicle ["Land_CashDesk_F", ([] call F_getFreePos), [], 0, "NONE"];
_desk allowDamage false;
_desk enableSimulationGlobal false;
_desk setDir _desk_dir;
_desk setPosASL _desk_pos;
_desk_dir = (180 + _desk_dir);
_manPos = (ASLToATL _desk_pos) vectorAdd ([[0, -0.7, 0.1], -_desk_dir] call BIS_fnc_rotateVector2D);
_man = createAgent [SHOP_Man, zeropos, [], 5, "CAN_COLLIDE"];
_man setVariable ["acex_headless_blacklist", true, true];
_man allowDamage false;
_man disableCollisionWith _desk;
_man setDir _desk_dir;
_man setPosATL _manPos;
doStop _man;
sleep 7;
deleteVehicle _desk;
deleteVehicle _man;
};

*/