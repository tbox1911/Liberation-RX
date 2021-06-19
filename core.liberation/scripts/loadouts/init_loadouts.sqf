// Customize loadout - Only Militia 
_loadouts_folder = format ["scripts\loadouts\%1", GRLIB_mod_east];
loadout_crewman = compile preprocessFileLineNumbers (format ["%1\%2.sqf", _loadouts_folder, "crewman"]);
loadout_militia = compile preprocessFileLineNumbers (format ["%1\%2.sqf", _loadouts_folder, "default"]);

// Customize loadout - Only player and build AI 
_west_loadout_overide = [
	"B_medic_F"
];

_east_loadout_overide = [
	"O_medic_F"
];

units_loadout_overide = _west_loadout_overide + _east_loadout_overide;
