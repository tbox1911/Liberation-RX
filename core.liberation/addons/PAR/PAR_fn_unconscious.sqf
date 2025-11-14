params ["_unit"];

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
[_unit, _unit] call PAR_fn_medicRelease;

if (_unit == player) then {
	disableUserInput true;
	private _carry = (attachedObjects _unit) select 0;
	if !(isNil "_carry") then {
		R3F_LOG_joueur_deplace_objet = objNull;
		_carry setVariable ["R3F_LOG_est_transporte_par", objNull, true];
		detach _carry;
	};
	private _mk1 = createMarkerLocal [format ["PAR_marker_%1", PAR_Grp_ID], getPosATL _unit];
	_mk1 setMarkerTypeLocal "loc_Hospital";
	_mk1 setMarkerTextLocal format ["%1 Injured", name _unit];
	_mk1 setMarkerColor "ColorRed";
	if ([_unit] call F_getScore > GRLIB_perm_log + 5) then { [_unit, -1] remoteExec ["F_addScore", 2] };
	if (GRLIB_disable_death_chat) then { for "_channel" from 0 to 4 do { _channel enableChannel false } };
	PAR_backup_loadout = [_unit] call F_getCargoUnit;
} else {
	_unit setVariable ["GRLIB_can_speak", false, true];
	[_unit] call F_deathSound;
};

waitUntil { sleep 0.1; isNull objectParent _unit };
sleep 3;
_unit switchMove "AinjPpneMstpSnonWrflDnon_rolltoback";
_unit playMoveNow "AinjPpneMstpSnonWrflDnon_rolltoback";
sleep 7;

if (_unit == player) then {
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
};

private _bld = [_unit] call PAR_spawn_blood;
private _cnt = 0;

while { alive _unit && ([_unit] call PAR_is_wounded) && time <= (_unit getVariable ["PAR_BleedOutTimer", 0])} do {
	if (_cnt == 0) then {
		_unit setOxygenRemaining 1;
		if ( {alive _x} count PAR_AI_bros > 0 ) then {
			if (isNil {_unit getVariable "PAR_myMedic"}) then {
				_unit groupchat localize "STR_PAR_UC_01";
				[_unit] call PAR_fn_medic;
			};
		} else {
			private _msg = format [localize "STR_PAR_UC_03", name player];
			if ([player] call PAR_is_wounded) then {
				_msg = format [localize "STR_PAR_UC_02", name player];
			};
			private _last_msg = player getVariable ["PAR_last_message", 0];
			if (time > _last_msg) then {
				[_unit, _msg] call PAR_fn_globalchat;
				player setVariable ["PAR_last_message", round(time + 20)];
			};
		};
		//systemchat str ((_unit getVariable ["PAR_BleedOutTimer", 0]) - time);
		_cnt = 10;
	};
	_cnt = _cnt - 1;
	sleep 1;
};

if (!isNull _bld) then { _bld spawn {sleep (30 + floor(random 30)); deleteVehicle _this} };

if (_unit == player) then {
	deletemarker format ["PAR_marker_%1", PAR_Grp_ID];
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
