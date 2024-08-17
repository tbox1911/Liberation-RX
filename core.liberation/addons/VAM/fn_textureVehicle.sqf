params ["_vehicle", "_name"];

if (isNil "_vehicle") exitWith {};

private _texture = "";

if (_name == "") then {
	_texture = (configOf _vehicle >> "TextureSources") call Bis_fnc_getCfgSubClasses select 0;
} else {
	_texture = [ RPT_colorList, { _x select 0 == _name } ] call BIS_fnc_conditionalSelect select 0 select 1;
};

if (isNil "_texture") then {
	_texture = _name;
} else {
	_name = _texture;
};

camo_class_names = [_texture];
camo_display_names = [_name];
VAM_targetvehicle = _vehicle;

[] call fnc_VAM_common_camo;
