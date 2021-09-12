diag_log "--- Liberation RX by pSiKO ---";
[] call compileFinal preprocessFileLineNUmbers "build_info.sqf";
if (!isMultiplayer) exitWith {
	titleText ["Sorry, Liberation RX is a Multiplayer Mission Only...","BLACK FADED", 100];
	uisleep 10;
	endMission "LOSER";
};
diag_log "--- Init start ---";
titleText ["Loading...","BLACK FADED", 100];

enableSaving [false, false];
disableMapIndicators [false,true,false,false];
setGroupIconsVisible [false,false];

abort_loading = false;
abort_loading_msg = "Unkwon Error";
GRLIB_ACE_enabled = false;
[] call compileFinal preprocessFileLineNUmbers "whitelist.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\fetch_params.sqf";

if (!abort_loading) then {
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames.sqf";
	[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";
	if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};

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
	publicVariable "GRLIB_init_server";
	publicVariable "abort_loading";
	publicVariable "abort_loading_msg";
};

if (!isDedicated && hasInterface) then {
	[] execVM "scripts\client\init_client.sqf";
} else {
	setViewDistance 1600;
	setTerrainGrid 50;
};

diag_log "--- Init stop ---";
