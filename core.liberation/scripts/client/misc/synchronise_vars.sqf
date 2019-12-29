one_synchro_done = false;
synchro_done = false;
waitUntil {sleep 1; !isNil "sync_vars" };

while { true } do {

	waitUntil {
		sleep 0.5;
		count sync_vars > 0;
	};
	resources_infantry = sync_vars select 0;
	resources_fuel = sync_vars select 1;
	infantry_cap = sync_vars select 2;
	fuel_cap = sync_vars select 3;
	unitcap = sync_vars select 4;
	combat_readiness = sync_vars select 5;
	resources_intel = sync_vars select 6;
	sync_vars = [];
	one_synchro_done = true;
	synchro_done = true;
};
