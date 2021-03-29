waitUntil { !isNil "save_is_loaded" };
waitUntil { !isNil "blufor_sectors" };

while { GRLIB_endgame == 0 } do {
	sleep (floor random [10,15,20] * 60);

	if ( count allPlayers > 0 ) then {

		// AmmoBox
		_blufor_mil_sectors = [];
		{
			if ( _x in sectors_military ) then {
				_blufor_mil_sectors pushback _x;
			};
		} foreach blufor_sectors;

		if ( count _blufor_mil_sectors > 0 ) then {
			if ( GRLIB_passive_income ) then {

				private _income = (75 + floor(random 100));
				{
					private _ammo_collected = _x getVariable ["GREUH_ammo_count",0];
					_x setVariable ["GREUH_ammo_count", _ammo_collected + _income, true];
				} forEach allPlayers;
				_text = format ["Reward Received: + %1 Ammo.", _income];
				[gamelogic, _text] remoteExec ["globalChat", 0];
			} else {
				if ( ( { typeof _x == ammobox_b_typename } count vehicles ) <= ( ceil ( ( count _blufor_mil_sectors ) * 1.1 ) ) ) then {

					_spawnsector = ( selectRandom _blufor_mil_sectors );
					_newbox = [ammobox_b_typename,  markerpos _spawnsector, false] call boxSetup;

					clearWeaponCargoGlobal _newbox;
					clearMagazineCargoGlobal _newbox;
					clearItemCargoGlobal _newbox;
					clearBackpackCargoGlobal _newbox;
				};
			};
		};

		// Fuel Barrel
		_blufor_fuel_sectors = [];
		{
			if ( _x in sectors_factory ) then {
				_blufor_fuel_sectors pushback _x;
			};
		} foreach blufor_sectors;

		if ( count _blufor_fuel_sectors > 0 ) then {
			if ( ( { typeof _x == fuelbarrel_typename } count vehicles ) <= ( ceil ( ( count _blufor_fuel_sectors ) * 0.95 ) ) ) then {

				_spawnsector = ( selectRandom _blufor_fuel_sectors );
				_newbox = [fuelbarrel_typename, markerpos _spawnsector, false] call boxSetup;
			};
		};

		// Water Barrel
		_blufor_water_sectors = [];
		{
			if ( _x in sectors_tower ) then {
				_blufor_water_sectors pushback _x;
			};
		} foreach blufor_sectors;

		if ( count _blufor_water_sectors > 0 ) then {
			if ( ( { typeof _x == waterbarrel_typename } count vehicles ) <= ( ceil ( ( count _blufor_water_sectors ) * 0.95 ) ) ) then {

				_spawnsector = ( selectRandom _blufor_water_sectors );
				_newbox = [waterbarrel_typename, markerpos _spawnsector, false] call boxSetup;
			};
		};

		// Food Barrel
		_blufor_food_sectors = [];
		{
			if ( _x in sectors_bigtown ) then {
				_blufor_food_sectors pushback _x;
			};
		} foreach blufor_sectors;

		if ( count _blufor_food_sectors > 0 ) then {
			if ( ( { typeof _x == foodbarrel_typename } count vehicles ) <= ( ceil ( ( count _blufor_food_sectors ) * 3 ) ) ) then {

				_spawnsector = ( selectRandom _blufor_food_sectors );
				_newbox = [foodbarrel_typename, markerpos _spawnsector, false] call boxSetup;
			};
		};

	};
};