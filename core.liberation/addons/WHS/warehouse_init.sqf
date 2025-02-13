// LRX Warehouse - init

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

[] spawn {
	while {true} do {
		{
			if (_x getVariable ["GRLIB_WHS_Group", false] && isNil {_x getVariable "GRLIB_WHS_Action"}) then {
				(agent _x) addAction ["<t color='#00F080'>" + localize "STR_WAREHOUSE_ENTER" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\WHS\warehouse.sqf","",-900,true,true,"","", 5];
				_x setVariable ["GRLIB_WHS_Action", 1];
			};
		} forEach agents;
		sleep 10;
	};
};
waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- LRX Warehouse Initialized --------";