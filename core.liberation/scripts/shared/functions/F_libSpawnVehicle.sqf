params [
	"_sectorpos",
	"_classname",
	[ "_precise_position", false ],
	[ "_disable_abandon", false ],
	[ "_random_rotate", true ]
];

diag_log format [ "Spawning vehicle %1 at %2", _classname , time ];

private _newvehicle = objNull;
private _spawnpos = zeropos;

if ( _precise_position ) then {
	_spawnpos = [] + _sectorpos;
} else {
	while { _spawnpos distance zeropos < 1000 } do {
		_spawnpos = ( [ _sectorpos, random 150, random 360 ] call bis_fnc_relpos ) findEmptyPosition [10, 200, 'B_Heli_Transport_01_F'];
		//_spawnpos = (selectBestPlaces [_sectorpos, 200, "(1 + meadow) * (1 + sea) * (1 - forest) * (1 - trees)", 50, 1] select 0) select 0;
		if ( count _spawnpos == 0 ) then { _spawnpos = zeropos; };
	};
};

_newvehicle = objNull;
if ( _classname in opfor_choppers ) then {
	_newvehicle = createVehicle [_classname, _spawnpos, [], 0, 'FLY'];
	_newvehicle flyInHeight (100 + (random 200));
} else {
	if (surfaceIsWater _spawnpos) then {
		_classname = opfor_boat call BIS_fnc_selectRandom;
	};
	_newvehicle = _classname createVehicle _spawnpos;
	_newvehicle setpos _spawnpos;
};
_newvehicle allowdamage false;
clearWeaponCargoGlobal _newvehicle;
clearMagazineCargoGlobal _newvehicle;
clearItemCargoGlobal _newvehicle;
clearBackpackCargoGlobal _newvehicle;

// A3 textures
if ( _classname in ["I_E_Truck_02_MRL_F"] ) then {
	[_newvehicle, ["Opfor",1], true ] call BIS_fnc_initVehicle;
};

// LRX textures
if (count opfor_texture_overide > 0) then {
	_texture_name = opfor_texture_overide call BIS_fnc_selectRandom;
	_texture = [ RPT_colorList, { _x select 0 == _texture_name } ] call BIS_fnc_conditionalSelect select 0 select 1;
	[_newvehicle, _texture, _texture_name,[]] call RPT_fnc_TextureVehicle;
};

if ( _classname in militia_vehicles ) then {
	[ _newvehicle ] call F_libSpawnMilitiaCrew;
} else {
	createVehicleCrew _newvehicle;
	sleep 1;
	{ _x addMPEventHandler ['MPKilled', {_this spawn kill_manager}]; } foreach (crew _newvehicle);
};
_newvehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];

if ( _random_rotate ) then {
	_newvehicle setdir (random 360);
};
_newvehicle setVectorUp surfaceNormal position _newvehicle;

sleep 0.1;
_newvehicle allowdamage true;
_newvehicle setdamage 0;

if ( !_disable_abandon ) then {
	[ _newvehicle ] spawn csat_abandon_vehicle;
};

diag_log format [ "Done Spawning vehicle %1 at %2", _classname , time ];

_newvehicle

