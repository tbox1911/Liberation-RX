params ["_unit"];
private ["_pos", "_grave", "_grave_box", "_uniform", "_vest", "_backpack" ];

_unit connectTerminalToUAV objNull;
[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;
_unit setVariable ['PAR_wounded', false];

if (_unit == player) then {
	// Grave + stuff box
	_pos = getPosATL _unit;
	if ( isNull objectParent player &&
			!([_unit, "LHD", GRLIB_sector_size] call F_check_near) &&
			!([_unit, "FOB", GRLIB_sector_size] call F_check_near) &&
			round (_pos select 2) == 0 && !(surfaceIsWater _pos)
	) then {
		_unit setPos zeropos;
		// create grave
		_grave = (selectRandom GRLIB_player_grave) createVehicle _pos;
		_grave setPosATL _pos;
		_grave setvariable ["GRLIB_grave_message", format ["%1 - R.I.P -", name player], true];
		_grave_dir = getDir _grave;

		// remove old grave box
		_old_grave_box = _unit getVariable "GRLIB_grave_box";
		if (!isNil "_old_grave_box") then { deleteVehicle _old_grave_box };

		// create grave box
		_grave_box_pos = (getposATL _grave) vectorAdd ([[-1.75, 0, 0], -_grave_dir] call BIS_fnc_rotateVector2D);
		_grave_box = "Land_PlasticCase_01_small_black_F" createVehicle _grave_box_pos;
		_grave_box setPosATL _grave_box_pos;
		_grave_box attachto [_grave];
		_grave_box setVariable ["R3F_LOG_disabled", true, true];
		_grave_box setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
		_unit setvariable ["GRLIB_grave_box", _grave_box, true];

		// clear box
		clearWeaponCargo _grave_box;
		clearMagazineCargo _grave_box;
		clearItemCargo _grave_box;
		clearBackpackCargo _grave_box;

		// store player stuff in the box
		// uniform
		if (uniform _unit != "") then {
			_grave_box addItemCargo [(uniform _unit), 1];
			_uniform = (everyContainer _grave_box) select (count everyContainer _grave_box) - 1 select 1;
			{_uniform addItemCargo [_x, 1]} forEach (uniformItems _unit);
		};

		// vest
		if (vest _unit != "") then {
			_grave_box addItemCargo [(vest _unit), 1];
			_vest = (everyContainer _grave_box) select (count everyContainer _grave_box) - 1 select 1;
			{_vest addItemCargo [_x, 1]} forEach (vestItems _unit);
		};

		_grave_box addItemCargo [(headgear _unit), 1];

		// weapons + attachment
		{_grave_box addWeaponWithAttachmentsCargo [_x, 1]} forEach weaponsItems _unit;
		//{_grave_box addItemCargo [_x, 1]} forEach (assignedItems _unit);

		// backpack
		if (backpack _unit != "") then {
			_grave_box addBackpackCargo [(Backpack _unit), 1];
			_backpack = firstBackpack _grave_box;
			clearItemCargo _backpack;
			clearWeaponCargo _backpack;
			clearMagazineCargo _backpack;
			clearItemCargo _backpack;
			{_backpack addItemCargo [_x, 1]} forEach (backpackItems _unit);
		};
	};

	// respawn penalty
	if ( score _unit > GRLIB_perm_log + 20 ) then { [_unit, -10] remoteExec ["addScore", 2] };
	titleText ["" ,"BLACK FADED", 100];
};

removeAllWeapons _unit;
hidebody _unit;
_unit setDamage 1;
if (!isPlayer _unit) then { sleep 30 };
deleteVehicle _unit;
