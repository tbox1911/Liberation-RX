params ["_pos"];

private _spawnpos = [_pos, 2, 0] call F_findSafePlace;
if (count _spawnpos == 0) exitWith {[]};

private _type_random = [
	"Cock_random_F",
	"Hen_random_F",
	"Alsatian_Random_F",
	"Fin_random_F",
	"Goat_random_F",
	"Sheep_random_F"
];

if (GRLIB_SPE_enabled) then {
	_type_random = _type_random + [
		"SPE_Cow_Brown",
		"SPE_Cow_Black"
	];
};

if (GRLIB_WS_enabled) then {
	if (worldname in ["SefrouRamal", "Takistan", "Isladuala3"]) then {
		_type_random = _type_random + [
			"Dromedary_03_lxWS",
			"Dromedary_02_lxWS",
			"Dromedary_03_saddle2_lxWS",
			"Dromedary_03_saddle_lxWS",
			"Dromedary_01_saddle_lxWS",
			"Dromedary_01_saddle2_lxWS",
			"Dromedary_04_saddle_lxWS",
			"Dromedary_04_saddle2_lxWS",
			"Dromedary_04_lxWS"
		];
	};
};
if (isClass (configFile >> "CfgVehicles" >> "WildBoar_F")) then {
	_type_random pushBack "WildBoar_F";
};
private _type = selectRandom _type_random;
private _count = (3 + floor(random 4));
if (_type select [0,11] == "Dromedary_") then { _count = 3 };
if (_type in ["Alsatian_Random_F","Fin_random_F"]) then { _count = 2 };
if (_type in ["Cock_random_F","Hen_random_F"]) then { _count = _count + 2 };

private _created_animals = [];
for "_n" from 1 to _count do {
	private _animal = createAgent [_type, _spawnpos, [], 5, "NONE"];
	// _animal setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_created_animals pushBack _animal;
	sleep 0.2;
};

_created_animals;
