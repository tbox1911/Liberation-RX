if (isDedicated || !hasInterface) exitWith { diag_log format ["Error in GRAD_fireworks, call script on client only"]; };

params [
	"_firing_position", // where rocket starts
	"_type",
	"_initial_velocity", // rocket initial speed
	"_explosion_power", // explosion radius/force
	"_glitter_count", // how many fragments
	"_color",
	"_explosion_fragments_array",
	"_explosion_subfragments_array",
	"_randomSleep",
	"_randomSleepLong",
	"_randomLaunch",
	"_launchSound",
	"_whistlingSound",
	"_bangSound",
	"_singleFizz",
	"_groupFizz",
	"_randomSleepShort"
];

_rocket ="CMflare_Chaff_Ammo" createVehicleLocal [_firing_position select 0,_firing_position select 1, 0];
_rocket setVelocity _initial_velocity;


_lightPrimary = "#lightpoint" createVehicleLocal [0,0,0];
_lightPrimary setLightBrightness 0.2;
_lightPrimary setLightColor [1,0.3,0];
_lightPrimary setLightUseFlare true;
_lightPrimary setLightFlareMaxDistance 1000;
_lightPrimary setLightFlareSize 5;


_lightSecondary = "#lightpoint" createVehicleLocal [0,0,0];
_lightSecondary setLightBrightness 0.08;
_lightSecondary setLightColor [1,0.8,0];
_lightSecondary setLightUseFlare true;
_lightSecondary setLightFlareMaxDistance 1000;
_lightSecondary setLightFlareSize 4;
sleep 0.01;
_lightPrimary lightAttachObject [_rocket,[0,0,0]];
_lightSecondary lightAttachObject [_rocket,[0,0,0]];


_rocket say3D [_launchsound,500];
sleep 1;

if (_type == "fizzer") then {
	_rocket say3D [_whistlingSound,500];
};

sleep (2 + _randomSleepShort);

deleteVehicle _lightPrimary;
deleteVehicle _lightSecondary;

if (_type == "rain") exitWith {

	for [{_i=0},{_i < count _explosion_fragments_array},{_i=_i+1}] do
	{
	[_rocket,_type,_explosion_fragments_array,_color,_i,_randomSleep,_randomSleepLong,_singleFizz,_bangSound] spawn {
		params ["_rocket", "_type", "_subfragments", "_color", "_selector", "_randomSleep", "_randomSleepLong", "_singleFizz"];

		_pos = getPos _rocket;
		_pos params ["_posx", "_posy", "_posz"];

		private ["_glitter", "_light"];

		_glitter ="G_40mm_Smoke" createVehicleLocal [_posx + ((random 3)-6),_posy+ ((random 3)-6),_posz+ ((random 3)-6)];
		_glitter setVelocity [(_subfragments select _selector select 0)/2, (_subfragments select _selector select 1)/2, 30];

		sleep 3;
		_light = "#lightpoint" createVehicleLocal [0,0,0];
		_light setLightBrightness 2;
		if (_type == "normal" || _type == "fizzer") then {
			_light setLightAmbient [1,0.9,0.6];
			} else {
			_light setLightAmbient _color;
		};
		_light setLightColor _color;
		_light lightAttachObject [_glitter,[0,0,0]];
		_light setLightUseFlare true;
		_light setLightFlareMaxDistance 1000;
		_light setLightFlareSize 0.15;

		if (random 2 > 1.5) then {
			_glitter say3D [_singleFizz, 700];
		};
		_light setLightFlareSize 0.15;
		sleep 5;

		deleteVehicle _light;
		deleteVehicle _glitter;
		};
	};
	sleep 4;
	_rocket say3D [_groupFizz, 700];
	deleteVehicle _rocket;
};

_dummyObject ="FxExploArmor3" createVehicleLocal (getPos _rocket);
deleteVehicle _rocket;
//hideObject _dummyObject;
sleep 0.10;
_dummyObject say3D [_bangSound, 1000];

for [{_i=0},{_i < count _explosion_fragments_array},{_i=_i+1}] do
{
	[_dummyObject,_type,_explosion_fragments_array,_explosion_subfragments_array,_color,_glitter_count,_i,_randomSleep,_randomSleepLong,_singleFizz,_groupFizz,_bangSound] spawn {
		params ["_rocket", "_type", "_fragments", "_subfragments", "_color", "_glitter_count", "_selector", "_randomSleep", "_randomSleepLong", "_singleFizz", "_groupFizz", "_bangSound"];

		_secondaryRocket ="CMflare_Chaff_Ammo" createVehicleLocal (getPos _rocket);
		_smoke ="SmokeLauncherAmmo" createVehicleLocal (getPos _rocket);

		_secondaryRocket setVelocity (_fragments select _selector);

		_light = "#lightpoint" createVehicleLocal [0,0,0];
		_light setLightBrightness 1.0;
		if (_type == "normal" || _type == "fizzer") then {
			_light setLightAmbient [1,0.9,0.6];
		} else {
			_light setLightAmbient _color;
		};

		_light setLightColor _color;
		_light lightAttachObject [_secondaryRocket,[0,0,0]];

		_light setLightUseFlare true;
		_light setLightFlareMaxDistance 1000;
		_light setLightFlareSize 2;

		if (_type == "normal") then {
			sleep (4 + (random 1));
			deleteVehicle _light;
		};

		if (_type == "fizzer")  then {
			sleep 1.0;
			deleteVehicle _light;

			_secondaryRocket say3D [_bangSound, 1000];

			for [{_j=0},{_j < (count _subfragments)},{_j=_j+1}] do
			{

				[_secondaryRocket,_type,_subfragments,_color,_j,_randomSleep,_randomSleepLong,_singleFizz,_groupFizz,_bangSound] spawn {
					params ["_rocket", "_type", "_subfragments", "_color", "_selector", "_randomSleep", "_randomSleepLong", "_singleFizz", "_groupFizz", "_bangSound"];

					_pos = getPos _rocket;
					_pos params ["_posx", "_posy", "_posz"];

					deleteVehicle _rocket;

					private ["_flare", "_light"];
					_flare ="CMflare_Chaff_Ammo" createVehicleLocal [_posx + ((random 20)-10),_posy+ ((random 20)-10), _posz+ ((random 20)-10)];
					_flare setVelocity (_subfragments select _selector);

					_light = "#lightpoint" createVehicleLocal [0,0,0];
					_light setLightBrightness 2;
					if (_type == "normal" || _type == "fizzer") then {
							_light setLightAmbient [1,0.9,0.6];
						} else {
							_light setLightAmbient _color;
					};
					_light setLightColor _color;
					_light lightAttachObject [_flare,[0,0,0]];
					_light setLightUseFlare true;
					_light setLightFlareMaxDistance 1000;

					_flare say3D [_singleFizz, 700];

					for "_i" from 0 to random 20 do {
						_light setLightFlareSize (random 1);
						sleep (random 0.1);
						_light setLightFlareSize (random 10);
						sleep (random 0.1);
					};

					_fadeOutTime = 5 + random 2;
					for "_i" from 0 to _fadeOutTime do {
						_light setLightFlareSize _fadeOutTime - _i;
						sleep 0.2;
					};
					deleteVehicle _light;
					deleteVehicle _flare;
				};
			};
		};
	};
};

sleep 1;

_dummyObject say3D [_groupFizz, 700];
sleep 2;
deleteVehicle _dummyObject;