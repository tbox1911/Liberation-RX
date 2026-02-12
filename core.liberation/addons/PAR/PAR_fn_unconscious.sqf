params ["_unit"];

if (GRLIB_ACE_medical_enabled) exitWith {};
if (rating _unit < -2000) exitWith {_unit setDamage 1};
if (!([] call F_getValid)) exitWith {_unit setDamage 1};
private _cur_revive = 1;
if (PAR_ai_revive_max > 0 && !isPlayer _unit && local _unit) then {
	_cur_revive = ([_unit] call PAR_revive_cur);
};
if (_cur_revive <= 0) exitWith {_unit setDamage 1};

_unit allowDamage false;
_unit setUnconscious true;
_unit setCaptive true;
_unit setVariable ["PAR_busy", nil];
_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_bleedout), true];
_unit setVariable ["PAR_isDragged", 0, true];

if (_unit == player) then {
	if ([_unit] call F_getScore > GRLIB_perm_log + 5) then { [_unit, -1] remoteExec ["F_addScore", 2] };
	if (GRLIB_disable_death_chat) then { for "_channel" from 0 to 4 do { _channel enableChannel false } };
	PAR_backup_loadout = [_unit] call F_getCargoUnit;
} else {
	_unit setVariable ["GRLIB_can_speak", false, true];
	[_unit] spawn F_deathSound;
};
[_unit, _unit] call PAR_fn_medicRelease;

waitUntil { sleep 0.1; isNull objectParent _unit };
sleep 3;
_unit switchMove "AinjPpneMstpSnonWrflDnon_rolltoback";
_unit playMoveNow "AinjPpneMstpSnonWrflDnon_rolltoback";
sleep 7;

private _bld = [_unit] call PAR_spawn_blood;

while { alive _unit && ([_unit] call PAR_is_wounded) && time <= (_unit getVariable ["PAR_BleedOutTimer", 0])} do {
	_unit setOxygenRemaining 1;
	if ( {!([_x] call PAR_is_wounded)} count PAR_AI_bros > 0 ) then {
		if (isNil {_unit getVariable "PAR_myMedic"}) then {
			_msg = localize "STR_PAR_UC_01";
			[_unit, _msg] call PAR_fn_globalchat;
			[_unit] call PAR_fn_medic;
		};
	} else {
		private _msg = format [localize "STR_PAR_UC_03", name player];
		if ([player] call PAR_is_wounded) then {
			_msg = format [localize "STR_PAR_UC_02", name player];
		};
		[_unit, _msg] call PAR_fn_globalchat;
	};
	sleep 5;
};

if (!isNull _bld) then { _bld spawn {sleep (30 + floor(random 30)); deleteVehicle _this} };

if (_unit == player) then {
	if (GRLIB_disable_death_chat) then { for "_channel" from 0 to 4 do { _channel enableChannel true } };
};

// Bad end
if (time > _unit getVariable ["PAR_BleedOutTimer", 0]) exitWith {
	[(_unit getVariable ["PAR_myMedic", objNull]), _unit] call PAR_fn_medicRelease;
	_unit setDamage 1;
};

// Good end
if (_unit == player) then {
	(group _unit) selectLeader _unit;
	if (currentWeapon _unit != primaryWeapon _unit) then {
		if (PAR_weapons_state select 0 != "") exitWith { _unit selectWeapon PAR_weapons_state };
		if (primaryWeapon _unit != "") exitWith { _unit selectWeapon (primaryWeapon _unit) };
	};
} else {
	_unit setVariable ["GRLIB_can_speak", true, true];
	_unit setSpeedMode (speedMode group player);
	_unit doFollow player;
};

sleep 10;   //time to recover
_unit setCaptive false;
_unit allowDamage true;
