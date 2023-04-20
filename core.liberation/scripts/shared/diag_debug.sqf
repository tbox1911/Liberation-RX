diag_log "--------------------- LRX Diag -----------------------";

diag_log "[spawn-ed, execVM-ed, exec-ed, execFSM-ed]";
diag_log diag_activeScripts;

diag_log "--- activeSQFScripts ---------------------------------";
diag_log  "[scriptName, fileName, isRunning, currentLine]";
{
  diag_log format ["%1",_x];
} forEach diag_activeSQFScripts;
diag_log "-----------------------------------------------------";

diag_log "--- LRX Savegame ------------------------------------";
diag_log format ["Save key: %1", GRLIB_save_key];
_greuh_liberation_savegame = profileNamespace getVariable GRLIB_save_key;
{
  private _var = _x;
  if (typeName _var == "ARRAY") then {
    { diag_log format ["   %1", _x] } foreach _var;
  } else { diag_log _x };
} foreach _greuh_liberation_savegame;
diag_log "-----------------------------------------------------";