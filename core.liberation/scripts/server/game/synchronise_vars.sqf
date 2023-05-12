waitUntil{ !isNil "save_is_loaded" };
waitUntil{ !isNil "combat_readiness" };
waitUntil{ !isNil "unitcap" };
waitUntil{ !isNil "resources_intel" };

while { true } do {
	publicVariable "unitcap";
	publicVariable "combat_readiness";
	publicVariable "resources_intel";
	sleep 2;
};