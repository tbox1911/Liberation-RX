//disable Thermic
if (GRLIB_thermic == 2) exitWith {};

private _layer = 85125;

while {true} do {
  if ((GRLIB_thermic == 0 && currentVisionMode player == 2) || (GRLIB_thermic == 1 && currentVisionMode player == 2 && !(call is_night))) then {
   _layer cutText [localize "STR_UI_THERMAL_OFFLINE", "BLACK"];
    playSound "FD_CP_Not_Clear_F";
    waituntil {currentVisionMode player != 2};
    _layer cutText ["", "PLAIN"];
  };

  sleep 1;
};