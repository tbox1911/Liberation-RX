_loadouts_folder = "scripts\loadouts\vanilla\";

loadout_crewman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "crewman"]);
loadout_sl = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "sl"]);
loadout_rifleman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "rifleman"]);
loadout_autorifleman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "autorifleman"]);
loadout_autorifleman2 = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "autorifleman2"]);
loadout_rifleman_light = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "rifleman_light"]);
loadout_rifleman_akm = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "rifleman_akm"]);
loadout_marksman = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "marksman"]);
loadout_at = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "at"]);
loadout_at2 = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "at2"]);
loadout_aa = compile preprocessFileLineNumbers (format ["%1%2.sqf", _loadouts_folder, "aa"]);

militia_standard_squad = [
	loadout_sl,
	loadout_autorifleman,
	loadout_autorifleman2,
	loadout_rifleman,
	loadout_rifleman,
	loadout_rifleman_light,
	loadout_rifleman_light,
	loadout_rifleman_akm,
	loadout_rifleman_akm,
	loadout_marksman,
	loadout_at,
    loadout_at2,
	loadout_at,
    loadout_at2,
	loadout_aa
];

// Custom loadout
_west_loadout_overide = [
	"B_medic_F"
];

_east_loadout_overide = [
	"O_medic_F"
];

units_loadout_overide = _west_loadout_overide + _east_loadout_overide;
