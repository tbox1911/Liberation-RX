//////////////////////////////////////////////////////////////
// MADE BY MOERDERHOSCHI
// EDITED VERSION OF THE ARMA2 ORIGINAL SCRIPT
// ARMED-ASSAULT.DE
// 06.11.2013
//////////////////////////////////////////////////////////////

//--- Earthquake
playsound "nuke";

// player spawn {
// 	//playsound "eq";
// 	for "_i" from 0 to 200 do {
// 		_vx = vectorup _this select 0;
// 		_vy = vectorup _this select 1;
// 		_vz = vectorup _this select 2;
// 		_coef = 0.01 - (0.0001 * _i);
// 		_this setvectorup [
// 			_vx+(-_coef+random (2*_coef)),
// 			_vy+(-_coef+random (2*_coef)),
// 			_vz+(-_coef+random (2*_coef))
// 		];
// 		sleep (0.01 + random 0.01);
// 	};
// 	[player, 0, 0] call BIS_fnc_setPitchBank;
// };

[3] spawn BIS_fnc_earthquake;
