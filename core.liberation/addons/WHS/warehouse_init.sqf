{
	if (typeOf _x == WRHS_Man) then {
    	_x addAction ["<t color='#00F080'>" + "-- ENTER WAREHOUSE" + "</t> <img size='1' image='res\ui_recycle.paa'/>", "addons\WHS\warehouse.sqf","",-900,true,true,"","", 5];
	};
} forEach (units (group chimeraofficer));

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- LRX Warehouse Initialized --------";