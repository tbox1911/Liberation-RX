private [ "_dialog", "_backpack", "_backpackcontents" ];

if ( isNil "GRLIB_last_halo_jump" ) then { GRLIB_last_halo_jump = -6000; };

if ( GRLIB_halo_param > 1 && ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) >= time ) exitWith {
	hint format [ localize "STR_HALO_DENIED_COOLDOWN", ceil ( ( ( GRLIB_last_halo_jump + ( GRLIB_halo_param * 60 ) ) - time ) / 60 ) ];
};

_dialog = createDialog "liberation_halo";
dojump = 0;
halo_position = getpos player;

_backpackcontents = [];

[ "halo_map_event", "onMapSingleClick", { halo_position = _pos } ] call BIS_fnc_addStackedEventHandler;

"spawn_marker" setMarkerTextLocal (localize "STR_HALO_PARAM");

waitUntil { dialog };
while { dialog && alive player && dojump == 0 } do {
	"spawn_marker" setMarkerPosLocal halo_position;
	sleep 0.1;
};

if ( dialog ) then {
	closeDialog 0;
	sleep 0.1;
};

"spawn_marker" setMarkerPosLocal markers_reset;
"spawn_marker" setMarkerTextLocal "";

[ "halo_map_event", "onMapSingleClick" ] call BIS_fnc_removeStackedEventHandler;

ParaDrop = {
	params ["_unit", "_pos"];
	private [ "_backpack", "_backpackcontents" ];

	_backpack = backpack _unit;
	if ( _backpack != "" && _backpack != "B_Parachute" ) then {
		_backpackcontents = backpackItems _unit;
		removeBackpack _unit;
		sleep 0.1;
	};
	_unit addBackpack "B_Parachute";
	_unit setpos _pos vectorAdd [random [10,15,20], 0, 0];

	sleep 4;
	halojumping = false;
	//waitUntil { !alive _unit || isTouchingGround _unit };
	while {alive _unit && !isTouchingGround _unit} do {
		if ((getPosATL _unit) select 2 <= 50 && !(isPlayer _unit)) then {_unit allowDamage false};
		sleep 0.5;
	};
	removeBackpack _unit;
	sleep 0.1;
	if ( _backpack != "" && _backpack != "B_Parachute" ) then {
		_unit addBackpack _backpack;
		clearAllItemsFromBackpack _unit;
		{_unit addItemToBackpack _x} foreach _backpackcontents;
	};
	_unit allowDamage true;
	_unit doFollow leader player;
};

if ( dojump > 0 ) then {
	GRLIB_last_halo_jump = time;

	halojumping = true;
	cutRsc ["fasttravel", "PLAIN", 1];
	playSound "parasound";
	sleep 2;
	halo_position = [ halo_position, random 250, random 360 ] call BIS_fnc_relPos;
	halo_position = [ halo_position select 0, halo_position select 1, GRLIB_halo_altitude + (random 200) ];
	_player_pos = getPos player;
	{
		if ( round (_x distance2D _player_pos) <= 30 && lifestate _x != 'incapacitated' && vehicle _x == _x ) then {
			[_x,  halo_position] spawn ParaDrop;
			sleep random [1,1.5,2];
		};
	} forEach units player;
};
