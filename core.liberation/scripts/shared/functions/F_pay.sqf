params ["_price"];
_ret = false;

if (_price <= 0) exitWith {true};

private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
private _msg = "";

if (_ammo_collected < _price) then {
	_msg = localize "STR_GRLIB_NOAMMO";
} else {
	player setVariable ["GREUH_ammo_count", (_ammo_collected - _price), true];
	playSound "rearm";
	_msg = format [localize "STR_GRLIB_PAY", _price];
	stats_ammo_spent = stats_ammo_spent + _price; publicVariable "stats_ammo_spent";
	_ret = true;
};

hintSilent _msg;
gamelogic globalChat _msg;

_ret;