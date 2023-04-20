if (count (attachedObjects player) > 0) exitWith {};
if (player getVariable ["GRLIB_action_inuse", false]) exitWith {};

if ( isNil "GRLIB_last_halo_jump" ) then { GRLIB_last_halo_jump = 0 };

if ( GRLIB_halo_param > 1 && ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) >= time ) exitWith {
	hint format [ localize "STR_HALO_DENIED_COOLDOWN", ceil ( ( ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) - time ) / 60 ) ];
};

createDialog "liberation_halo";
waitUntil { dialog };
dojump = 0;
halo_position = getpos player;

[ "halo_map_event", "onMapSingleClick", { halo_position = _pos } ] call BIS_fnc_addStackedEventHandler;
"spawn_marker" setMarkerTextLocal (localize "STR_HALO_PARAM");

while { dialog && alive player && dojump == 0 } do {
	"spawn_marker" setMarkerPosLocal halo_position;
	sleep 0.2;
};
closeDialog 0;

"spawn_marker" setMarkerPosLocal markers_reset;
"spawn_marker" setMarkerTextLocal "";
[ "halo_map_event", "onMapSingleClick" ] call BIS_fnc_removeStackedEventHandler;

if ( dojump > 0 ) then {
	GRLIB_last_halo_jump = round (time);
	halojumping = true;
	cutRsc ["fasttravel", "PLAIN", 1];
	playSound "parasound";
	[player, "hide"] remoteExec ["dog_action_remote_call", 2];
	sleep 2;

	_player_pos = getPosATL player;
	_units = units group player;
	_my_squad = player getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then {
		{ _units pushBack _x } forEach units _my_squad;
	};

	halo_position = [ halo_position, floor(random 250), floor(random 360) ] call BIS_fnc_relPos;
	halo_position = [ halo_position select 0, halo_position select 1, GRLIB_halo_altitude ];

	[player, halo_position] spawn paraDrop;
	sleep 1;
	{
		if ( round (_x distance2D _player_pos) <= 30 && lifestate _x != 'INCAPACITATED' && vehicle _x == _x && !(isPlayer _x) ) then {
			[_x, halo_position] spawn paraDrop;
			sleep (1 + floor(random 3));
		};
	} forEach _units;
};
