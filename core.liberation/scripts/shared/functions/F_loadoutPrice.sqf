params [ "_unit" ];
if (isNull _unit) exitWith {0};

// item name MUST be lowercase
private _fixed_price = [
	//["launch_o_vorona_brown_f" , 200]
];

private _expensive_items = [
	"medikit",
	"toolkit",
	"srifle_dmr_02",
	"srifle_dmr_04",
    "srifle_dmr_05",
	"srifle_gm6",
	"srifle_lrr",
	"mmg_",
	"lmg_",
	"launch_o_vorona",
	"launch_b_titan",
	"launch_o_titan",
	"launch_i_titan",
	"titan_aa",
	"titan_at",
	"titan_ap",
	"vorona_he",
	"vorona_heat"
];

private _free_items = [
	"rnd_",
	"firstaidkit",
	"smokeshell",
	"grenade",
	"charge_remote_mag",
	"Laserbatteries",
	"chemlight",
	"ItemMap",
	"ItemGPS",
	"ItemRadio",
	"ItemCompass",
	"ItemWatch"
];

_fn_isfixed = {
	params ["_item"];
	private _ret = -1;
	{
		if (tolower (_item) find (_x select 0) >= 0) exitWith {_ret = _x select 1};
	} forEach _fixed_price;
	_ret;
};

_fn_isfree = {
	params ["_item"];
	private _ret = false;
	{
		if (tolower (_item) find _x >= 0) exitWith {_ret = true};
	} forEach _free_items;
	_ret;
};

_fn_isexpensive = {
	params ["_item"];
	private _ret = false;
	{
		if (tolower (_item) find _x >= 0) exitWith {_ret = true};
	} forEach _expensive_items;
	_ret;
};

_fn_getprice = {
	params ["_item"];
	private _ret = 0;

	if (isNil "_item") exitWith {0};
	_price = [_item] call _fn_isfixed;
	if (_price < 0) then {
		_isfree = [_item] call _fn_isfree;
		if (!_isfree) then {
			_isexpensive = [_item] call _fn_isexpensive;
			if (_isexpensive) then {_ret = 14} else {_ret = 3};
			if (_item isKindOf ["Pistol", configFile >> "CfgWeapons"]) then {
				if (_isexpensive) then {_ret = 12} else {_ret = 6};
			};
			if (_item isKindOf ["Rifle", configFile >> "CfgWeapons"]) then {
				if (_isexpensive) then {_ret = 28} else {_ret = 15};
			};
			if (_item isKindOf ["Launcher", configFile >> "CfgWeapons"]) then {
				if (_isexpensive) then {_ret = 55} else {_ret = 32};
			};
		};
	} else { _ret = _price };	
	//diag_log format ["DBG: %1 %2", _item, _ret];
	_ret;
};

private _val = 0;

if (_unit isKindOf "Man") then {
	if (count(handgunWeapon _unit) > 0 ) then {
		_val = _val + ([handgunWeapon _unit] call _fn_getprice);
	};

	if (count(primaryWeapon _unit) > 0 ) then {
		_val = _val + ([primaryWeapon _unit] call _fn_getprice);

		// Weapon items (scope,pointer,..)
		_weap_items = ([weaponsItems _unit, {(_x select 0) == (primaryWeapon _unit)}] call BIS_fnc_conditionalSelect) select 0;
		_weap_items deleteAt 0;
		_weap_items deleteAt 3;
		_val = _val + (3 * count ([_weap_items, {count _x > 1}] call BIS_fnc_conditionalSelect));
	};

	if (count(secondaryWeapon _unit) > 0 ) then {
		_val = _val + ([secondaryWeapon _unit] call _fn_getprice);
	};

	{
		_val = _val + ([_x] call _fn_getprice);
	} forEach (backpackItems _unit + vestItems _unit + uniformItems _unit) + (secondaryWeaponMagazine _unit) select 0;

	{
		if (_x != "") then {_val = _val + 5};
	} forEach [headgear _unit, hmd _unit, binocular _unit, vest _unit, uniform _unit, backpack _unit];

	// Player items (map,compass,..)
	_val = _val + (2 * count(assignedItems _unit));
};

if (_unit iskindof "LandVehicle") then {
	_weap_cargo = weaponCargo _unit;
	if (count _weap_cargo > 0) then {
		{
			_val = _val + ([_x] call _fn_getprice);
		} forEach _weap_cargo;
	};

	_item_cargo = itemCargo _unit;
	if (count _item_cargo > 0) then {
		{
			_val = _val + ([_x] call _fn_getprice);
		} forEach _item_cargo;
	};
};
_val;