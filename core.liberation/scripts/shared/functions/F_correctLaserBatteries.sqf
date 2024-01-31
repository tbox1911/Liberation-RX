params [ "_unit" ];

if (["Laserdesignator", binocular _unit] call BIS_fnc_inString ) then {
	if ( !("Laserbatteries" in (magazines _unit))) then {
		_unit addMagazine "Laserbatteries";
	};
};