params [ "_unit" ];

_expensive_items = [
	"Medikit",
	"ToolKit",
	"srifle_DMR_02",
	"srifle_DMR_04",
	"srifle_GM6",
	"srifle_LRR",
	"MMG_",
	"LMG_",
	"launch_O_Vorona",
	"launch_B_Titan",
	"launch_O_Titan",
	"launch_I_Titan",
	"Titan_AA",
	"Titan_AT",
	"Titan_AP",
	"Vorona_HE",
	"Vorona_HEAT"
];

_free_items = [
	"Rnd_",
	"FirstAidKit",
	"SmokeShell",
	"Grenade",
	"Charge_Remote_Mag",
	"Chemlight"
];

_fn_isfree = {
	params ["_item"];
	_ret = false;
	{
		if (_item find _x >= 0) exitWith {_ret = true};
	} forEach _free_items;
	_ret;
};

_fn_isexpensive = {
	params ["_item"];
	_ret = false;
	{
		if (_item find _x >= 0) exitWith {_ret = true};
	} forEach _expensive_items;
	_ret;
};

private _val = 0;

if (!isNull _unit) then {
	if (count(handgunWeapon _unit) > 0 ) then {_val = _val + 6};
	if (count(primaryWeapon _unit) > 0 ) then {_val = _val + 15};
	if (count(secondaryWeapon _unit) > 0 ) then {_val = _val + 32};
	if (count(backpack _unit) > 0 ) then {_val = _val + 5};

	{
		_item = _x;
		_isfree = [_item] call _fn_isfree;

		if (!_isfree) then {
			_isexpensive = [_item] call _fn_isexpensive;
			if (_isexpensive) then {_val = _val + 14} else {_val = _val + 5};
		};
	} forEach (backpackItems _unit + vestItems _unit + uniformItems _unit) + (secondaryWeaponMagazine _unit) select 0;

	{
		if (_x != "") then {_val = _val + 5};
	} forEach [headgear _unit, hmd _unit, binocular _unit];

	_val = _val + (2 * count(assignedItems _unit));

	{
		if (count _x > 2) then {
			_val = _val + 3;
		};
	} foreach (([weaponsItems _unit, {(_x select 0) == (primaryWeapon _unit)}] call BIS_fnc_conditionalSelect) select 0);

	// Extra-cost
	if ( [primaryWeapon _unit] call _fn_isexpensive || [secondaryWeapon _unit] call _fn_isexpensive) then {_val = _val + 53};
};
_val;