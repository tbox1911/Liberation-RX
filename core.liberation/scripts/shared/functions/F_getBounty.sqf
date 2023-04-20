params ["_vehicle"];

private _extra_bounty = [
	"O_T_VTOL_02_infantry_F",
	"O_T_VTOL_02_vehicle_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F",
	"O_Plane_CAS_02_F",
	"O_Plane_Fighter_02_F"
];

_bounty = 10;
_bonus = 2;

if ( _vehicle isKindOf "Ship" ) then {
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
	_bonus = _bonus + 1;
};

if (typeOf _vehicle in heavy_vehicles) then {
	_bonus = 0;
};

[_bounty, _bonus];
