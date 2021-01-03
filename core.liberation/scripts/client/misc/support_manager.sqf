private ["_neararsenal", "_nearmedic", "_needammo1", "_needammo2", "_needmedic", "_magType", "_list_vehicles", "_min"];

_distarsenal = 30;
_maxsec = 3;
_list_vehicles = [];
{_list_vehicles pushBack ( _x select 0 )} foreach ( light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + opfor_recyclable );
_ignore_ammotype = ["Laserbatteries", "8Rnd_82mm_Mo_Flare_white", "8Rnd_82mm_Mo_Smoke_white"];
_list_static = ["B_static_AT_F", "B_static_AA_F", "O_static_AT_F", "O_static_AA_F"];

NeedAmmo = {
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

AddAmmo = {
	params ["_unit", "_item", "_max"];
	private _stop = true;
	_magType = getArray( configFile >> "CfgWeapons" >> _item >> "magazines" ) select 0;
	for [{_i=0}, {_i<_max && _stop}, {_i=_i+1}] do {
		if (_unit canAdd _magType) then {
			_unit addMagazines [_magType, 1];
		} else {
			_stop = false;
			_unit groupchat "Inventory is full !!";
		};
	};
	_stop;
};

waituntil {sleep 1;!isNull player};
waitUntil {sleep 1;GRLIB_player_spawned};

while { true } do {
	waitUntil {sleep 1;GRLIB_player_spawned && (count(units group player) > 0)};
	_maxpri = 10;
	_needammo1 = false;
	_needammo2 = false;
	_needmedic = false;
	_UnitList = units group player;
	_my_squad = player getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then { { _UnitList pushBack _x } forEach units _my_squad };
	{_UnitList append units _x} foreach hcAllGroups player;
	{
		// Out vehicle
		if (_x != player && lifeState _x != 'INCAPACITATED' && vehicle _x == _x) then {
			_needammo1 = false;
			_needammo2 = false;
			_needmedic = false;
			// Arsenal
			_neararsenal =  ((getpos _x) nearEntities [ai_resupply_sources, _distarsenal]) +
							((getpos _x) nearobjects [FOB_typename, _distarsenal * 2]);

			if (count(_neararsenal) > 0)  then {
				_arsenal_text = getText (configFile >> "CfgVehicles" >> typeOf (_neararsenal select 0) >> "displayName");
				_min = 3;
				// check primary Weapon
				if ( (primaryWeapon _x) find "LMG" >= 0 || (primaryWeapon _x) find "MMG" >= 0 || (primaryWeapon _x) find "RPK12" >= 0 ) then { _min = 1; _maxpri = 3 };
				_needammo1 = [_x, primaryWeapon _x, _min] call NeedAmmo;
				if (_needammo1) then {
					_x groupchat format ["Rearming Primary Weapon at %1.", _arsenal_text];
					_needammo1 = [_x, primaryWeapon _x, _maxpri] call AddAmmo;
				};

				// check secondary Weapon if backpack present
				if (!isNull (unitBackpack _x)) then {
					_needammo2 = [_x, secondaryWeapon _x, 1] call NeedAmmo;
					if (_needammo2) then {
						//clearAllItemsFromBackpack _x;
						_x groupchat format ["Rearming Secondary Weapon at %1 !", _arsenal_text];
						_needammo2 = [_x, secondaryWeapon _x, _maxsec] call AddAmmo;
					};
				};
			};

			// Medic
			_nearmedic = ((getpos _x) nearEntities [ai_healing_sources, _distarsenal]);
			_nearmedic = _nearmedic + ((getpos _x) nearobjects [FOB_typename, _distarsenal * 2]);
			if (count(_nearmedic) > 0) then {
				if (damage _x > 0.1 && (behaviour _x) != "COMBAT") then {
					_needmedic = true;
					_medic_text = getText (configFile >> "CfgVehicles" >> typeOf (_nearmedic select 0) >> "displayName");
					_x groupchat format ["Healing myself at %1 !", _medic_text];
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

			if (_vehicle_class in _list_vehicles ) then {
				_timer = _vehicle getVariable ["GREUH_rearm_timer", 0];
				if (_timer == 0 ) then {
					_cooldown = 0;
					_max_ammo = 3;
					if (_vehicle_class in _list_static) then { _max_ammo = 6 };

					// Arsenal
					_neararsenal =  ((getpos _unit) nearEntities [vehicle_rearm_sources, _distarsenal]) +
									((getpos _unit) nearobjects [FOB_typename, _distarsenal * 2]);

					if (count(_neararsenal) > 0)  then {
						//_vehicle setVehicleAmmoDef 1;
						_magType = (getArray(configFile >> "CfgVehicles" >> _vehicle_class >> "Turrets" >> "MainTurret" >> "magazines") - _ignore_ammotype);
						{
							_ammo_type = _x;
							_cnt = { _x == _ammo_type } count magazines _vehicle;
							if (_cnt < _max_ammo) then {
								_vehicle addMagazines [_ammo_type, (_max_ammo - _cnt)];
								_arsenal_text = getText (configFile >> "CfgVehicles" >> typeOf (_neararsenal select 0) >> "displayName");
								_unit groupchat format ["Rearming %1 at %2.", _vehicle_class_text, _arsenal_text];
							};
						} forEach _magType;

						if (count (magazines _vehicle) > 0) then {
							_cooldown = 20;
							if ( _unit == player) then {
								_screenmsg = format [ "%1\n%2 - %3", _vehicle_class_text, localize "STR_REARMING", "100%" ];
								titleText [ _screenmsg, "PLAIN DOWN" ];
							};
						};
					};
					_vehicle setVariable ["GREUH_rearm_timer", _cooldown];
				} else {
					_vehicle setVariable ["GREUH_rearm_timer", (_timer - 1)];
					if ( _unit == player) then {
						_screenmsg = format [ "%1\n%2 - %3", _vehicle_class_text, "Rearming cooldown, Please Wait..." ];
						titleText [ _screenmsg, "PLAIN DOWN" ];
					};
				};
			};
		};
	} forEach _UnitList;

	// Clear waypoints
	[player] spawn clear_wpt;

	// Show Hint
	private _neartower = ((sectors_allSectors select {_x select [0,6] == "tower_" && !(_x in blufor_sectors) && player distance2D (getMarkerPos _x) <= 20})) select 0;
	if (!isNil "_neartower") then {
		_msg = format ["Use <t color='#FF0000'>Explosives</t> to destroy<br/>the <t color='#0000FF'>Radio Tower</t>."];
		[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	};

	sleep 15;
};