//disable Thermic
if (GRLIB_thermic) exitWith {};

_layer = 85125;

while {true} do {

  if (currentVisionMode player == 2) then {
    _layer cutText ["Thermal OFFLINE...","BLACK"];
    playSound "FD_CP_Not_Clear_F";
    waituntil {currentVisionMode player != 2};
    _layer cutText ["", "PLAIN"];
  };

  //{_x disableTIEquipment true} forEach vehicles; 
  sleep 1;
};