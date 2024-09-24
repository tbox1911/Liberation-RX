// LRX Diag Tools - pSiKO
// [0] execVM "scripts\shared\diag_debug.sqf";
//
// [0] : Dump process
// [1] : Dump Game Save
// [2] : Dump Server Variables

params [["_save", 0]];
diag_log "--------------------- LRX Diag -----------------------";
diag_log "LRX version:";
[] call compileFinal preprocessFileLineNumbers "build_info.sqf";
diag_log ["Valid PBO:", missionName, ([] call F_getValid)];
diag_log format ["%1 - Uptime %2sec - Render %3/%4/%5 - %6fps", worldName, round(time), viewDistance, getObjectViewDistance, getTerrainGrid, diag_fps];
diag_log "[spawn-ed, execVM-ed, exec-ed, execFSM-ed]";
diag_log diag_activeScripts;

diag_log "--- activeSQFScripts ---------------------------------";
diag_log  "[scriptName, fileName, isRunning, currentLine]";
{
	diag_log format ["%1",_x];
} forEach diag_activeSQFScripts;
diag_log "-----------------------------------------------------";

if (_save == 1 && isServer) then {
	diag_log "--- LRX Savegame ------------------------------------";
	diag_log format ["Save key: %1", GRLIB_save_key];
	{
		private _var = _x;
		if (typeName _var == "ARRAY") then {
			{ diag_log format ["   %1", _x] } foreach _var;
		} else { diag_log _x };
	} foreach (profileNamespace getVariable GRLIB_save_key);
	diag_log "-----------------------------------------------------";
	diag_log "Player Context";
	{
		diag_log format ["player: %1", (_x select 0)];
		diag_log format ["player stuff: %1", (_x select 1)];
		{
			diag_log format ["player AI stuff: %1", _x];
		} forEach (_x select 2);
	} forEach GRLIB_player_context;
};
diag_log "-----------------------------------------------------";

if (_save == 2) then {
	diag_log "--- LRX Server Variables ---------------------------";
	{
		diag_log  format ["  %1 = %2", _x, serverNamespace getVariable _x ];
	} foreach (allVariables serverNamespace);

	diag_log "--- LRX Player Variables ---------------------------";
	{
		diag_log  format ["  %1", _x];
	} foreach (parsingNamespace getVariable "GRLIB_Player_variables");

	diag_log "-----------------------------------------------------";
};
diag_log "------------------- LRX Diag End ----------------------";

// // Purge Player Profile
// private _force = false; // Caution !!
// private _lrx_tags = [
// 	"liberation_",
// 	"lrx_",
// 	"greuh_",
// 	"grlib_"
// ];
// {
// 	if (_force) then {
// 		diag_log  format ["%1 deleted", _x];
// 		profileNamespace setVariable [_x, nil];
// 	} else {
// 		if ([_x, _lrx_tags] call F_startsWithMultiple) then {
// 			diag_log  format ["%1 deleted", _x];
// 			profileNamespace setVariable [_x, nil];
// 		};
// 	};
// } foreach (parsingNamespace getVariable "GRLIB_Player_variables");
// saveProfileNamespace;