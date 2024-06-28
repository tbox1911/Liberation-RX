private	["_vehicle", "_unit"];

private _searchradius = 20;
private _nearveh = [];
private _nearruins = [];
private _nearwreck = [];
private _nearboxes = [];
private _nearcargo = [];
private _neardead = [];
private _nearstatics = [];
private _nearsign = [];

private _wreck_class = [
	"Air",
	"Ship",
	"LandVehicle",
	"StaticWeapon",
	"Slingload_01_Base_F",
	"Pod_Heli_Transport_04_base_F",
	"Land_RepairDepot_01_base_F",
	"B_AAA_System_01_F",
	"B_SAM_System_02_F",
	"O_SAM_System_04_F"
];

[] call compile preprocessFileLineNumbers "scripts\client\actions\action_manager_veh_check.sqf";

waituntil { sleep 1; !isNil "GRLIB_player_near_lhd"};
waituntil { sleep 1; GRLIB_player_spawned && (player getVariable ["GRLIB_score_set", 0] == 1)};
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

while { true } do {
	// Vehicles actions
	_nearveh = (player nearEntities [["LandVehicle","Air","Ship"], _searchradius]) select {
		(_x distance2D lhd > GRLIB_fob_range) &&
		!(typeOf _x in list_static_weapons) &&
		isNil {_x getVariable "GRLIB_vehicle_action"}
	};

	{
		_vehicle = _x;
		GRLIB_ActionDist_5 = 5;
		if ([_vehicle, vehicle_big_units] call F_itemIsInClass) then {
			GRLIB_ActionDist_5 = GRLIB_ActionDist_5 * 3;
		};
		_vehicle addAction ["<t color='#00AA00'>" + localize "STR_MAN_MANAGER" + "</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>","scripts\client\actions\do_speak.sqf","",-504,false,true,"","[_target, _this] call GRLIB_checkAction_Speak", GRLIB_ActionDist_5];
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_UN_FLIP" + "</t> <img size='1' image='res\ui_flipveh.paa'/>","scripts\client\actions\do_unflip.sqf","",-505,false,true,"","[_target, _this] call GRLIB_checkAction_Flip", GRLIB_ActionDist_10];
		_vehicle addAction ["<t color='#900000'>" + localize "STR_DE_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_defuel.sqf","",-506,false,true,"","[_target, _this] call GRLIB_checkAction_DeFuel", GRLIB_ActionDist_5];
		_vehicle addAction ["<t color='#009000'>" + localize "STR_RE_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_refuel.sqf","",-506,false,true,"","[_target, _this] call GRLIB_checkAction_ReFuel", GRLIB_ActionDist_5];
		_vehicle addAction ["<t color='#009000'>" + localize "STR_HALO_VEH" + "</t> <img size='1' image='res\ui_redeploy.paa'/>", "scripts\client\spawn\do_halo.sqf","",-507,false,true,"","[_target, _this] call GRLIB_checkAction_Halo", GRLIB_ActionDist_10];

		if (!([_vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) && !([_vehicle] call is_public)) then {
			_vehicle addAction ["<t color='#00FF00'>" + localize "STR_LOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lock.paa'/>","scripts\client\actions\do_lock.sqf","",-504,false,true,"","[_target, _this] call GRLIB_checkAction_Lock", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#FF0000'>" + localize "STR_UNLOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_unlock.paa'/>","scripts\client\actions\do_unlock.sqf","",-504,true,true,"","[_target, _this] call GRLIB_checkAction_Unlock", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#555555'>" + localize "STR_ABANDON" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_abandon.sqf","",-505,false,true,"","[_target, _this] call GRLIB_checkAction_Abandon", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#00F0F0'>" + localize "STR_PAINT" + " (VAM)</t> <img size='1' image='res\ui_veh.paa'/>", "addons\VAM\fn_repaintMenu.sqf","",-506,false,true,"","[_target, _this] call GRLIB_checkAction_Paint", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#0080F0'>" + localize "STR_EJECT_CREW" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_eject.sqf","",-500,false,true,"","[_target, _this] call GRLIB_checkAction_Eject", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#0080F0'>" + localize "STR_SEND_ARSENAL" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\add_personal_arsenal.sqf","",-508,false,true,"","[_target, _this] call GRLIB_checkAction_SendArsenal", GRLIB_ActionDist_5];
		};

		if (maxLoad _vehicle > 1500) then {
			_vehicle addAction ["<t color='#00FFFF'>" + localize "STR_ARSENAL_PICKUP" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\do_loot_veh.sqf","",-502,false,true,"","[_target, _this] call GRLIB_checkAction_Pickup_Weapons", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#00FFFF'>" + localize "STR_INVENTORY_UNPACK" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\unpack_inventory.sqf","",-503,false,true,"","[_target, _this] call GRLIB_checkAction_UnpackInventory", GRLIB_ActionDist_5];
		};

		if (typeOf _vehicle in transport_vehicles) then {
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_BOX" + "</t>","scripts\client\ammoboxes\do_unload_truck.sqf","",-500,false,true,"","[_target, _this] call GRLIB_checkAction_Unload", GRLIB_ActionDist_10];
		};

		_vehicle setVariable ["GRLIB_vehicle_action", true];
	} forEach _nearveh;

	// Salvage Wreck & Ruins
	_nearruins = (nearestObjects [player, ["Ruins_F"], _searchradius]) select {(getObjectType _x >= 8) && ([_x, "FOB", GRLIB_sector_size] call F_check_near) && isNil {_x getVariable "GRLIB_salvage_action"}};
	_nearwreck = (nearestObjects [player, _wreck_class, _searchradius]) select {(getObjectType _x >= 8) && !([_x, "LHD", GRLIB_sector_size, false] call F_check_near) && !(alive _x) && isNil {_x getVariable "GRLIB_salvage_action"}};
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_SALVAGE" + "</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_wreck.sqf","",-900,true,true,"","[_target, _this] call GRLIB_checkAction_Wreck", (GRLIB_ActionDist_10 + 5)];
		_vehicle setVariable ["GRLIB_salvage_action", true];
	} forEach _nearwreck + _nearruins;

	// Box
	_nearboxes = (player nearEntities [box_transport_loadable, _searchradius]) select { isNil {_x getVariable "GRLIB_boxes_action"} };
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_LOAD_BOX" + "</t>","scripts\client\ammoboxes\do_load_box.sqf","",-501,true,true,"","[_target, _this] call GRLIB_checkAction_Box", GRLIB_ActionDist_5];
		_vehicle setVariable ["GRLIB_boxes_action", true];
	} forEach _nearboxes;

	// Dead Men
	_neardead = allDeadMen select {!([_x, "LHD", GRLIB_sector_size, false] call F_check_near) && (_x distance2D player < _searchradius) && isNil {_x getVariable "GRLIB_dead_action"}};
	{
		_unit = _x;
		_unit addAction ["<t color='#0080F0'>" + localize "STR_REMOVE_BODY" + "</t>",{ [_this select 0] remoteExec ["hidebody", 0]},"",100,false,true,"","", GRLIB_ActionDist_3];
		_unit addAction ["<t color='#00F0F0'>" + localize "STR_LOOT_BODY" + "</t>","scripts\client\actions\do_loot.sqf","",101,false,true,"","(loadAbs _target > 120)",GRLIB_ActionDist_3];
		_unit setVariable ["GRLIB_dead_action", true];
	} forEach _neardead;

	// Neutralize Static
	_nearstatics = (player nearEntities ["StaticWeapon", _searchradius]) select { _x getVariable ["GRLIB_vehicle_owner", ""] == "server" && isNil {_x getVariable "GRLIB_static_action"} };
	{
		_unit = _x;
		[
			_x,
			"<t color='#FFFF00'>" + localize "STR_NEUTRALIZE" + "</t>",
			"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa",
			"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa",
			"!(isActionMenuVisible) && alive _target && _this distance2D _target < 3 && count (crew _target) == 0",
			"_caller distance2D _target < 3 && count (crew _target) == 0",
			{ },
			{ },
			{ 
				_target setVariable ["GRLIB_last_killer", nil, true];
				[_target, player, player] remoteExec ["kill_manager", 2];
				sleep 1;
				_target setDamage 1;
			},
			{ },
			[],
			20,
			12,
			true,
			false
		] call BIS_fnc_holdActionAdd;
		_unit setVariable ["GRLIB_static_action", true];
	} forEach _nearstatics;

	// FOB Sign Actions
	_nearsign = (nearestObjects [player, [FOB_sign], _searchradius]) select { (GRLIB_player_near_lhd || GRLIB_player_near_fob) && isNil {_x getVariable "GRLIB_sign_action"} };
	{
		_unit = _x;
		_unit addAction ["<t color='#00FF8F'>" + localize "STR_BUILD_FORTIFICATION" + "</t> <img size='1' image='res\ui_build.paa'/>","addons\FOB\do_build_def.sqf","",997,false,true,"","call GRLIB_checkBuildDef", 5];
		_unit addAction ["<t color='#F80000'>" + localize "STR_CLEAR_FORTIFICATION" + "</t> <img size='1' image='res\ui_build.paa'/>","addons\FOB\do_clean_def.sqf","",996,false,true,"","call GRLIB_checkBuildDef", 5];
		_unit addAction ["<t color='#FFFFFF'>" + "-= Hall of Fame =-" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{([5] call F_notice_hof) spawn BIS_fnc_dynamicText},"",989,true,true,"","GRLIB_player_is_menuok",5];
		_unit addAction ["<t color='#FFFFFF'>" + localize "STR_READ_ME" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{createDialog "liberation_notice"},"",988,true,true,"","GRLIB_player_is_menuok",5];
		_unit addAction ["<t color='#FFFFFF'>" + localize "STR_TIPS" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{createDialog "liberation_tips"},"",987,true,true,"","GRLIB_player_is_menuok",5];
		_unit addAction ["<t color='#FFFFFF'>" + localize "STR_NEWS" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{([] call F_notice_news) spawn BIS_fnc_dynamicText},"",986,true,true,"","GRLIB_player_is_menuok",5];
		_unit addAction ["<t color='#FFFFFF'>" + localize "STR_METEO" + "</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/>",{([] call F_notice_weather) spawn BIS_fnc_dynamicText},"",985,true,true,"","GRLIB_player_is_menuok",5];
		_unit setVariable ["GRLIB_sign_action", true];
	} foreach _nearsign;

	sleep 3;
};
