params [ "_pos" ];

private _spawnpos = [_pos, 3] call F_findSafePlace;
if (count _spawnpos == 0) exitWith {[]};

private _type_random = [
	"Cock_random_F",
	"Hen_random_F",
	"Alsatian_Random_F",
	"Fin_random_F",
	"Goat_random_F",
	"Sheep_random_F"
];

private _type_desert = [
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

private _is_desert = (worldname in ["SefrouRamal", "Takistan", "Isladuala3"] && GRLIB_WS_enabled);
private _count = (3 + floor(random 4));
private _type = selectRandom _type_random;
if (_is_desert) then { _type = selectRandom (_type_random + _type_desert) };
private _is_dromedary = (_type select [0,11] == "Dromedary_");
if (_type in ["Alsatian_Random_F","Fin_random_F"]) then { _count = 2 };
if (_type in ["Cock_random_F","Hen_random_F"]) then { _count = _count + 2 };

private _created_animals = [];
for "_n" from 1 to _count do {
	if (_is_dromedary) then { _type = selectRandom _type_desert };
	_animal = createAgent [_type, _spawnpos, [], 5, "NONE"];
	// _animal setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_created_animals pushBack _animal;
	sleep 0.2;
};

_created_animals;
