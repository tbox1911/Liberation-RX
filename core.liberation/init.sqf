titleText ["","BLACK FADED", 1000];
diag_log "--- Liberation RX by pSiKO ---";
[] call compileFinal preprocessFileLineNUmbers "build_info.sqf";
if (!isMultiplayer) exitWith { diag_log "Sorry, Liberation RX is a Multiplayer Mission Only..." };
diag_log "--- Init start ---";

enableSaving [false, false];
disableMapIndicators [false,true,false,false];
setGroupIconsVisible [false,false];

abort_loading = false;
GRLIB_ACE_enabled = false;
[] call compileFinal preprocessFileLineNUmbers "whitelist.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\fetch_params.sqf";
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames.sqf";
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD

<<<<<<< HEAD
<<<<<<< HEAD
if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};
<<<<<<< HEAD
if (GRLIB_revive != 0) then {[] execVM "addons\FAR\FAR_revive_init.sqf"};
=======
=======
if (!GRLIB_ACE_enabled) then {[] call compileFinal preprocessFileLineNumbers "R3F_LOG\init.sqf"};
>>>>>>> 91906a5c (save veh inv)
if (GRLIB_revive != 0) then {[] execVM "addons\FAR\FAR_init.sqf"};
>>>>>>> 0cf69991 (rename addon)
=======
>>>>>>> eaee8edb (init)
[] execVM "GREUH\scripts\GREUH_activate.sqf";
=======
>>>>>>> ad744a03 (init mission)
=======
=======
=======
>>>>>>> 97a50ecd (init)
[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";
>>>>>>> eefcff68 (add radius / huron type to parameters)
=======
=======
if (abort_loading) exitWith {};
>>>>>>> 9485b064 (1)
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames.sqf";
[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";
if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};
>>>>>>> cf95696e (1)

<<<<<<< HEAD
waitUntil { sleep 1; !isNil "GRLIB_ACE_enabled" };
>>>>>>> 8fd700ef (public veh concept)
if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};

=======
>>>>>>> ce1ce1ba (init)
if (isServer) then {
	{
		_x removeAllMPEventHandlers "MPKilled";
		_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
			_x setVariable ["GRLIB_vehicle_owner", "public", true];
		};
	} foreach vehicles;
=======

if (!abort_loading) then {
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames.sqf";
	[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";
	if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};
>>>>>>> f014e5c9 (startup protect)

	if (isServer) then {
		{
			_x removeAllMPEventHandlers "MPKilled";
			_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
				_x setVariable ["GRLIB_vehicle_owner", "public", true];
			};
		} foreach vehicles;

		[] execVM "scripts\server\init_server.sqf";
	};

	if (!isDedicated && !hasInterface && isMultiplayer) then {
		[] execVM "scripts\server\offloading\hc_manager.sqf";
	};
} else {
	GRLIB_init_server = false;
	publicVariable "abort_loading";
};

if (!isDedicated && hasInterface) then {
	waitUntil { sleep 1; !isNil "GRLIB_init_server" };
	[] execVM "scripts\client\init_client.sqf";
	[] execVM "GREUH\scripts\GREUH_activate.sqf";
} else {
	setViewDistance 1600;
};

diag_log "--- Init stop ---";