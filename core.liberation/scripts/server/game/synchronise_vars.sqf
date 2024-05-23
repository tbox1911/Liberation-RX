waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "combat_readiness"};
waitUntil {sleep 1; !isNil "resources_intel"};

active_sectors = [];
while { true } do {
	unitcap = { alive _x && local _x && (_x distance2D lhd) >= 200 } count (units GRLIB_side_friendly);
	opforcap = { alive _x && local _x && !(captive _x) } count (units GRLIB_side_enemy);
	civcap = { alive _x && local _x && !(typeOf _x in [SHOP_Man, SELL_Man, WRHS_Man, commander_classname])} count (units GRLIB_side_civilian);
	opfor_sectors = (sectors_allSectors - blufor_sectors);
	stats_playtime = stats_playtime + 2;

	publicVariable "unitcap";
	publicVariable "opforcap";
	publicVariable "civcap";
	publicVariable "blufor_sectors";
	publicVariable "opfor_sectors";	
	publicVariable "combat_readiness";
	publicVariable "resources_intel";
	publicVariable "active_sectors";
	sleep 2;
};