params [ "_vehicle" ];

diag_log format [ "Spawn opfor crew at %1", time ];

private _classname = opfor_crew ;
private _vehicle_class = typeOf _vehicle;
if (_vehicle_class isKindOf "Weapon_Bag_Base") then { _classname = opfor_gun_crew };
if (_vehicle_class isKindOf "LandVehicle") then { _classname = opfor_tank_crew };
if (_vehicle_class isKindOf "Helicopter_Base_F") then { _classname = opfor_heli_pilots };
if (_vehicle_class isKindOf "Plane") then { _classname = opfor_plane_pilots };

private _grp = createGroup [GRLIB_side_enemy, true];
private _driver = _grp createUnit [_classname, zeropos, [], 5, "NONE"];
_driver moveInDriver _vehicle;
private _gunner = _grp createUnit [_classname, zeropos, [], 5, "NONE"];
_gunner moveInGunner _vehicle;
private _commander = _grp createUnit [_classname, zeropos, [], 5, "NONE"];
_commander moveInCommander _vehicle;
sleep 1;

{
	if ( vehicle _x == _x ) then {
		deleteVehicle _x;
	} else {
		[_x] joinSilent _grp;
		_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
		_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
		_x setSkill 0.65;
		_x allowFleeing 0;
	};
} foreach [_driver, _gunner, _commander];

_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

_grp setCombatMode "WHITE";
_grp setBehaviour "AWARE";

diag_log format ["Done Spawning opfor crew at %1", time];