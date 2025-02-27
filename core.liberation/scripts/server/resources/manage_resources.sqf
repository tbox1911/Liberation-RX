waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "blufor_sectors"};

// maximum number of ressource by type
GRLIB_AmmoBox_cap = round (5 * GRLIB_resources_multiplier);
GRLIB_FuelBarrel_cap = round (6 * GRLIB_resources_multiplier);
GRLIB_WaterBarrel_cap = round (6 * GRLIB_resources_multiplier);
GRLIB_FoodBarrel_cap = round (5 * GRLIB_resources_multiplier);

// It should not be too easy...
if (GRLIB_difficulty_modifier > 1.5) then {
	GRLIB_AmmoBox_cap = 3;
	GRLIB_FuelBarrel_cap = 4;
	GRLIB_WaterBarrel_cap = 4;
	GRLIB_FoodBarrel_cap = 3;
};

private _sectors = [];
while { GRLIB_endgame == 0 } do {
	sleep GRLIB_passive_delay;

	_active_players = count (AllPlayers - (entities "HeadlessClient_F"));
	if (_active_players > 0) then {
		diag_log format ["--- LRX Resources Manager start at %1", time];
		private _AmmoBox_cap = (_active_players * 3) min GRLIB_AmmoBox_cap;
		private _FuelBarrel_cap = (_active_players * 3) min GRLIB_FuelBarrel_cap;
		private _WaterBarrel_cap = (_active_players * 3) min GRLIB_WaterBarrel_cap;
		private _FoodBarrel_cap = (_active_players * 4) min GRLIB_FoodBarrel_cap;

		// AmmoBox
		if (GRLIB_passive_income) then {
			private _captured_military = { _x in sectors_military } count blufor_sectors;
			if (_captured_military > 0) then {
				private _income = round (GRLIB_passive_ammount * (_captured_military min GRLIB_AmmoBox_cap) * GRLIB_resources_multiplier);
				{
					[_x, _income, 0] call ammo_add_remote_call;
				} forEach (AllPlayers - (entities "HeadlessClient_F"));
				private _text = format ["Passive Income you receive %1 Ammo.", _income];
				[gamelogic, _text] remoteExec ["globalChat", 0];
				diag_log format ["Passive Income %1 Ammo to all players", _income];
			};
		};

		if (!GRLIB_passive_income && ([ammobox_b_typename] call count_box) < _AmmoBox_cap) then {
			_sectors = [];
			{
				if (_x in sectors_military && (([ammobox_b_typename, _x] call count_box) < 3)) then { _sectors pushback _x };
			} foreach blufor_sectors;

			if (count _sectors > 0) then {
				[(selectRandom _sectors), ammobox_b_typename, false, 80] call spawn_box;
			};
		};

		// Fuel Barrel
		if (([fuelbarrel_typename] call count_box) < _FuelBarrel_cap) then {
			_sectors = [];
			{
				if (_x in sectors_factory && ([fuelbarrel_typename, _x] call count_box) < 3) then { _sectors pushback _x };
			} foreach blufor_sectors;

			if (count _sectors > 0) then {
				[(selectRandom _sectors), fuelbarrel_typename, false, 80] call spawn_box;
			};
		};

		// Water Barrel
		if (([waterbarrel_typename] call count_box) < _WaterBarrel_cap) then {
			_sectors = [];
			{
				if (_x in sectors_tower && ([waterbarrel_typename, _x] call count_box) < 3) then { _sectors pushback _x };
			} foreach blufor_sectors;

			if (count _sectors > 0) then {
				[(selectRandom _sectors), waterbarrel_typename, false, 80] call spawn_box;
			};
		};

		// Food Barrel
		if (([foodbarrel_typename] call count_box) < _FoodBarrel_cap) then {
			_sectors = [];
			{
				if (_x in sectors_bigtown && ([foodbarrel_typename, _x] call count_box) < 4) then { _sectors pushback _x };
			} foreach blufor_sectors;

			if (count _sectors > 0) then {
				[(selectRandom _sectors), foodbarrel_typename, false, 80] call spawn_box;
			};
		};
	};
};