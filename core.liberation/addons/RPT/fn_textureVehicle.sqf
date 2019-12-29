
params ["_veh", "_texture", "_name", "_selections"];
private ["_textureSource"];

if (isNull _veh || count _texture == 0) exitWith {};

if (_name == "") then {_name = "Default"};
_veh setVariable ["GRLIB_vehicle_color", _texture, true];
_veh setVariable ["GRLIB_vehicle_color_name", _name, true];
_veh setVariable ["BIS_enableRandomization", false, true];
_textures = [];
scopeName "applyVehicleTexture";

// if _texture == ["string"], extract data from TextureSources config
if (_texture isEqualType [] && {_texture isEqualTypeAll ""}) then {
	_textureSource = _texture select 0;
	private _srcTextures = getArray (configFile >> "CfgVehicles" >> typeOf _veh >> "TextureSources" >> _textureSource >> "textures");

	if (_srcTextures isEqualTo []) exitWith { breakOut "applyVehicleTexture" };

	_texture = [];
	{ _texture pushBack [_forEachIndex, _x]	} forEach _srcTextures;
};

// Apply texture to all appropriate parts
if (_texture isEqualType "") then {
	if (count _selections == 0) then {
		_selections = switch (true) do {
			case (_veh isKindOf "Van_01_base_F"):                 { [0,1] };
			case (_veh isKindOf "Van_02_base_F"):                 { [0] };

			case (_veh isKindOf "MRAP_01_base_F"):                { [0,2] };
			case (_veh isKindOf "MRAP_02_base_F"):                { [0,1,2] };
			case (_veh isKindOf "MRAP_03_base_F"):                { [0,1] };

			case (_veh isKindOf "Truck_01_base_F"):               { [0,1,2] };
			case (_veh isKindOf "Truck_02_base_F"):               { [0,1] };
			case (_veh isKindOf "Truck_03_base_F"):               { [0,1,2,3] };

			case (_veh isKindOf "APC_Wheeled_01_base_F"):         { [0,2] };
			case (_veh isKindOf "APC_Wheeled_02_base_F"):         { [0,2] };
			case (_veh isKindOf "APC_Wheeled_03_base_F"):         { [0,2,3] };

			case (_veh isKindOf "APC_Tracked_01_base_F"):         { [0,1,2,3] };
			case (_veh isKindOf "APC_Tracked_02_base_F"):         { [0,1,2] };
			case (_veh isKindOf "APC_Tracked_03_base_F"):         { [0,1] };

			case (_veh isKindOf "MBT_01_base_F"):                 { [0,1,2] };
			case (_veh isKindOf "MBT_02_base_F"):                 { [0,1,2,3] };
			case (_veh isKindOf "MBT_03_base_F"):                 { [0,1,2] };
			case (_veh isKindOf "MBT_04_base_F"):                 { [0,1,2,3] };

			case (_veh isKindOf "Heli_Transport_01_base_F"):      { [0,1] };
			case (_veh isKindOf "Heli_Transport_02_base_F"):      { [0,1,2] };
			case (_veh isKindOf "Heli_Transport_03_base_F"):      { [0,1] };
			case (_veh isKindOf "Heli_Transport_04_base_F"):      { [0,1,2,3] };
			case (_veh isKindOf "Heli_Attack_02_base_F"):         { [0,1] };

			case (_veh isKindOf "VTOL_Base_F"):                   { [0,1,2,3] };
			case (_veh isKindOf "Plane_Fighter_04_Base_F"):       { [0,1,2] };
			case (_veh isKindOf "Plane"):                         { [0,1] };

			case (_veh isKindOf "UGV_01_rcws_base_F"):            { [0,2] };
			case (_veh isKindOf "UAV_03_base_F"):                 { [0,1] };

			case (_veh isKindOf "LSV_01_base_F"):                 { [0,2] };
			case (_veh isKindOf "LSV_02_base_F"):                 { [0,2] };

			default                                               { [0] };
		};
	};

	{
		_veh setObjectTextureGlobal [_x, _texture];
		[_textures, _x, _texture] call BIS_fnc_setToPairs;
	} forEach _selections;
} else {
	{
		_sel = _x select 0;
		_tex = _x select 1;

		_veh setObjectTextureGlobal [_sel, _tex];
		[_textures, _sel, _tex] call BIS_fnc_setToPairs;
	} forEach _texture;
};
