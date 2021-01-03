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
//_greuh_liberation_savegame = profileNamespace getVariable GRLIB_save_key;
//{diag_log _x } foreach _greuh_liberation_savegame;
diag_log "-----------------------------------------------------";