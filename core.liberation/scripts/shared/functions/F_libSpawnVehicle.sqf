params [
	"_sectorpos",
	"_classname",
	[ "_precise_position", false ],
	[ "_random_rotate", true ]
];

diag_log format [ "Spawning vehicle %1 at %2", _classname , time ];

private _newvehicle = objNull;
private _spawnpos = zeropos;
private _vehcrew = [];

if ( _precise_position ) then {
	_spawnpos = [] + _sectorpos;
} else {
	while { _spawnpos isEqualTo zeropos } do {
		_safepos = [_sectorpos, 5, 300, 1, 1, 0.25, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
		if (surfaceIsWater _safepos) then {
			_spawnpos = _safepos;
		} else {
			_spawnpos = _safepos findEmptyPosition [1, 20, "B_Heli_Transport_03_unarmed_F"];
		};
		if ( count _spawnpos == 0 ) then { _spawnpos = zeropos; };
	};
};

_newvehicle = objNull;
if ( _classname in opfor_choppers ) then {
	_newvehicle = createVehicle [_classname, _spawnpos, [], 0, 'FLY'];
	_newvehicle setPos (getPosATL _newvehicle vectorAdd [0, 0, 400]);
	_newvehicle flyInHeight 400;
} else {
	if (surfaceIsWater _spawnpos && !(_classname in opfor_boat)) then {
		_classname = selectRandom opfor_boat;
	};
	_newvehicle = _classname createVehicle _spawnpos;
	_newvehicle setpos _spawnpos;
};
_newvehicle allowdamage false;
clearWeaponCargoGlobal _newvehicle;
clearMagazineCargoGlobal _newvehicle;
clearItemCargoGlobal _newvehicle;
clearBackpackCargoGlobal _newvehicle;
sleep 1;

if ( _classname in militia_vehicles ) then {
	[ _newvehicle ] call F_libSpawnMilitiaCrew;
} else {
	createVehicleCrew _newvehicle;
	sleep 1;
	_vehcrew = crew _newvehicle;
	{
		_x allowdamage false;
		_x addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
		_x addEventHandler ["HandleDamage", {_this call damage_manager_EH}];
	} foreach _vehcrew;
};
_newvehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
_newvehicle allowCrewInImmobile true;
_newvehicle setUnloadInCombat [true, false];

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

[_newvehicle,_vehcrew] spawn {
	params ["_veh", "_crew"];
	sleep 5;
	// Correct position
	if ((vectorUp _veh) select 2 < 0.70) then {
		_veh setpos [(getposATL _veh) select 0,(getposATL _veh) select 1, 0.5];
		_veh setVectorUp surfaceNormal position _veh;
		sleep 2;
	};
	_veh setdamage 0;
	_veh allowdamage true;
	{ _x setdamage 0;_x allowdamage true } foreach _crew;
};

diag_log format [ "Done Spawning vehicle %1 at %2", _classname , time ];

_newvehicle;
