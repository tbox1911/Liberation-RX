waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "combat_readiness"};
waitUntil {sleep 1; !isNil "resources_intel"};

private _blufor_sectors = [];

active_sectors = [];
publicVariable "active_sectors";

while { true } do {
	unitcap = { alive _x && (_x distance2D lhd) >= 200 } count (units GRLIB_side_friendly);
	opforcap = { alive _x && !(captive _x) } count (units GRLIB_side_enemy);
	civcap = { alive _x && (isNil {_x getVariable "GRLIB_vehicle_owner"})} count (units GRLIB_side_civilian);
	opfor_sectors = (sectors_allSectors - blufor_sectors);

	if !(blufor_sectors isEqualTo _blufor_sectors) then {
		_blufor_sectors = blufor_sectors;
		publicVariable "blufor_sectors";
	};

	publicVariable "unitcap";
	publicVariable "opforcap";
	publicVariable "combat_readiness";
	publicVariable "resources_intel";

	sleep 5;
	stats_playtime = stats_playtime + 5;	
};