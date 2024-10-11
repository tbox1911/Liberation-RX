params [ "_unit" ];

if (tolower (primaryWeapon _unit) find "_gl" > -1) then {	
	if ( !("1Rnd_HE_Grenade_shell" in (magazines _unit))) then {
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
		_unit addItem "1Rnd_HE_Grenade_shell";
	};
};