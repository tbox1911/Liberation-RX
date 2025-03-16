params ["_control", "_lbCurSel", "_lbSelection"];

if (_lbCurSel == -1) exitWith {};

private _squad_list = [player] + PAR_AI_bros;
private _cfgVehicles = configFile >> "cfgVehicles";
private _cfgWeapons = configFile >> "cfgWeapons";
private _selectedmember = _squad_list select _lbCurSel;

"spawn_marker" setMarkerPosLocal (getpos _selectedmember);
ctrlMapAnimClear ((findDisplay 5155) displayCtrl 100);
((findDisplay 5155) displayCtrl 100) ctrlMapAnimAdd [0, 0.3, getpos _selectedmember];
ctrlMapAnimCommit ((findDisplay 5155) displayCtrl 100);

if (vehicle _selectedmember == _selectedmember) then {
	GRLIB_Squad_target attachTo [ _selectedmember, [0, 10, 0.05], "neck" ];
	GRLIB_Squad_camera attachTo [ _selectedmember, [0, 0.25, 0.05], "neck" ];
} else {
	GRLIB_Squad_target attachTo [ vehicle _selectedmember, [0, 20, 2]];
	GRLIB_Squad_camera attachTo [ vehicle _selectedmember, [0, 0, 2]];
};
GRLIB_Squad_camera camcommit 0;

private _unitname = format ["%1. %2", [ _selectedmember ] call F_getUnitPositionId, name _selectedmember];
ctrlSetText [ 201, _unitname];

ctrlSetText [ 202, format ["%1 (%2)", getText (_cfgVehicles >> (typeof _selectedmember) >> "displayName"), rank _selectedmember] ];
ctrlSetText [ 203, format ["%1 %2%3", localize 'STR_HEALTH', round (100 - ((damage _selectedmember) * 100)), '%'] ];
ctrlSetText [ 2031, format ["%1 %2/%3", localize 'STR_REVIVE', ([_selectedmember] call PAR_revive_cur), ([_selectedmember] call PAR_revive_max)] ];

((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,1,1,1];
if ( damage _selectedmember > 0.4 ) then { ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,1,0,1]; };
if ( damage _selectedmember > 0.6 ) then { ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,0.5,0,1]; };
if ( damage _selectedmember > 0.8 ) then { ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor [1,0,0,1]; };

ctrlSetText [ 204, format ["%1 %2m", localize 'STR_DISTANCE', round (player distance _selectedmember) ] ];

if ( primaryWeapon _selectedmember != "") then {
	ctrlSetText [ 205, format ["%1: %2", localize 'STR_PRIMARY_WEAPON', getText (_cfgWeapons >> (primaryWeapon _selectedmember) >> "displayName") ] ];

	private _primary_mags = 0;
	if ( count primaryWeaponMagazine _selectedmember > 0 ) then {
		_primary_mags = 1;
		{ if ( ( _x select 0 ) == ( ( primaryWeaponMagazine _selectedmember ) select 0 ) ) then { _primary_mags = _primary_mags + 1; } } foreach (magazinesAmmo _selectedmember);
	};
	ctrlSetText [ 206, format ["%1: %2", localize 'STR_AMMO', _primary_mags ] ];
} else {
	ctrlSetText [ 205, format ["%1: %2", localize 'STR_PRIMARY_WEAPON', localize 'STR_NONE' ] ];
	ctrlSetText [ 206, format ["%1: %2", localize 'STR_AMMO', 0 ] ];
};

if ( secondaryWeapon _selectedmember != "") then {
	ctrlSetText [ 207, format ["%1: %2", localize 'STR_SECONDARY_WEAPON', getText (_cfgWeapons >> (secondaryWeapon _selectedmember) >> "displayName") ] ];

	private _secondary_mags = 0;
	if ( count secondaryWeaponMagazine _selectedmember > 0 ) then {
		_secondary_mags = 1;
		{ if ( ( _x select 0 ) == ( ( secondaryWeaponMagazine _selectedmember ) select 0 ) ) then { _secondary_mags = _secondary_mags + 1; } } foreach (magazinesAmmo _selectedmember);
	};
	ctrlSetText [ 208, format ["%1: %2", localize 'STR_AMMO', _secondary_mags ] ];
} else {
	ctrlSetText [ 207, format ["%1: %2", localize 'STR_SECONDARY_WEAPON', localize 'STR_NONE' ] ];
	ctrlSetText [ 208, format ["%1: %2", localize 'STR_AMMO', 0 ] ];
};
ctrlSetText [ 216, format ["Loadout Price: %1 Ammo", ([_selectedmember] call F_loadoutPrice)] ];

if ( vehicle _selectedmember == _selectedmember ) then {
	ctrlSetText [ 209, "" ];
} else {
	private _vehstring = localize 'STR_PASSENGER';
	if (driver vehicle _selectedmember == _selectedmember ) then { _vehstring = localize 'STR_DRIVER'; };
	if (gunner vehicle _selectedmember == _selectedmember ) then { _vehstring = localize 'STR_GUNNER'; };
	if (commander vehicle _selectedmember == _selectedmember ) then { _vehstring = localize 'STR_COMMANDER'; };
	_vehstring = _vehstring + format [ " (%1)", getText (_cfgVehicles >> (typeof vehicle _selectedmember) >> "displayName") ];
	ctrlSetText [ 209, _vehstring ];
};
