// LRX Warehouse
// by pSiKO

params ["_warehouse"];

if (count GRLIB_warehouse == 0) then {
	GRLIB_warehouse = [
		[waterbarrel_typename, 2],
		[fuelbarrel_typename, 2],
		[foodbarrel_typename, 1],
		[basic_weapon_typename, 0]
	];
};

if (isNil "GRLIB_WHS_Group") then {
	GRLIB_WHS_Group = createGroup [GRLIB_side_civilian, true];
};
if (isNull GRLIB_WHS_Group) then {
	GRLIB_WHS_Group = createGroup [GRLIB_side_civilian, true];
};

private _warehouse_offset = [
	// row 1 (Water)
	[
		[[-4,5,0.1], 90],
  		[[0,0,0],[0.6,0,0],[1.5,0,0],[2.1,0,0],[3,0,0],[3.6,0,0],[0.3,-0.6,0],[1.8,-0.6,0],[0.3,0,0.8],[1.8,0,0.8],[3.3,0,0.8]]
	],
	// row 2 (Fuel)
	[
		[[-10.5,-3,0], 230],
  		[[0,0,0.05],[0,1,0.05],[0,2,0.05],[0,3,0.05],[0,4,0.05],[0,5,0.05],[0,0.5,0.9],[0,1.5,0.9],[0,2.5,0.9],[0,3.5,0.9]]
	],
	// row 3 (Food)
	[
		[[-6,1,0], 0],
  		[[0,0,0],[2,0,0],[3,-1.5,0],[1,-1.5,0],[4,0,0],[1,-0.5,0.9],[2.5,-1.3,0.9]]
	],
	// row 4 (Ammo)
	[
		[[1,2.5,0], 90],
    	[[0,0,0],[1,0,0],[2,0,0],[1.5,0,0.35],[0,-1.5,0],[1,-1.5,0],[2,-1.5,0],[1.5,-1.5,0.35]]
	]
];

// build desk + man
private _warehouse_dir = (90 + getdir _warehouse);
private _offset = [2, 1, 0];
private _deskPos = (getposASL _warehouse) vectorAdd ([_offset, -_warehouse_dir] call BIS_fnc_rotateVector2D);
private _desk = createSimpleObject ["Land_PortableDesk_01_black_F", zeropos];
_desk allowDamage false;
_desk setDir _warehouse_dir;
_desk setPosASL _deskPos;
_warehouse_dir = (180 + _warehouse_dir);
private _manPos = (ASLToATL _deskPos) vectorAdd ([[0, -0.7, 0.1], -_warehouse_dir] call BIS_fnc_rotateVector2D);
private _man = GRLIB_WHS_Group createUnit [WRHS_Man, zeropos, [], 0, "NONE"];
_man allowDamage false;
_man disableCollisionWith _desk;
_man setDir _warehouse_dir;
_man setPosATL _manPos;
doStop _man;
[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;
_man setVariable ["GRLIB_Warehouse", _warehouse];
_warehouse setVariable ["GRLIB_WarehouseOwner", _man];
publicVariable "GRLIB_WHS_Group";

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
	};
} foreach GRLIB_warehouse;

// update warehouse
[_man] call warehouse_update;
publicVariable "GRLIB_warehouse";
