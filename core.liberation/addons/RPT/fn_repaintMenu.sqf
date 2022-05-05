// Vehicle Paint v1.07
// by pSiko

params ["_vehicle"];

if (isNil "_vehicle") exitWith {};
if (!([player, _vehicle] call is_owner)) exitWith { hintSilent "Wrong Vehicle Owner.\nAccess is Denied !" };
if ((damage _vehicle) != 0) exitWith { hintSilent "Damaged Vehicles cannot be Painted !" };
if ([typeOf _vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) exitWith { hintSilent "This Vehicle cannot be Painted !" };

private["_color","_pic","_text"];
paint_veh = 0;
createDialog "RPT_vehicle_repaint";
waitUntil { dialog };

if(!isNull (findDisplay 2300)) then {
	_color = _vehicle getVariable ["GRLIB_vehicle_color_name", "Default"];
	_pic = getText(configOf _vehicle >> "picture");
	_text = getText(configOf _vehicle >> "DisplayName");

	ctrlSetText [230, format ["%1 - (%2)", _text, _color]];
	ctrlSetText [234, _pic];
	ctrlSetText [235, _pic];

	_veh_texture_list = (configOf _vehicle >> "TextureSources") call Bis_fnc_getCfgSubClasses;

	_i = 0;
	{
		lbAdd[231,format["%1", _x]];
		lbSetValue [231, (lbSize 231)-1, _i];
		lbSetData [231, (lbSize 231)-1, ""];
		_i = _i + 1;
	} foreach _veh_texture_list;

	{
		lbAdd[231,format["%1", _x select 0]];
		lbSetValue [231, (lbSize 231)-1, _i];
		lbSetData [231, (lbSize 231)-1, _x select 1];
		_i = _i + 1;
	} foreach (RPT_colorList + ([] call fnc_getVIP));
	lbSetCurSel [231,0];

	while { dialog && alive player } do {
		if (paint_veh == 1) then {
			_color = lbcursel 231;
			if (_color == -1) exitWith {};
			_name = lbText [231, _color];
			_texture = lbData[231, _color];

			if (_texture == "" ) then {_texture = [_name]};
			[_vehicle, _texture, _name, []] call RPT_fnc_TextureVehicle;
			ctrlSetText [230, format ["%1 - (%2)", _text, _name]];
			paint_veh = 0;
			sleep 0.5;
		};
		sleep 0.5;
	};
	closeDialog 0;
};