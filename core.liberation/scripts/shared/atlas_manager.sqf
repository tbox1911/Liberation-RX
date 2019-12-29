if ( isServer ) then {
	lhd setpos getmarkerpos "base_chimera";
	lhd hideObject true;
	{ deleteVehicle _x } foreach ( ( getmarkerpos "lhd" ) nearObjects 500 );
	GRLIB_isAtlasPresent = false;
	publicVariable "GRLIB_isAtlasPresent";
} else {
	waitUntil {sleep 1; !isNil "GRLIB_isAtlasPresent" };
};

if ( GRLIB_isAtlasPresent ) then {
	deleteMarkerLocal "base_chimera";
} else {
	deleteMarkerLocal "lhd";
};