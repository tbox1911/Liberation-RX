waitUntil { sleep 1; !isNil "blufor_sectors" };
waitUntil { sleep 1; !isNil "GRLIB_player_spawned" };
private ["_near_arsenal", "_near_medic", "_needammo1", "_needammo2", "_maxpri", "_minpri", "_needmedic", "_magType", "_list_vehicles", "_guid", "_static_ai"];

private _distarsenal = 30;           // minimal distance from source (ammo/repair)
private _maxpri_def = 10;            // maximum magazines unit can take (primary weapon)
private _minpri_def = 3;             // minimal magazines before unit need to reload
private _maxsec_def = 3;             // maximum magazines unit can take (secondary weapon)
private _minsec_def = 1;             // minimal magazines before unit need to reload
private _guid = getPlayerUID player;

_NeedAmmo = {
	params ["_unit", "_item", "_min"];
	private _ret = false;
	if ( isClass( configFile >> "CfgWeapons" >> _item ) &&
		 {!( getArray( configFile >> "CfgWeapons" >> _item >> "magazines" ) isEqualTo [])}
		) then {
		_magType = getArray( configFile >> "CfgWeapons" >> _item >> "magazines" ) select 0;
		_magCnt = {_x == _magType} count magazines _unit;
		if (_magCnt < _min) then {_ret = true};
	};
	_ret;
};

_AddAmmo = {
	params ["_unit", "_item", "_max"];
	private _stop = true;
	_magType = getArray( configFile >> "CfgWeapons" >> _item >> "magazines" ) select 0;
	for [{_i=0}, {_i<_max && _stop}, {_i=_i+1}] do {
		if (_unit canAdd _magType && loadAbs _unit < 980) then {
			_unit addMagazines [_magType, 1];
		} else {
			_stop = false;
			_unit groupchat "Inventory is full !!";
		};
	};
	_stop;
};

