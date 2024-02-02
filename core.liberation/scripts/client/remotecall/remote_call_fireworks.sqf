if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_pos", ["_rounds", 1]];

if (player distance2D _pos > GRLIB_sector_size) exitWith {};
if (!(call is_night)) exitWith {};

private _colors = [
	[1,1,1],[1,0,0],[1,0,1],[1,1,0],
	[0,1,0],[0,1,1],[1,0.5,0],
	[0,0,1],[0,0.5,1],[0.5,0,1],
	[1,0.5,0],[0.5,1,0],[1,1,1]
];

_pos = _pos vectorAdd [0,0, 25];
playSound3D [getMissionPath "res\launch01.ogg", _pos, false, ATLtoASL _pos, 5, 1, 600];

private _launcher = "CMflare_Chaff_Ammo" createVehicleLocal _pos;
private _light = "#lightpoint" createVehicleLocal [0,0,0];
_light setLightBrightness 1;
_light setLightAmbient [1,1,1];
_light setLightColor [1,1,1];
_light setLightUseFlare true;
_light setLightFlareMaxDistance 500;
_light setLightFlareSize 2;
_light lightAttachObject [_launcher, [0,0,0]];
_launcher setVelocity [(random 20) -10, (random 20) -10, 150];
sleep 4;

private _laucher_pos = getPosATL _launcher;
for "_i" from 1 to _rounds do {
	[_laucher_pos, selectRandom _colors] spawn {
		params ["_pos", "_color"];
		playSound3D [getMissionPath "res\bang01.ogg", _pos, false, ATLToASL _pos, 5, 1, 1800];
		sleep 0.5;

		private _flare = "CMflare_Chaff_Ammo" createVehicleLocal _pos;
		private _light = "#lightpoint" createVehicleLocal [0,0,0];
		_light setLightBrightness 2;
		_light setLightAmbient _color;
		_light setLightColor _color;
		_light setLightFlareSize 5;
		_light setLightFlareMaxDistance 500;
		_light setLightUseFlare true;
		_light lightAttachObject [_flare, [0,0,0]];
		_flare setVelocity [(random 20) -10, (random 20) -10, 3];
		sleep (5 + (random 2));
		deleteVehicle _light;
	};
	sleep (0.2 + (random 0.2));
};
deleteVehicle _light;
deleteVehicle _launcher;
