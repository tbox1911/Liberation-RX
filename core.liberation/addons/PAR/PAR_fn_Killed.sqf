params ["_unit"];
_unit connectTerminalToUAV objNull;

if (_unit == player) then {
	private ["_pos", "_grave", "_grave_dir", "_grave_box", "_grave_box_pos", "_uniform", "_vest", "_backpack" ];
	_pos = getPosATL _unit;
	if ( isNull objectParent player && _pos distance2D lhd >= 1000 && _pos distance2D ([] call F_getNearestFob) >= GRLIB_sector_size && round(_pos select 2) == 0 && !(surfaceIsWater _pos)) then {
		_unit setPos zeropos;
		// create grave
		_grave = (selectRandom GRLIB_player_grave) createVehicle _pos;
		_grave enableSimulationGlobal false;
		_grave setvariable ["GRLIB_grave_message", format ["%1 - R.I.P -", name player], true];

		// remove old grave box
		_old_grave_box = _unit getVariable "GRLIB_grave_box";
		if (!isNil "_old_grave_box") then { deleteVehicle _old_grave_box };

		// create grave box
		_grave_dir = getDir _grave; 
		_grave_box_pos = (getposASL _grave) vectorAdd ([[-1.8, 0, 0], -_grave_dir] call BIS_fnc_rotateVector2D);    
		_grave_box = "Land_PlasticCase_01_small_black_F" createVehicle _grave_box_pos;
		_grave_box setPosASL _grave_box_pos; 
		_grave_box setDir _grave_dir; 
		_grave_box setVariable ["R3F_LOG_disabled",true,true];
		_grave_box setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
		_unit setvariable ["GRLIB_grave_box", _grave_box];

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
};

removeAllWeapons _unit;
hidebody _unit;
sleep 10;
deleteVehicle _unit;
