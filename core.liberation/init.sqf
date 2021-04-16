titleText ["","BLACK FADED", 1000];
diag_log "--- Liberation RX by pSiKO ---";
[] call compileFinal preprocessFileLineNUmbers "build_info.sqf";
diag_log "--- Init start ---";

enableSaving [false, false];
disableMapIndicators [false,true,false,false];
setGroupIconsVisible [false,false];

[] call compileFinal preprocessFileLineNUmbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\fetch_params.sqf";
[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";

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

if (!isDedicated && hasInterface) then {
	waitUntil { sleep 1; !isNil "GRLIB_init_server" };
	[] execVM "scripts\client\init_client.sqf";
	[] execVM "GREUH\scripts\GREUH_activate.sqf";
} else {
	setViewDistance 1600;
};

diag_log "--- Init stop ---";