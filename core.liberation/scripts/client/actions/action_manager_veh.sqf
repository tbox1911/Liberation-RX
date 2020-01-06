private _distveh = 15;
private _distvehclose = 5;

private _recycleable_classnames_exp = [
	"Land_Cargo_HQ_V1_ruins_F",
	"Land_Cargo_Tower_V1_ruins_F",
	"Land_Cargo_House_V1_ruins_F",
	"Land_Cargo_Patrol_V1_ruins_F"
];
private _recycleable_blacklist = [];
{_recycleable_blacklist pushBack ( _x select 0 )} foreach (static_vehicles);

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };
waituntil {sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};

while { true } do {
	// Vehicles actions
	_nearmyveh = [nearestObjects [player, ["LandVehicle","Air","Ship"], _distveh], {
		(_x distance lhd) >= 1000 &&
		!(typeOf _x in _recycleable_blacklist)
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		if (! (_vehicle getVariable ["GRLIB_vehicle_action", false]) ) then {

			_vehicle addAction ["<t color='#00DD00'>-- SELL CARGO --</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_sell.sqf","",-900,true,true,"","[_target] call is_menuok && [_target] call F_check_nearService && (locked _target == 0 || locked _target == 1) && [_this, _target] call is_owner", _distvehclose];
			_vehicle addAction ["<t color='#00F000'>-- REFUEL --</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_refuel.sqf","",-900,false,true,"","[_target] call is_menuok && (locked _target == 0 || locked _target == 1) && [_target] call F_check_nearFuel", _distvehclose];
			_vehicle addAction ["<t color='#FFFF00'>-- SALVAGE --</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_wreck.sqf","",-900,true,true,"","isNull R3F_LOG_joueur_deplace_objet && alive player && vehicle player == player && !(alive _target) && !(_target getVariable ['wreck_in_use', false])", _distveh];
			_vehicle addAction ["<t color='#FFFF00'>-- UNFLIP --</t> <img size='1' image='res\ui_flipveh.paa'/>","scripts\client\actions\do_unflip.sqf","",-900,true,true,"","[_target] call is_menuok && (vectorUp _target) select 2 < 0.70 ", _distveh];

			if (! (typeOf _vehicle in GRLIB_vehicle_blacklist)) then {
				_vehicle addAction ["<t color='#00FF00'>-- LOCK --</t> <img size='1' image='R3F_LOG\icons\r3f_lock.paa'/>","scripts\client\actions\do_lock.sqf","",-901,true,true,"","[_target] call is_menuok && (count (crew _target) == 0 || typeOf _target in uavs) && (locked _target == 0 || locked _target == 1)", _distvehclose];
				_vehicle addAction ["<t color='#FF0000'>-- UNLOCK --</t> <img size='1' image='R3F_LOG\icons\r3f_unlock.paa'/>","scripts\client\actions\do_unlock.sqf","",-902,true,true,"","[_target] call is_menuok && locked _target == 2 && [_this, _target] call is_owner", _distvehclose];
				_vehicle addAction ["<t color='#222222'>-- ABANDON --</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_abandon.sqf","",-903,true,true,"","[_target] call is_menuok && locked _target == 2 && [_this, _target] call is_owner", _distvehclose];
				_vehicle addAction ["<t color='#444444'>-- CLEAR CARGO --</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_clear.sqf","",-904,true,true,"","[_target] call is_menuok && locked _target == 2 && [_this, _target] call is_owner", _distvehclose];
				_vehicle addAction ["<t color='#00F0F0'>-- PAINT --</t> <img size='1' image='res\ui_veh.paa'/>", "addons\RPT\fn_repaintMenu.sqf","",-905,true,true,"","[_target] call is_menuok && locked _target == 2 && [_this, _target] call is_owner", _distvehclose];
				_vehicle addAction ["<t color='#0080F0'>-- EJECT CREW --</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_eject.sqf","",-906,false,true,"","[_target] call is_menuok && !(typeOf _target in uavs) && count (crew _target) > 0 && [_this, _target] call is_owner && vehicle _this == _this", _distvehclose];
			};
			_vehicle setVariable ["GRLIB_vehicle_action", true];
		};
	} forEach _nearmyveh;

	// Salvage Wreck & Ruins
	_nearruins = [nearestObjects [player, ["Ruins_F"], _distveh], {(_x distance lhd) >= 1000 && (typeof _x in _recycleable_classnames_exp)}] call BIS_fnc_conditionalSelect;
	_nearwreck = [nearestObjects [player, ["Slingload_01_Base_F"], _distveh], {(_x distance lhd) >= 1000 && !(alive _x)}] call BIS_fnc_conditionalSelect;
	{
		_vehicle = _x;
		if (! (_vehicle getVariable ["GRLIB_salvage_action", false]) ) then {
			_vehicle addAction ["<t color='#FFFF00'>-- SALVAGE --</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_wreck.sqf","",-900,true,true,"","[_target] call is_menuok && !(_target getVariable ['wreck_in_use', false])", _distveh];
			_vehicle setVariable ["GRLIB_salvage_action", true];
		};
	} forEach _nearwreck+_nearruins;
	sleep 2;
};
