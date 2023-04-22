[] spawn {
	waituntil { sleep 1; !isNil "GRLIB_WHS_Group" };
	while {true} do {
		{
			if (typeOf _x == WRHS_Man && ((_x getVariable ["GRLIB_WHS_Action", -1]) < 0)) then {
				_idact =_x addAction ["<t color='#00F080'>" + localize "STR_WAREHOUSE_ENTER" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\WHS\warehouse.sqf","",-900,true,true,"","", 5];
				_x setVariable ["GRLIB_WHS_Action", _idact];
			};
		} forEach (units GRLIB_WHS_Group);
		sleep 10;
	};
};
waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- LRX Warehouse Initialized --------";