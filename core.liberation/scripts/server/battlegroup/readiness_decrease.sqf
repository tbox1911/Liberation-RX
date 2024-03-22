waitUntil {sleep 1; !isNil "blufor_sectors" };
waitUntil {sleep 1; !isNil "combat_readiness" };

while { true } do {
	if ( combat_readiness > 45 ) then {
		combat_readiness = combat_readiness - 0.25;
	};
	if ( combat_readiness < 0 ) then { combat_readiness = 0 };

	publicVariable "combat_readiness";
	sleep (45 + floor(random 45));
};