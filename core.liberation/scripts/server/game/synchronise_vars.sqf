waitUntil{ !isNil "save_is_loaded" };
waitUntil{ !isNil "combat_readiness" };
waitUntil{ !isNil "resources_intel" };

while { true } do {
	unitcap = { alive _x && (_x distance2D lhd) >= 200 } count (units GRLIB_side_friendly);
	opforcap = { alive _x && !(captive _x) } count (units GRLIB_side_enemy);
	opfor_sectors = (sectors_allSectors - blufor_sectors);
	stats_playtime = stats_playtime + 5;

	publicVariable "unitcap";
	publicVariable "opforcap";	
	publicVariable "opfor_sectors";
	publicVariable "combat_readiness";
	publicVariable "resources_intel";
	sleep 5;
};