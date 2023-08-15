[] spawn {
	waituntil { sleep 1; !isNil "GRLIB_FOB_Group" };
	while {true} do {
		{
			if (typeOf _x == commander_classname && ((_x getVariable ["GRLIB_FOB_Action", -1]) < 0)) then {
				_x addAction ["<t color='#8FFF00'>" + localize "STR_SECONDARY_OBJECTIVES" + "</t> <img size='1' image='\A3\ui_f\data\map\markers\military\warning_CA.paa'/>","scripts\client\ui\secondary_ui.sqf","",995,false,true,"","call GRLIB_checkSecObj"];
				_x addAction ["<t color='#8FFF00'>" + localize "STR_SELL_CARGO" + "</t> <img size='1' image='res\ui_veh.paa'/>", "addons\SELL\do_sell.sqf","",994,true,true,"","", 5];
				_x addAction ["<t color='#8FFF00'>" + localize "STR_SAVE_PLAYER" + "</t> <img size='1' image='\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_saveas_ca.paa'/>",{[player] remoteExec ["save_context", 2]},"",993,true,true,"","GRLIB_player_is_menuok",5];
				_x setVariable ["GRLIB_FOB_Action", 1];
			};
		} forEach (units GRLIB_FOB_Group);
		sleep 10;
	};
};
waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- LRX FOB officer Initialized --------";