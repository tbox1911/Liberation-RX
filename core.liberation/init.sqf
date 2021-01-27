[] call compileFinal preprocessFileLineNUmbers "build_info.sqf";
diag_log "--- Liberation RX by pSiKO ---";
diag_log format ["Build date: %1", GRLIB_build_date];
diag_log "--- Init start ---";

enableSaving [false, false];
disableMapIndicators [false,true,false,false];
setGroupIconsVisible [false,false];

[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\fetch_params.sqf";
[] call compileFinal preprocessFileLineNUmbers "gameplay_constants.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames.sqf";

[] execVM "GREUH\scripts\GREUH_activate.sqf";
if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};

if (isServer) then {
	lhd setpos getmarkerpos "base_chimera";
	lhd hideObject true;
	//{ deleteVehicle _x } foreach ( ( getmarkerpos "lhd" ) nearObjects 500 );
	[] execVM "scripts\server\init_server.sqf";
};

if (!isDedicated && !hasInterface && isMultiplayer) then {
	[] execVM "scripts\server\offloading\hc_manager.sqf";
};

if (!isDedicated && hasInterface) then {
	waitUntil { alive player };
	[] execVM "scripts\client\init_client.sqf";
} else {
	setViewDistance 1600;
};

diag_log "--- Init stop ---";