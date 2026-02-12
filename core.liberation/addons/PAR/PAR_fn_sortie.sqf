params ["_wnded", "_medic"];

if !(local _wnded) exitWith { [_wnded, _medic] remoteExec ["PAR_remote_sortie", 2] };
if ((!alive _wnded) || (!alive _medic) || ([_medic] call PAR_is_wounded || !([_wnded] call PAR_is_wounded))) exitWith { [_medic, _wnded] call PAR_fn_medicRelease };

if (!isPlayer _medic) then {
	private _msg = format [localize "STR_PAR_ST_01", name _medic, name _wnded];
	[_medic, _msg] call PAR_fn_globalchat;
	private _bleedOut = _wnded getVariable ["PAR_BleedOutTimer", 0];
	_wnded setVariable ["PAR_BleedOutTimer", _bleedOut + PAR_bleedout_extra, true];
	_medic setDir (_medic getDir _wnded);
	private _stance = stance _medic;
	private _anim = "AinvPknlMstpSlayWrflDnon_medicOther";
	if (currentWeapon _medic == "") then { _anim = "AinvPknlMstpSlayWnonDnon_medicOther" };
	if (_stance == "PRONE") then {
		_anim = "AinvPpneMstpSlayWrflDnon_medicOther";
		if (currentWeapon _medic == "") then { _anim = "AinvPpneMstpSlayWnonDnon_medicOther" };
	};
	_medic switchMove _anim;
	_medic playMoveNow _anim;
	[_wnded] call PAR_spawn_gargbage;
	_cnt = 7;
	while { _cnt > 0 && (_wnded getVariable ["PAR_myMedic", objNull]) == _medic } do {
		sleep 1;
		_cnt = _cnt -1
	};
	if (_stance == "STAND") then { _medic playAction "PlayerStand" };
};

// Medic can't continue
private _my_medic = _wnded getVariable ["PAR_myMedic", objNull];
if (local _medic && !isNull _my_medic && _my_medic != _medic) exitWith { _medic switchMove ""; [_medic, _wnded] call PAR_fn_medicRelease };
if ((!alive _wnded) || (!alive _medic) || ([_medic] call PAR_is_wounded || !([_wnded] call PAR_is_wounded))) exitWith { [_medic, _wnded] call PAR_fn_medicRelease };

// Wounded Revived
if (PAR_revive == 2) then {
	_medic removeItem "FirstAidKit";
};

if (PAR_ai_revive_max > 0 && !isPlayer _wnded && local _wnded) then {
	[_wnded] spawn PAR_revive_dec;
};

if ([_medic] call PAR_is_medic) then {
	_wnded setDamage 0;
} else {
	_wnded setDamage 0.25;
};

_wnded setUnconscious false;
if (isPlayer _wnded || isPlayer _medic) then {
	_wnded setVariable ["PAR_isUnconscious", false, true];
	_wnded setVariable ["PAR_isDragged", 0, true];
};

_wnded switchMove "AinjPpneMstpSnonWrflDnon_rolltofront";
_wnded playMoveNow "AinjPpneMstpSnonWrflDnon_rolltofront";
sleep 2;
_wnded switchmove "AidlPpneMstpSnonWnonDnon_AI";

[_medic, _wnded] call PAR_fn_fixPos;

if (_wnded == player) then {
	group _wnded selectLeader _wnded;
	private _bounty_ok = (([(GRLIB_capture_size * 2), getPosATL _medic] call F_getNearestSector) in opfor_sectors && _medic getVariable ["PAR_lastRevive",0] < time);
	if (isPlayer _medic && _bounty_ok) then {
		private _bonus = 5;
		[_medic, _wnded, _bonus] remoteExec ["PAR_remote_bounty", 2];
	};
} else {
	_wnded setSpeedMode (speedMode group _wnded);
	_wnded doFollow _wnded;
};

_wnded setVariable ["PAR_isUnconscious", false, true];
_wnded setVariable ["PAR_isDragged", 0, true];
sleep 2;
[_medic, _wnded] call PAR_fn_medicRelease;
