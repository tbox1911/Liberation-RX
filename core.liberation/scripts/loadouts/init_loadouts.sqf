// Customize loadout - Only Militia 
loadout_militia = compile preprocessFileLineNumbers (format ["scripts\loadouts\%1\%2.sqf", GRLIB_mod_east, "default"]);
loadout_crewman = compile preprocessFileLineNumbers (format ["scripts\loadouts\%1\%2.sqf", GRLIB_mod_east, "crewman"]);

// Customize loadout - Only player and build AI 
_west_loadout_overide = [
	"B_medic_F"
];

_east_loadout_overide = [
	"O_medic_F"
];

units_loadout_overide = _west_loadout_overide + _east_loadout_overide;
