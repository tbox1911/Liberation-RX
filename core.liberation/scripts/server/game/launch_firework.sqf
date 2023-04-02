params ["_unit"];
private _pos = getPosATL _unit vectorAdd [0,0, 30];
private _colors = [[1,0,0],[1,0,1],[1,1,0],[0,1,0],[0,1,1],[0,0,1],[1,1,1]];

{
	if ((_x distance2D _unit) <= 200) then {
		[[getMissionPath "res\launch01.ogg", _unit, false, getPosASL _unit, 5, 1, 250]] remoteExec ["playSound3D", owner _x];
	};
} forEach (AllPlayers - (entities "HeadlessClient_F"));


for "_i" from 0 to 4 do {
	[_pos, selectRandom _colors ] spawn {
		params ["_pos", "_color"];
		_flare = createVehicle ["CMflare_Chaff_Ammo", _pos, [], 20, "FLY"];
		_light = "#lightpoint" createVehicleLocal [0,0,0];
		_light setLightBrightness 1;
		_light setLightAmbient [1,1,1];
		_light setLightColor [1,1,1];
		_light setLightUseFlare true;
		_light setLightFlareMaxDistance 500;
		_light setLightFlareSize 2;
		_light lightAttachObject [_flare, [0,0,0]];
		_velocity = [(random 20) -10, (random 20) -10, 100];
		_flare setVelocity _velocity;

		sleep 4;
		{
			if ((_x distance2D _flare) <= 1000) then {
				[[getMissionPath "res\bang01.ogg", _flare, false, getPosASL _flare, 5, 1, 1000]] remoteExec ["playSound3D", owner _x];
			};
		} forEach (AllPlayers - (entities "HeadlessClient_F"));
		sleep 0.5;

		_light setLightBrightness 2;
		_light setLightAmbient _color;
		_light setLightColor _color;
		_light setLightFlareSize 5;
		_light setLightFlareMaxDistance 1000;

		sleep (5 + (random 2));
		deleteVehicle _light;
	};
	sleep 0.2;
};