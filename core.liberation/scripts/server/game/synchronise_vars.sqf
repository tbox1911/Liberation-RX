waitUntil{ !isNil "save_is_loaded" };
waitUntil{ !isNil "combat_readiness" };
waitUntil{ !isNil "resources_intel" };

while { true } do {
	unitcap = { alive _x && local _x && (_x distance2D lhd) >= 200 } count (units GRLIB_side_friendly);
	opforcap = { alive _x && local _x && !(captive _x) } count (units GRLIB_side_enemy);
	civcap = { alive _x && local _x && !(typeOf _x in [SHOP_Man, SELL_Man, WRHS_Man, commander_classname])} count (units GRLIB_side_civilian);
	opfor_sectors = (sectors_allSectors - blufor_sectors);
	stats_playtime = stats_playtime + 5;

	publicVariable "unitcap";
	publicVariable "opforcap";
	publicVariable "civcap";
	publicVariable "opfor_sectors";
	publicVariable "combat_readiness";
	publicVariable "resources_intel";
	sleep 2;
};