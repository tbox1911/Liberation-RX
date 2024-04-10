params ["_unit"];

if (isNil "_unit") exitWith {};
if (player getVariable ["GRLIB_action_inuse", false]) exitWith {};
if (_unit isKindOf "CAManBase") then {
	{ detach _x } forEach (attachedObjects _unit); 
};

private _result = true;
private _cost = GRLIB_AirDrop_Vehicle_cost;
if (_unit isKindOf "LandVehicle") then {
	if ( _unit isKindOf "Truck_F" ) then { _cost = _cost * 1.3 };
	if ( _unit isKindOf "Wheeled_APC_F" ) then { _cost = _cost * 1.7 };
	if ( _unit isKindOf "Tank_F" ) then { _cost = _cost * 2 };

	_result = [format [localize "STR_HALO_VEH_ASK", _cost], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
	if (_result) then {
		private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
		if (_cost > _ammo_collected) then {
			hintSilent localize "STR_GRLIB_NOAMMO";
			_result = false;
		};
	};
};
if (!_result) exitWith {};

if ( isNil "GRLIB_last_halo_jump" ) then { GRLIB_last_halo_jump = 0 };
if ( GRLIB_halo_param > 1 && ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) >= time ) exitWith {
	hint format [ localize "STR_HALO_DENIED_COOLDOWN", ceil ( ( ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) - time ) / 60 ) ];
};

createDialog "liberation_halo";
waitUntil { dialog };
dojump = 0;
halo_position = getPosATL _unit;

"spawn_marker" setMarkerTextLocal (localize "STR_HALO_PARAM");
if (_unit isKindOf "LandVehicle") then {
	"spawn_marker" setMarkerTextLocal (localize "STR_HALO_PARAM_VEH");
	ctrlSetText [202, (localize "STR_HALO_PARAM_VEH")];
};

["halo_map_event", "onMapSingleClick", { halo_position = _pos }] call BIS_fnc_addStackedEventHandler;
while { dialog && alive _unit && dojump == 0 } do {
	"spawn_marker" setMarkerPosLocal halo_position;
	sleep 0.2;
};
closeDialog 0;
["halo_map_event", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;

diag_log format [ "Airdrop %1 on %2 at %3", (typeOf _unit), halo_position, time ];
"spawn_marker" setMarkerPosLocal markers_reset;
"spawn_marker" setMarkerTextLocal "";

if ( dojump > 0 ) then {
	halo_position = halo_position getPos [floor(random 100), floor(random 360)];	
	if (_unit isKindOf "LandVehicle" || _unit isKindOf "Ship") then {
		// Vehicle HALO
		if ([_cost] call F_pay) then {
			titleText ["", "PLAIN"];
			sleep 1;
			for "_i" from 3 to 0 step -1 do {
				titleText [format ["Airdrop vehicle in %1 seconds", _i], "PLAIN"];
				sleep 1;
			};
			titleText ["", "PLAIN"];
			playSound "parasound";
			[player, _unit, halo_position] remoteExec ["airdrop_remote_call", 2];
			sleep 2;
			[halo_position, "parasound"] remoteExec ["sound_range_remote_call", 2];
		};
	} else {
		// Units HALO
		halo_position set [2, GRLIB_halo_altitude];
		GRLIB_last_halo_jump = round (time);
		halojumping = true;
		playSound "parasound";
		cutRsc ["fasttravel", "PLAIN", 1];
		sleep 2;
		[_unit, "hide"] remoteExec ["dog_action_remote_call", 2];

		private _units = units group _unit;
		private _my_squad = _unit getVariable ["my_squad", nil];
		if (!isNil "_my_squad") then { { _units pushBack _x } forEach units _my_squad };

		// Jump!
		player setVariable ["GRLIB_action_inuse", true, true];
		private _unit_list_halo = _units select {
			!(isPlayer _x) && (isNull objectParent _x) &&
			(_x distance2D player < 30) &&
			lifestate _x != 'INCAPACITATED'
		};

		[player, halo_position] spawn paraDrop;
		sleep 1;

		[halo_position, "parasound"] remoteExec ["sound_range_remote_call", 2];
		{
			[_x, halo_position] spawn paraDrop;
			sleep 1;
		} forEach _unit_list_halo;
		player setVariable ["GRLIB_action_inuse", false, true];
	};
};