while { true } do {
	waitUntil {sleep 1;GRLIB_player_spawned};

	if (count(units group player) >= 1) then {
		_needammo1 = false;
		_needammo2 = false;
		_needmedic = false;
		_unitList = units group player;
		_my_squad = player getVariable ["my_squad", nil];
		if (!isNil "_my_squad") then { { _unitList pushBack _x } forEach units _my_squad };
		{_unitList append units _x} foreach hcAllGroups player;
		_static_ai =  [vehicles, {
			typeOf _x in static_vehicles_AI &&
			_x getVariable ["GRLIB_vehicle_owner", ""] == _guid
		}] call BIS_fnc_conditionalSelect;
		{_unitList append crew _x} foreach _static_ai;

		{
			// Out vehicle
			if (_x != player && lifeState _x != 'INCAPACITATED' && vehicle _x == _x) then {
				_needammo1 = false;
				_needammo2 = false;
				_needmedic = false;
				_near_arsenal = [_x, "REAMMO_AI", _distarsenal, true] call F_check_near;

				if (_near_arsenal)  then {
					_maxpri = _maxpri_def;
					_minpri = _minpri_def;
					// check primary Weapon
					if ( (primaryWeapon _x) find "LMG" >= 0 || (primaryWeapon _x) find "MMG" >= 0 || (primaryWeapon _x) find "RPK12" >= 0 ) then { _minpri = 1; _maxpri = 3 };
					_needammo1 = [_x, primaryWeapon _x, _minpri] call _NeedAmmo;
					if (_needammo1) then {
						_x groupchat "Rearming Primary Weapon.";
						_needammo1 = [_x, primaryWeapon _x, _maxpri] call _AddAmmo;
					};

					// check secondary Weapon if backpack present
					if (!isNull (unitBackpack _x)) then {
						_needammo2 = [_x, secondaryWeapon _x, _minsec_def] call _NeedAmmo;
						if (_needammo2) then {
							//clearAllItemsFromBackpack _x;
							_x groupchat "Rearming Secondary Weapon.";
							_needammo2 = [_x, secondaryWeapon _x, _maxsec_def] call _AddAmmo;
						};
					};
				};

				// Medic
				_near_medic = [_x, "MEDIC", _distarsenal, true] call F_check_near;

				if (_near_medic) then {
					if (damage _x > 0.1 && (behaviour _x) != "COMBAT") then {
						_needmedic = true;
					};
				};

				// Animation
				if (_needammo1 || _needammo2 || _needmedic ) then {
					[_x] spawn {
						params ["_target"];
						_target setVariable ['PAR_heal', true];
						_target playMove "AinvPknlMstpSlayWrflDnon_medic";
						sleep 6;
						if (lifeState _target != 'INCAPACITATED') then {
							_target setDamage 0;
						};
						sleep 4;
						_target setVariable ['PAR_heal', nil];
					};
				};

			};

			// In vehicle
			if (lifeState _x != 'INCAPACITATED' && ( ((gunner vehicle _x) == _x) || ((driver vehicle _x) == _x) || ((commander vehicle _x) == _x) )) then {
				_unit = _x;
				_vehicle = vehicle _unit;
				_vehicle_class = typeOf _vehicle;
				_vehicle_class_text =  getText (configFile >> "CfgVehicles" >> _vehicle_class >> "displayName");
				
				// REAMMO
				_near_arsenal = [_vehicle, "REAMMO", _distarsenal, true] call F_check_near;
				_is_enabled = !(_vehicle getVariable ["R3F_LOG_disabled", false]);
				_vehicle_need_ammo = (([_vehicle] call F_getVehicleAmmoDef) <= 0.80);
				if (((_vehicle_class iskindof "LandVehicle") || (_vehicle_class iskindof "Air") || (_vehicle_class iskindof "Ship")) && _near_arsenal && _is_enabled && _vehicle_need_ammo) then {
					_timer = _vehicle getVariable ["GREUH_rearm_timer", 0];
					if (_timer <= time) then {
						_max_ammo = 3;
						_vehicle setVehicleAmmo 1;
						_vehicle setVariable ["GREUH_rearm_timer", round (time + (5*60))];  // min cooldown
						_screenmsg = format [ "%1\n%2 - %3", _vehicle_class_text, localize "STR_REARMING", "100%" ];
						titleText [ _screenmsg, "PLAIN DOWN" ];
						hintSilent _screenmsg;
					} else {
						if ( _unit == player || ((uavControl _vehicle select 0) == player) ) then {
							_screenmsg = format [ "%1\nRearming Cooldown (%2 sec), Please Wait...", _vehicle_class_text, round (_timer - time) ];
							titleText [ _screenmsg, "PLAIN DOWN" ];
						};
					};
				};

				// REPAIR
				_near_repair = [_vehicle, "REPAIR_AI", _distarsenal, true] call F_check_near;
				_is_enabled = !(_vehicle getVariable ["R3F_LOG_disabled", false]);
				_vehicle_need_repair = (damage _vehicle >= 0.50);

				if (((_vehicle_class iskindof "LandVehicle") || (_vehicle_class iskindof "Air") || (_vehicle_class iskindof "Ship")) && _near_repair && _is_enabled && _vehicle_need_repair) then {
					_timer = _vehicle getVariable ["GREUH_repair_timer", 0];
					if (_timer <= time) then {
						_vehicle setDamage 0;
						_vehicle setVariable ["GREUH_repair_timer", round (time + (5*60))];  // min cooldown
						_screenmsg = format [ "%1\n%2 - %3", _vehicle_class_text, localize "STR_REPAIRING", "100%" ];
						titleText [ _screenmsg, "PLAIN DOWN" ];
						hintSilent _screenmsg;
					} else {
						if ( _unit == player || ((uavControl _vehicle select 0) == player) ) then {
							_screenmsg = format [ "%1\nRepairing Cooldown (%2 sec), Please Wait...", _vehicle_class_text, round (_timer - time) ];
							titleText [ _screenmsg, "PLAIN DOWN" ];
						};
					};
				};				

			};
		} forEach _unitList;
	};

	// Show Hint
	private _neartower = ((sectors_allSectors select {_x select [0,6] == "tower_" && !(_x in blufor_sectors) && player distance2D (getMarkerPos _x) <= 20})) select 0;
	if (!isNil "_neartower") then {
		_msg = format ["Use <t color='#FF0000'>Explosives</t> to destroy<br/>the <t color='#0000FF'>Radio Tower</t>."];
		[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	};

	sleep 15;
};