_fob_pos = _this select 3;
if (isNil "_fob_pos") exitWith {};
private ["_fob_hq", "_fobbox", "_near_sign" ];

//only one at time
_fob_hq = player nearobjects [FOB_typename, GRLIB_fob_range] select 0;
if (isNil "_fob_hq") exitWith {};
_fob_sign = (getPosATL _fob_hq) nearobjects [FOB_sign, 10] select 0;
if ((_fob_hq getVariable ["fob_in_use", false])) exitWith {};
_fob_hq setVariable ["fob_in_use", true, true];

//check owner
if (isNil "_fob_sign") then { _fob_sign = objNull};
if (getPlayerUID player != _fob_sign getVariable ["GRLIB_vehicle_owner", ""]) exitWith {hintSilent "Error!\nYour are NOT the owner of the FOB!"};

dorepackage = 0;
createDialog "liberation_repackage_fob";
waitUntil { dialog };
while { dialog && alive player && dorepackage == 0 } do {
	sleep 0.5;
};

if ( dorepackage > 0 ) then {
	closeDialog 0;
	waitUntil { !dialog };

	private _spawnpos = [4, (getPosATL player), 50, 30, false] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
	if ( count _spawnpos == 0 ) exitWith { hint "Cannot find enough place to repack FOB!" };

	if ( dorepackage == 1 ) then {
		_fobbox = FOB_box_typename createVehicle _spawnpos;
	};

	if ( dorepackage == 2 ) then {
		_fobbox = FOB_truck_typename createVehicle _spawnpos;
	};
	sleep 0.5;

	if ( !isNil "_fobbox" ) then {
		clearWeaponCargoGlobal _fobbox;
		clearMagazineCargoGlobal _fobbox;
		clearItemCargoGlobal _fobbox;
		clearBackpackCargoGlobal _fobbox;
		_fobbox addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
		if (GRLIB_ACE_enabled) then {
			if (_fobbox == FOB_box_typename) then {
				[_fobbox, 50] call ace_cargo_fnc_setSize;
				[_fobbox, true, [0, 3, 0], 0] call ace_dragging_fnc_setDraggable;
			};
			[_fobbox, -1] call ace_cargo_fnc_setSpace;
		};

		GRLIB_all_fobs = GRLIB_all_fobs - [ _fob_pos ];
		publicVariable "GRLIB_all_fobs";
		deleteVehicle _fob_hq;
		deleteVehicle _fob_sign;
	};
	hint localize "STR_FOB_REPACKAGE_HINT";
};
sleep 0.5;
_fob_hq setVariable ["fob_in_use", false, true];
