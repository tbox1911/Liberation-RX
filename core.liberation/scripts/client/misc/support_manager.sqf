private ["_neararsenal", "_nearmedic", "_needammo1", "_needammo2", "_needmedic", "_magType", "_list_static", "_min"];

_distarsenal = 20;
_maxsec = 3;
_list_static = [];
{_list_static pushBack ( _x select 0 )} foreach (static_vehicles);

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

	{
		// Out vehicle
		if (_x != player && lifeState _x != 'incapacitated' && vehicle _x == _x) then {
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
					_target setVariable ['MGI_heal', true];
					_target playMove "AinvPknlMstpSlayWrflDnon_medic";
					sleep 6;
					if (lifeState _target != 'incapacitated') then {
						_target setDamage 0;
					};
					sleep 4;
					_target setVariable ['MGI_heal', nil];
				};
			};

		};

		// In vehicle
		if (lifeState _x != 'incapacitated' && vehicle _x != _x) then {
			_vehicle = vehicle _x;
			_vehicle_class = typeOf _vehicle;

			if (_vehicle_class in _list_static) then {
				// Arsenal
				_neararsenal =  ((getpos _x) nearEntities [["Box_NATO_Ammo_F", "Box_NATO_WpsLaunch_F"], _distarsenal]) +
								((getpos _x) nearobjects [FOB_typename, _distarsenal * 2]);

				if (count(_neararsenal) > 0)  then {
					// check primary Weapon
					if (count magazines _vehicle < 3) then {
						_magType = getArray(configFile >> "CfgVehicles" >> _vehicle_class >> "Turrets" >> "MainTurret" >> "magazines") select 0;
						_vehicle addMagazines [_magType, 4];
						_arsenal_text = getText (configFile >> "CfgVehicles" >> typeOf (_neararsenal select 0) >> "displayName");
						_x groupchat format ["Rearming Static Weapon at %1.", _arsenal_text];
					};
				};
			};
		};
	} forEach _UnitList;
	sleep 15;
};