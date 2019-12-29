params [ "_unit" ];

if (["_gl", primaryWeapon _unit] call BIS_fnc_inString ) then {
	if ( !("1Rnd_HE_Grenade_shell" in (magazines _unit))) then {
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
	};
};