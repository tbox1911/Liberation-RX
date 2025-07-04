// LRX Warehouse
// by pSiKO

if (!isServer && hasInterface) exitWith {};
params ["_warehouse"];

private _row1 = [
	// row 1 (Water)
	[[-4,5,0.1], 90],
	[[0,0,0],[0.6,0,0],[1.5,0,0],[2.1,0,0],[3,0,0],[3.6,0,0],[0.3,-0.6,0],[1.8,-0.6,0],[0.3,0,0.8],[1.8,0,0.8],[3.3,0,0.8],[3.3,-0.6,0]]
];

private _row2 = [
	// row 2 (Fuel)
	[[-10.5,-3,0], 230],
  	[[0,0,0.05],[0,1,0.05],[0,2,0.05],[0,3,0.05],[0,4,0.05],[0,5,0.05],[0,6,0.05],[0,0.5,0.9],[0,1.5,0.9],[0,2.5,0.9],[0,3.5,0.9],[0,4.5,0.9]]
];

private _row3 = [
	// row 3 (Food)
	[[-7,1,0], 0],
	[[0,0,0],[2,0,0],[3,-1.5,0],[1,-1.5,0],[0,-3,0],[1,-0.5,0.9],[2.5,-1.3,0.9]]
];

private _row4 = [
	// row 4 (Ammo)
	[[0,2.5,0], 90],
   	[[0,0,0],[1.5,0,0],[2.5,0,0],[2,0,0.35],[0,-1.5,0],[1.5,-1.5,0],[2.5,-1.5,0],[2,-1.5,0.35]]
];

// CUPS
if (basic_weapon_typename == "CUP_LocalBasicWeaponsBox") then {
	_row4 = [
		[[0,2.5,0], 90],
		[[1,0,0.4],[3,0,0.4],[0,-2,0.4],[2,-2,0.4],[4,-2,0.4]]
	];
};

if (basic_weapon_typename == "CUP_BOX_RU_Wps_F") then {
	_row4 = [
		[[-2,2.5,0], 90],
		[[1,0,0],[3,0,0],[0,-2,0],[2,-2,0],[4,-2,0]]
	];
};

//SoG
if (basic_weapon_typename == "Land_vn_pavn_weapons_stack1") then {
	_row4 = [
		[[0,2.5,0], 90],
		[[1,0,0],[3,0,0],[0,-2,0],[2,-2,0],[4,-2,0]]
	];
};

private _warehouse_offset = [_row1,	_row2, _row3, _row4];

// build desk + man
private _warehouse_dir = (90 + getdir _warehouse);
private _desk_pos = (getposASL _warehouse) vectorAdd ([[2, 1, 0], -_warehouse_dir] call BIS_fnc_rotateVector2D);
private _desk = createVehicle [Warehouse_desk_typename, ([] call F_getFreePos), [], 0, "NONE"];
_desk allowDamage false;
_desk enableSimulationGlobal false;
_desk setDir _warehouse_dir;
_desk setPosASL _desk_pos;
_desk setVariable ["R3F_LOG_disabled", true, true];
_warehouse_dir = (180 + _warehouse_dir);
private _manPos = (ASLToATL _desk_pos) vectorAdd ([[0, -0.7, 0.1], -_warehouse_dir] call BIS_fnc_rotateVector2D);
_man = createAgent [WRHS_Man, zeropos, [], 5, "NONE"];
_man setVariable ["GRLIB_WHS_Group", true, true];
_man allowDamage false;
_man disableCollisionWith _desk;
_man setDir _warehouse_dir;
_man setPosATL _manPos;
doStop _man;
[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;
_warehouse setVariable ["GRLIB_WarehouseOwner", _man];

// build box
_warehouse_dir = getdir _warehouse;
{
	_typename = _x select 0;
	_offset_conf = _warehouse_offset select _foreachIndex;
	_spawn_offset = _offset_conf select 0 select 0;
	_box_dir = _offset_conf select 0 select 1;
	_box_pos = (getposASL _warehouse) vectorAdd ([_spawn_offset, -_warehouse_dir] call BIS_fnc_rotateVector2D);
	_box_offset = _offset_conf select 1;
	for "_i" from 1 to (count _box_offset) do {
		_offset = _box_offset select (_i-1);
		_box_pos_r1 = _box_pos vectorAdd ([_offset, -_warehouse_dir] call BIS_fnc_rotateVector2D);
		_box = createSimpleObject [_typename, _box_pos_r1];
		if (_box_dir > 0) then {
			_box setDir (_box_dir + ((random 60) -30));
		};
		_box setPosASL _box_pos_r1;
	};
} foreach GRLIB_warehouse;

// update warehouse
[getPosATL _warehouse] call warehouse_update;

publicVariable "GRLIB_warehouse";
