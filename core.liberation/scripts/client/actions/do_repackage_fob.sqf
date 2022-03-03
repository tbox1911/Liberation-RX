_fob_pos = _this select 3;
if (isNil "_fob_pos") exitWith {};
private ["_fob_hq", "_fobbox", "_near_sign" ];

//only one at time
_fob_hq = player nearobjects [FOB_typename, GRLIB_fob_range] select 0;
_fob_sign = (getPosATL _fob_hq) nearobjects [FOB_sign, 10] select 0;
if ((_fob_hq getVariable ["fob_in_use", false])) exitWith {};
_fob_hq setVariable ["fob_in_use", true, true];

//check owner
if (isNil "_fob_sign") then { _fob_sign = objNull};
// if (getPlayerUID player != _fob_sign getVariable ["GRLIB_vehicle_owner", ""]) exitWith {hintSilent "Error!\nYour are NOT the owner of the FOB!"};

dorepackage = 0;
createDialog "liberation_repackage_fob";
waitUntil { dialog };
while { dialog && alive player && dorepackage == 0 } do {
	sleep 0.5;
};
_fob_hq setVariable ["fob_in_use", false, true];

if ( dorepackage > 0 ) then {
	closeDialog 0;
	waitUntil { !dialog };

	GRLIB_all_fobs = GRLIB_all_fobs - [ _fob_pos ];
	publicVariable "GRLIB_all_fobs";
	deleteVehicle _fob_hq;
	deleteVehicle _fob_sign;
	sleep 0.5;

	_spawnpos = zeropos;
	while { _spawnpos distance zeropos < 1000 } do {
		_spawnpos = ( getpos player ) findEmptyPosition [5, 100, 'B_Heli_Transport_01_F'];
		if ( count _spawnpos == 0 ) then { _spawnpos = zeropos; };
	};

	if ( dorepackage == 1 ) then {
		_fobbox = FOB_box_typename createVehicle _spawnpos;
	};

	if ( dorepackage == 2 ) then {
		_fobbox = FOB_truck_typename createVehicle _spawnpos;
	};

	if (! isNil "_fobbox" ) then {
		clearWeaponCargoGlobal _fobbox;
		clearMagazineCargoGlobal _fobbox;
		clearItemCargoGlobal _fobbox;
		clearBackpackCargoGlobal _fobbox;
		_fobbox setVariable ["fob_in_use", false, true];
		_fobbox addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	};
	hint localize "STR_FOB_REPACKAGE_HINT";
};
