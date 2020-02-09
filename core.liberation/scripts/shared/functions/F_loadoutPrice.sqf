params [ "_unit", "_force" ];
if (isNil "_force") then {_force = false};

_expensive_items = [
	"srifle_DMR",
	"srifle_GM6",
	"srifle_LRR",
	"MMG_",
	"LMG_",
	"launch_O_Vorona",
	"launch_B_Titan",
	"launch_O_Titan",
	"launch_I_Titan"
];

_free_items = [
  "FirstAidKi",
  "SmokeShell",
  "Chemlight_",
  "1Rnd_Smoke",
  "3Rnd_Smoke"
 ];

private _val = 0;
if (!isNull _unit) then {
	if (count(handgunWeapon _unit) > 0 ) then {_val = _val + 6};
	if (count(primaryWeapon _unit) > 0 ) then {_val = _val + 15};
	if (count(secondaryWeapon _unit) > 0 ) then {_val = _val + 32};
	if (count(backpack _unit) > 0 ) then {_val = _val + 5};

	if (isPlayer _unit || _force) then {
		{
			if ((_free_items find (_x select [0,10])) == -1) then {
				_val = _val + 7;
			};
		} foreach (items _unit + magazines _unit);

		{
			if (_x != "") then {
				_val = _val + 5;
			};
		} forEach [headgear _unit, goggles _unit, hmd _unit, binocular _unit];

		{
			if (count _x > 2) then {
				_val = _val + 3;
			};
		} foreach (([weaponsItems _unit, {(_x select 0) == (primaryWeapon _unit)}] call BIS_fnc_conditionalSelect) select 0);

	};

	// Extra-cost
	{if (primaryWeapon _unit find _x >= 0 || secondaryWeapon _unit find _x >= 0) then {_val = _val + 53}} forEach _expensive_items;
};
_val;