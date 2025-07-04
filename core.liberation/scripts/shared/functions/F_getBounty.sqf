params ["_vehicle"];

if !(_vehicle getVariable ["GRLIB_vehicle_reward", false]) exitWith {[0,0]};

private _extra_bounty = opfor_air + [
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F",
	"B_MBT_01_TUSK_F",
	"B_AFV_Wheeled_01_cannon_F"
];

private _heavy_blu = heavy_vehicles apply { _x select 0 };
private _bounty = 10;
private _bonus = 2;

if ( _vehicle isKindOf "Ship_F" ) then {
	_bounty = 15;
	_bonus = 2;
};

if ( _vehicle isKindOf "Wheeled_APC_F" ) then {
	_bounty = 20;
	_bonus = 3;
};

if ( _vehicle isKindOf "Tank" ) then {
	_bounty = 30;
	_bonus = 4;
};

if ( _vehicle isKindOf "Air" ) then {
	_bounty = 35;
	_bonus = 4;
};

if (typeOf _vehicle in _extra_bounty) then {
	_bounty = _bounty + 25;
	_bonus = _bonus + 2;
};

if (typeOf _vehicle in _heavy_blu) then {
	_bonus = 0;
};

_bounty = _bounty + floor random 6;

[_bounty, _bonus];
