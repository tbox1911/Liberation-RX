{
	if (typeOf _x == "B_RangeMaster_F") then {
    	_x addAction ["<t color='#00F080'>" + "-- ENTER WAREHOUSE" + "</t> <img size='1' image='res\ui_recycle.paa'/>", {_this remoteExec ["warehouse_update_remote_call", 2]},"",-900,true,true,"","", 5];
	};
} forEach (units (group chimeraofficer));
