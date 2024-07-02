waitUntil {sleep 1; !isNil "blufor_sectors" };
waitUntil {sleep 1; !isNil "combat_readiness" };

private _readiness = 0;
while { true } do {
	_readiness = 0.25;
	if (count blufor_sectors <= 5) then { _readiness = 0.45 };
	if (combat_readiness > 35) then { combat_readiness = combat_readiness - _readiness };
	if (combat_readiness < 0) then { combat_readiness = 0 };
	publicVariable "combat_readiness";
	sleep 200;
};