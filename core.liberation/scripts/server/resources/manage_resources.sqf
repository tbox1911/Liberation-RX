waitUntil { !isNil "save_is_loaded" };
waitUntil { !isNil "blufor_sectors" };
private [ "_spawnsector", "_newbox"];

// maximum number of ressource by type
GRLIB_AmmoBox_cap = 12;
GRLIB_FuelBarrel_cap = 10;
GRLIB_WaterBarrel_cap = 8;
GRLIB_FoodBarrel_cap = 6;

_countAllBox = {
	params ["_type"];

	private _ret = {
		typeof _x == _type &&
		!([_x, "LHD", GRLIB_fob_range] call F_check_near) &&
		!([_x, "FOB", GRLIB_fob_range] call F_check_near) 
	} count vehicles;

	_ret;
};

_countSectorBox = {
	params ["_type", "_sector"];

	private _ret = {
		typeof _x == _type &&
		(getPosATL _x) distance2D (markerPos _sector) < GRLIB_fob_range
	} count vehicles;

	_ret;
};

while { GRLIB_endgame == 0 } do {
	sleep 1200;

	_nb_players = count (AllPlayers - (entities "HeadlessClient_F"));
	if ( _nb_players > 0 ) then {

		private _AmmoBox_cap = (_nb_players * 3) min GRLIB_AmmoBox_cap;
		private _FuelBarrel_cap = (_nb_players * 3) min GRLIB_FuelBarrel_cap;
		private _WaterBarrel_cap = (_nb_players * 3) min GRLIB_WaterBarrel_cap;
		private _FoodBarrel_cap = (_nb_players * 3) min GRLIB_FoodBarrel_cap;

		// AmmoBox
		private _blufor_mil_sectors = [];
		{
			if ( _x in sectors_military ) then { _blufor_mil_sectors pushback _x };
		} foreach blufor_sectors;

		if ( count _blufor_mil_sectors > 0 ) then {
			if ( GRLIB_passive_income ) then {

				private _income = (100 + floor(random 100));
				{
					[_x, _income, 0] call ammo_add_remote_call;
				} forEach (AllPlayers - (entities "HeadlessClient_F"));
				_text = format ["Passive Income Received: + %1 Ammo.", _income];
				[gamelogic, _text] remoteExec ["globalChat", 0];
			} else {
				if ( ([ammobox_b_typename] call _countAllBox) <= _AmmoBox_cap ) then {	
					_spawnsector = ( selectRandom _blufor_mil_sectors );
					if ( ([ammobox_b_typename, _spawnsector] call _countSectorBox) < 3 ) then {
						_newbox = [ammobox_b_typename,  markerpos _spawnsector, false] call boxSetup;
						clearWeaponCargoGlobal _newbox;
						clearMagazineCargoGlobal _newbox;
						clearItemCargoGlobal _newbox;
						clearBackpackCargoGlobal _newbox;
					};
				};
			};
		};

		// Fuel Barrel
		private _blufor_fuel_sectors = [];
		{
			if ( _x in sectors_factory ) then { _blufor_fuel_sectors pushback _x };
		} foreach blufor_sectors;

		if ( count _blufor_fuel_sectors > 0 ) then {
			if ( ([fuelbarrel_typename] call _countAllBox) <= _FuelBarrel_cap ) then {
				_spawnsector = ( selectRandom _blufor_fuel_sectors );
				if ( ([fuelbarrel_typename, _spawnsector] call _countSectorBox) < 3 ) then {
					_newbox = [fuelbarrel_typename, markerpos _spawnsector, false] call boxSetup;
				};
			};
		};

		// Water Barrel
		private _blufor_water_sectors = [];
		{
			if ( _x in sectors_tower ) then { _blufor_water_sectors pushback _x };
		} foreach blufor_sectors;

		if ( count _blufor_water_sectors > 0 ) then {
			if ( ([waterbarrel_typename] call _countAllBox) <= _WaterBarrel_cap ) then {
				_spawnsector = ( selectRandom _blufor_water_sectors );
				if ( ([waterbarrel_typename, _spawnsector] call _countSectorBox) < 3 ) then {
					_newbox = [waterbarrel_typename, markerpos _spawnsector, false] call boxSetup;
				};
			};
		};

		// Food Barrel
		private _blufor_food_sectors = [];
		{
			if ( _x in sectors_bigtown ) then {	_blufor_food_sectors pushback _x };
		} foreach blufor_sectors;

		if ( count _blufor_food_sectors > 0 ) then {
			if ( ([foodbarrel_typename] call _countAllBox) <= _FoodBarrel_cap ) then {
				_spawnsector = ( selectRandom _blufor_food_sectors );
				if ( ([foodbarrel_typename, _spawnsector] call _countSectorBox) < 3 ) then {
					_newbox = [foodbarrel_typename, markerpos _spawnsector, false] call boxSetup;
				};
			};
		};

	};
};