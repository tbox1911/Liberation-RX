if (!isServer) exitWith {};

waituntil {sleep 1; !isNil "GRLIB_sectors_init"};

// Load fixed positions
[] call compileFinal preprocessFileLineNUmbers "fixed_position.sqf";

// REPAIR
private ["_vehicle"];
{
	// Add repair pickup
	_vehicle = createVehicle [repair_offroad, (markerPos _x), [], 20, "NONE"];
	if (isNull _vehicle) then {
		diag_log format ["--- LRX Error: No place to build %1 at sector %2", repair_offroad, _x];
	} else {
		_vehicle allowDamage false;
		[_vehicle, "lock", "server"] call F_vehicleLock;
		[_vehicle] call F_clearCargo;
	};
	sleep 0.2;
} forEach sectors_factory;

// SELL
private ["_man", "_manPos"];
GRLIB_SELL_Group = createGroup [GRLIB_side_civilian, true];
{
	_manPos = _x;
	_man = GRLIB_SELL_Group createUnit [SELL_Man, _manPos, [], 5, "NONE"];
	[_man] joinSilent GRLIB_SELL_Group;
	_man setVariable ["acex_headless_blacklist", true, true];
	_man setVariable ["GRLIB_vehicle_owner", "server", true];
	_man allowDamage false;
	_man setPosATL (_manPos vectorAdd [0, 0, 0.1]);
	doStop _man;
	[_man, "LHD_krajPaluby"] spawn F_startAnimMP;
	sleep 0.2;
} forEach GRLIB_Marker_SRV;

// SHOP
private ["_shop", "_deskDir", "_deskPos", "_desk", "_man", "_offset", "_str"];
GRLIB_SHOP_Group = createGroup [GRLIB_side_civilian, true];
{
	_shop = nearestObjects [_x, ["House"], 10] select 0;
	_deskDir = getDir _shop;
	_offset = [-0.7, 1, 0.25];      // Default shop_01_v1_f
	_str =  toLower str _shop;
	if (_str find "warehouse_03" > 0) then { _offset = [-2, 0, 0]};             // Tanoa
	if (_str find "metalshelter_02" > 0) then { _deskDir = (180 + _deskDir); _offset = [2, 0, 0]};  // Tanoa
	if (_str find "villagestore" > 0) then { _offset = [4, 2, 0.70]};           // Enoch
	if (_str find "ind_workshop01_02" > 0) then { _offset = [0, 2, 0]};         // Chernarus
	if (_str find "house_c_4_ep1" > 0) then { _offset = [1, 0, 0.60]};          // Isladuala
	if (_str find "sara_domek_sedy" > 0) then { _offset = [2.5, 1.8, 0.6]};     // Sarahni
	if (_str find "dum_istan3_hromada" > 0) then { _deskDir = (90 + _deskDir); _offset = [2.6, -0.6, -0.1]};  // Sarahni
	if (_str find "house_c_1_v2_ep1" > 0) then { _offset = [5.5, 1, 0.10]};     // Takistan
	if (_str find "vn_shop_town_03" > 0) then { _offset = [1.5, -1, 0.10]};     // Cam Lao
	if (_str find "house_big_02" > 0) then { _deskDir = (180 + _deskDir); _offset = [-0.7, -2, 0.25]};
	if (_str find "workshop_02_grey" > 0) then { _deskDir = (180 + _deskDir); _offset = [0, 0, 0]};		// Yukalia
	if (_str find "shop_town_01_f" > 0) then { _deskDir = (270 + _deskDir); _offset = [-0.7, 3, 0]};	// Yukalia

	_deskPos = (getposASL _shop) vectorAdd ([_offset, -_deskDir] call BIS_fnc_rotateVector2D);
	_desk = createVehicle ["Land_CashDesk_F", ([] call F_getFreePos), [], 0, "NONE"];
	_desk allowDamage false;
	_desk enableSimulationGlobal false;
	_desk setDir _deskDir;
	_desk setPosASL _deskPos;
	_deskDir = (180 + _deskDir);
	_manPos = (ASLToATL _deskPos) vectorAdd ([[0, -0.7, 0.1], -_deskDir] call BIS_fnc_rotateVector2D);
	_man = GRLIB_SHOP_Group createUnit [SHOP_Man, zeropos, [], 0, "NONE"];
	[_man] joinSilent GRLIB_SHOP_Group;
	_man setVariable ["acex_headless_blacklist", true, true];
	_man setVariable ["GRLIB_vehicle_owner", "server", true];
	_man allowDamage false;
	_man disableCollisionWith _desk;
	_man setDir _deskDir;
	_man setPosATL _manPos;
	doStop _man;
	[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;
	//_man enableSimulationGlobal false; // disabled to keep animation
	sleep 0.2;
} forEach GRLIB_Marker_SHOP;

publicVariable "GRLIB_SHOP_Group";
publicVariable "GRLIB_SELL_Group";
sleep 3;
GRLIB_marker_init = true;
publicVariable "GRLIB_marker_init";

/*
// test desk + man position in building

[] spawn {
_shop = cursorObject; // point building
_deskDir = getDir _shop;

_offset = [-0.7, 3, 0];  // edit
_deskDir = (270 + _deskDir); // edit

_deskPos = (getposASL _shop) vectorAdd ([_offset, -_deskDir] call BIS_fnc_rotateVector2D);
_desk = createVehicle ["Land_CashDesk_F", ([] call F_getFreePos), [], 0, "NONE"];
_desk allowDamage false;
_desk enableSimulationGlobal false;
_desk setDir _deskDir;
_desk setPosASL _deskPos;
_deskDir = (180 + _deskDir);
_manPos = (ASLToATL _deskPos) vectorAdd ([[0, -0.7, 0.1], -_deskDir] call BIS_fnc_rotateVector2D);
_man = GRLIB_SHOP_Group createUnit [SHOP_Man, zeropos, [], 0, "NONE"];
[_man] joinSilent GRLIB_SHOP_Group;
_man setVariable ["acex_headless_blacklist", true, true];
_man setVariable ["GRLIB_vehicle_owner", "server", true];
_man allowDamage false;
_man disableCollisionWith _desk;
_man setDir _deskDir;
_man setPosATL _manPos;
doStop _man;
sleep 7;
deleteVehicle _desk;
deleteVehicle _man;
};

*/