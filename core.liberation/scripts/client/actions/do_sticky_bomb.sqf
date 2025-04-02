params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private _vehicle_class = typeOf _vehicle;
private _vehicle_name = [_vehicle_class] call F_getLRXName;
private _msg = format [localize "STR_STICKY_MSG_ASK", _vehicle_name];
private _result = [_msg, localize "STR_UI_WARNING_TITLE", true, true] call BIS_fnc_guiMessage;
if !(_result) exitWith {gamelogic globalChat localize "STR_STICKY_MSG_WISE"};

// find memory points
// cursorobject removeAllEventHandlers "HitPart";
// cursorobject addEventHandler ["HitPart", {_part=((_this select 0 select 5) select 0); systemchat _part; diag_log _part}];
private _vehicle_mempoints = [
	"door1",
	"door2",
	"damagehide",
	"light_r",
	"light_l",
	"light_r_end",
	"light_l_end",
	"dustfrontright",
	"dustfrontleft",
	"dustbackleft",
	"dustbackright"
];

private _player_explosives = (vestItems player + backpackItems player) select { _x in sticky_bombs_typename };
if (count _player_explosives == 0) exitWith {gamelogic globalChat localize "STR_STICKY_NO_CHARGE"};

disableUserInput true;
gamelogic globalChat format [localize "STR_STICKY_MSG_WIRE", _vehicle_name];
player setDir (player getDir _vehicle);
player playMove 'ainvpknlmstpslaywrfldnon_medic';
sleep 3;

private _bomb_type = _player_explosives select 0;
player removeItem _bomb_type;
private _bomb_ammo = getText(configfile >> "CfgMagazines" >> _bomb_type >> "ammo");
// _bomb_mag = getText(configfile >> "CfgAmmo" >> _bomb_ammo >> "defaultMagazine");
private _bomb = _bomb_ammo createVehicle zeropos;
_bomb attachTo [_vehicle, [0, 0, 0], selectRandom _vehicle_mempoints];
_bomb setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
sleep 3;
disableUserInput false;
disableUserInput true;
disableUserInput false;

private _actionId = -1;

_actionId = player addAction [
	format [localize "STR_STICKY_ACTION", _vehicle_name],
	{
		params ["_target", "_caller", "_actionId", "_vehicle"];
		_vehicle setDamage 1;
		_caller removeAction _actionId;
	}, _vehicle, 999, false, true, "", "true"
];

waitUntil {	sleep 1; isNull attachedTo _bomb };
player removeAction _actionId;
