params ["_price", ["_fuel", 0]];

if (_price <= 0) exitWith {true};
if (player getVariable ["trx_complete", 0] == 1) exitWith {false};

// trx_complete
// 0 = no transaction
// 1 = transaction in progress
// 2 = success
// 3 = fail

private _ret = false;
private _msg = "";

player setVariable ["trx_complete", 1, true];
[player, _price, _fuel] remoteExec ["ammo_del_remote_call", 2];

private _timout = round (time + 3);
waitUntil {sleep 0.1; (player getVariable ["trx_complete", 1] > 1 || time > _timout)};

private _res = player getVariable ["trx_complete", 3];

if (_res == 2) then {
	playSound "taskSucceeded";
	_msg = format [localize "STR_GRLIB_PAY", _price];
	_ret = true;
};

if (_res == 3) then {
	_msg = localize "STR_GRLIB_NOAMMO";
};

player setVariable ["trx_complete", 0, true];

hintSilent _msg;
gamelogic globalChat _msg;

_ret;