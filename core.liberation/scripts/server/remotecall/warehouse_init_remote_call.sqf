// LRX Warehouse
// by pSiKO

params ["_warehouse"];
private _warehouse_dir = getdir _warehouse;

if (count GRLIB_warehouse == 0) then {
	GRLIB_warehouse = [
		[waterbarrel_typename, 0],
		[fuelbarrel_typename, 0],
		[foodbarrel_typename, 0]
	];
};

// build desk + man
private _deskDir = (_warehouse_dir + 90);
private _offset = [1, 2, 0];
private _deskPos = (getposASL _warehouse) vectorAdd ([_offset, -_deskDir] call BIS_fnc_rotateVector2D);
private _desk = createSimpleObject ["Land_PortableDesk_01_black_F", _deskPos];
_desk allowDamage false;
_desk setDir _deskDir;
_deskDir = (180 + _deskDir);
private _manPos = (ASLToATL _deskPos) vectorAdd ([[0, -0.7, 0.1], -_deskDir] call BIS_fnc_rotateVector2D);
private _grp = group chimeraofficer;
private _man = _grp createUnit ["B_RangeMaster_F", _manPos, [], 0, "NONE"];
_man allowDamage false;
_man disableCollisionWith _desk;
_man setDir _deskDir;
_man setPosATL _manPos;
doStop _man;
[_man, "AidlPercMstpSnonWnonDnon_AI"] spawn F_startAnimMP;
_man setVariable ["GRLIB_Warehouse", _warehouse];

// build box
private _warehouse_offset = [
	// row 1 (Water)
	[
		[[-2,5,0.1,0], 0], 
  		[[0,0,0],[0.6,0,0],[1.5,0,0],[2.1,0,0],[3,0,0],[3.6,0,0],[0.3,0,0.8],[1.8,0,0.8],[3.3,0,0.8]] 
	],
	// row 2 (Fuel)
	[
		[[-10.5,-1,0], 220],
  		[[0,0,0.05],[0,1,0.05],[0,2,0.05],[0,3,0.05],[0,4,0.05],[0,5,0.05],[0,0.5,0.9],[0,1.5,0.9],[0,2.5,0.9],[0,3.5,0.9]] 
	],
	// row 3 (Food)
	[
		[[-6,1,0], 0],
  		[[0,0,0],[2,0,0],[3,-1.5,0],[1,-1.5,0],[4,0,0],[1,-0.5,0.9],[2.5,-1.3,0.9]] 
	]
];

{
	_typename = _x select 0;
	_offset_conf = _warehouse_offset select _foreachIndex;
	_spawn_offset = _offset_conf select 0 select 0;
	_box_dir = _offset_conf select 0 select 1;
	_box_pos = (getposASL _warehouse) vectorAdd ([_spawn_offset, -_warehouse_dir] call BIS_fnc_rotateVector2D);
	_box_offset = _offset_conf select 1;
	for "_i" from 1 to (count _box_offset) do {
		_offset = _box_offset select (_i-1);
		_box_pos_final = _box_pos vectorAdd ([_offset, -_warehouse_dir] call BIS_fnc_rotateVector2D);
		_box = createSimpleObject [_typename, _box_pos_final];
		_box setDir (_box_dir + ((random 60) -30));
		//systemchat format ["box:%1 %2", _typename,  _offset];
	};
} foreach GRLIB_warehouse;

// update warehouse
[_man] call warehouse_update_remote_call;
