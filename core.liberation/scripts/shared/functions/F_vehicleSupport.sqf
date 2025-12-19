params ["_vehicle", "_type", "_cost"];

private _vehicle_name = [_vehicle] call F_getLRXName;
private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
private _timer = 0;
private _screenmsg = "";

private _fuel_cooldown = 5 * 60;
private _ammo_cooldown = 8 * 60;
private _repair_cooldown = 5 * 60;

// Repair
if (_type == 1) then {
    _timer = _vehicle getVariable ["GREUH_repair_timer", 0];
    if (_timer <= time) then {
    	if (_ammo_collected < _cost) exitWith { gamelogic globalChat format [localize "STR_REPAIR_NOAMMO", _vehicle_name] };
    	[_cost] call F_pay;
    	_vehicle setDamage 0;
    	_vehicle setVariable ["GREUH_repair_timer", round (time + _repair_cooldown)];  // min cooldown
    	_screenmsg = format ["%1\n%2 - %3", _vehicle_name, localize "STR_REPAIRING", "100%"];
    	titleText [_screenmsg, "PLAIN DOWN"];
    	hintSilent _screenmsg;
    } else {
        _screenmsg = format [localize "STR_REPAIR_COOLDOWN_LINE", _vehicle_name, round (_timer - time)];
        titleText [_screenmsg, "PLAIN DOWN"];
    };
};

// Rearm
if (_type == 2) then {
    _timer = _vehicle getVariable ["GREUH_rearm_timer", 0];
    if (_timer <= time) then {
        if (_ammo_collected < _cost) exitWith { gamelogic globalChat format [localize "STR_REARM_NOAMMO", _vehicle_name] };
        [_cost] call F_pay;
        _vehicle setVehicleAmmo 1;
        _vehicle setVariable ["GREUH_rearm_timer", round (time + _ammo_cooldown)];  // min cooldown
        _screenmsg = format [localize "STR_REARM_COST_LINE", _vehicle_name, localize "STR_REARMING", "100%", _cost];
        titleText [_screenmsg, "PLAIN DOWN"];
        hintSilent _screenmsg;
    } else {
        _screenmsg = format [localize "STR_REARM_COOLDOWN_LINE", _vehicle_name, round (_timer - time)];
        titleText [_screenmsg, "PLAIN DOWN"];
    };
};

// Refuel
if (_type == 3) then {
    _timer = _vehicle getVariable ["GREUH_refuel_timer", 0];
    if (_timer <= time) then {
        if (_ammo_collected < _cost) exitWith { gamelogic globalChat format [localize "STR_REFUEL_NOAMMO", _vehicle_name] };
        [_cost] call F_pay;
        _vehicle setFuel 1;
        _vehicle setVariable ["GREUH_refuel_timer", round (time + _fuel_cooldown)];  // min cooldown
        _screenmsg = format ["%1\n%2 - %3", _vehicle_name, localize "STR_REFUELING", "100%"];
        titleText [_screenmsg, "PLAIN DOWN"];
        hintSilent _screenmsg;
    } else {
        _screenmsg = format [localize "STR_REFUEL_COOLDOWN_LINE", _vehicle_name, round (_timer - time)];
        titleText [_screenmsg, "PLAIN DOWN"];
    };
};