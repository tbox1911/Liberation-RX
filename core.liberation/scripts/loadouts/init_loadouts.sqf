// Customize loadout - Only Militia 
// template located in mod_template\<MOD>\loadout

loadout_militia = compile preprocessFileLineNumbers "scripts\loadouts\default.sqf";
loadout_crewman = compile preprocessFileLineNumbers (format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_east, "crewman"]);
