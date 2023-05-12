// LRX Diag Tools - pSiKO
// [0] execVM "scripts\shared\diag_debug.sqf";
//
// [0] : Dump process 
// [1] : Dump GameSave dump
// [2] : Dump Profile Variables

params [["_save", 0]];
diag_log "--------------------- LRX Diag -----------------------";
diag_log "LRX version:";
[] call compileFinal preprocessFileLineNUmbers "build_info.sqf";
diag_log format ["%1 - Uptime %2sec - Render %3/%4/%5 - %6fps", worldName, round(time), viewDistance, getObjectViewDistance, getTerrainGrid, diag_fps];
diag_log "[spawn-ed, execVM-ed, exec-ed, execFSM-ed]";
diag_log diag_activeScripts;

diag_log "--- activeSQFScripts ---------------------------------";
diag_log  "[scriptName, fileName, isRunning, currentLine]";
{
  diag_log format ["%1",_x];
} forEach diag_activeSQFScripts;
diag_log "-----------------------------------------------------";

if (_save == 1) then {
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
  diag_log "--- LRX Profile Variables ---------------------------";
  {
    diag_log  format ["  %1", _x];

  } foreach (allVariables profileNamespace);

  diag_log "-----------------------------------------------------";
};
diag_log "------------------- LRX Diag End ----------------------";