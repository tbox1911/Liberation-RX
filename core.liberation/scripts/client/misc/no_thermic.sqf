//disable Thermic
if (GRLIB_thermic == 2) exitWith {};

private _layer = 85125;

while {true} do {
  if ((GRLIB_thermic == 0 && currentVisionMode player == 2) || (GRLIB_thermic == 1 && currentVisionMode player == 2 && !(daytime > GRLIB_nights_start || daytime < GRLIB_nights_stop))) then {
    _layer cutText ["Thermal OFFLINE...","BLACK"];
    playSound "FD_CP_Not_Clear_F";
    waituntil {currentVisionMode player != 2};
    _layer cutText ["", "PLAIN"];
  };

  sleep 1;
};