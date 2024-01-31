params ["_projectile"];
if (isNull _projectile) exitWith {};

private _vehicle = cursorObject;
if (typeOf _vehicle in sticky_bombs_typename && !(isNull attachedTo _vehicle)) then {
	_vehicle = attachedTo _vehicle;
};
if (!(_vehicle iskindof "LandVehicle" || _vehicle iskindof "Air" || _vehicle iskindof "Ship")) exitWith {};

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
	"dustbackright",
	"wheel_1_1_hide",
	"wheel_1_2_hide",
	"wheel_2_1_hide",
	"wheel_2_2_hide"
];

private _vehicle_name = [typeOf _vehicle] call F_getLRXName;
private _bomb_count = ({typeOf _x in sticky_bombs_typename} count (attachedObjects _vehicle)) + 1;
gamelogic globalChat format ["Wire bomb #%1 to %2.", _bomb_count, _vehicle_name];

disableUserInput true;
player playMoveNow "AinvPknlMstpSlayWnonDnon_medic";
sleep 3;
_projectile attachTo [_vehicle, [0, 0, 0], selectRandom _vehicle_mempoints];
_projectile setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
sleep 3;
disableUserInput false;
disableUserInput true;
disableUserInput false;

if (_bomb_count == 1) then {
	private _actionId = player addAction [
		format ["Blow bombs in: <t color='#F88000'>%1</t> !!", _vehicle_name],
		{
			params ["_target", "_caller", "_actionId", "_bomb"];
			if (!isNull _bomb) then {
				{
					detach _x;
					sleep 0.1;
					_x setDamage 1;
				} foreach attachedObjects (attachedTo _bomb);
			};
			_caller removeAction _actionId;
		}, _projectile, 6, false, true
	];
	_vehicle setVariable ["GRLIB_vehicle_bomb_id", _actionId];
};

waitUntil {	sleep 1; isNull attachedTo _projectile };

_bomb_count = {typeOf _x in sticky_bombs_typename} count (attachedObjects _vehicle);
if (_bomb_count == 0) then {
	_id = _vehicle getVariable ["GRLIB_vehicle_bomb_id", nil];
	if (!isNil "_id") then {
		player removeAction _id;
		_vehicle setVariable ["GRLIB_vehicle_bomb_id", nil];
	};
};
