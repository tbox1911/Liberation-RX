params [ "_vehicle" ];

_expensive_items = [
	"launch_O_Vorona",
	"srifle_DMR",
	"srifle_GM6",
	"srifle_LRR",
	"LMG_Mk200",
	"MMG_0",
	"launch_B_Titan",
	"launch_O_Titan",
	"launch_I_Titan"
];

private _val = 0;
if (!isNull _vehicle) then {
	_weap_cargo = WeaponCargo _vehicle;
	if (count _weap_cargo > 0) then {
		{
			_weapon = _x;
			{if ( _weapon find _x >= 0) then {_val = _val + 17}} forEach _expensive_items;
			_val = _val + 12;
		} forEach _weap_cargo;
	};
};
_val;