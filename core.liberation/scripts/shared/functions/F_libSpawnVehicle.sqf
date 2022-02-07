params [
	"_sectorpos",
	"_classname",
	[ "_precise_position", false ],
	[ "_random_rotate", true ],
	[ "_civilian", false]
];

diag_log format [ "Spawn vehicle %1 at %2", _classname , time ];

private _newvehicle = objNull;
private _spawnpos = zeropos;
private _vehcrew = [];
private _max_try = 10;
private _radius = GRLIB_capture_size;

if ( _precise_position ) then {
	_spawnpos = [] + _sectorpos;
} else {
	while { (_spawnpos isEqualTo zeropos) && _max_try > 0 } do {
		_spawnpos = [_sectorpos, 0, _radius, 3, 1, 0.25, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
		_radius = _radius + 20;
		_max_try = _max_try - 1;
	};
};
if ( _spawnpos distance2D zeropos < 300 ) exitWith { diag_log format ["--- LRX Error: No place to build %1 from position %2", _classname, _sectorpos]; objNull };

_newvehicle = objNull;
if ( _classname isKindOf "Air" ) then {
	private _veh_alt = 300;
	if ( _civilian ) then { _veh_alt = 200 };
	_spawnpos set [2, _veh_alt];
	_newvehicle = createVehicle [_classname, _spawnpos, [], 0, "FLY"];
	_newvehicle flyInHeightASL [_veh_alt, 150, 400];

} else {
	_spawnpos set [2, 0.5];
	if (surfaceIsWater _spawnpos && !(_classname isKindOf "Ship")) then {
		if ( _civilian ) then {
			_classname = selectRandom boats_names_civ;
		} else {
			_classname = selectRandom boats_east;
		};
	};
	_newvehicle = createVehicle [_classname, _spawnpos, [], 0, "NONE"];
};

_newvehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
_newvehicle allowCrewInImmobile true;
_newvehicle setUnloadInCombat [true, false];
clearWeaponCargoGlobal _newvehicle;
clearMagazineCargoGlobal _newvehicle;
clearItemCargoGlobal _newvehicle;
clearBackpackCargoGlobal _newvehicle;
sleep 0.2;

if ( !_civilian ) then {
	_newvehicle allowDamage false;

	if ( _classname in militia_vehicles ) then {
		[ _newvehicle ] call F_libSpawnMilitiaCrew;
	} else {
		[ _newvehicle ] call F_forceOpforCrew;
	};

	_vehcrew = crew _newvehicle;
	{ _x allowDamage false } forEach _vehcrew;

	if ( _random_rotate ) then {
		_newvehicle setdir (random 360);
	};

	// A3 textures
	if ( _classname in ["I_E_Truck_02_MRL_F"] ) then {
		[_newvehicle, ["Opfor",1], true ] call BIS_fnc_initVehicle;
	};

	// LRX textures
	if (count opfor_texture_overide > 0) then {
		_texture_name = selectRandom opfor_texture_overide;
		_texture = [ RPT_colorList, { _x select 0 == _texture_name } ] call BIS_fnc_conditionalSelect select 0 select 1;
		[_newvehicle, _texture, _texture_name,[]] call RPT_fnc_TextureVehicle;
	};

	[_newvehicle, _vehcrew] spawn {
		params ["_veh", "_crew"];
		sleep 5;
		_veh setDamage 0;
		_veh allowDamage true;
		{ _x setDamage 0; _x allowDamage true } forEach _crew;
	};
};

diag_log format [ "Done Spawning vehicle %1 at %2", _classname , time ];

_newvehicle;
