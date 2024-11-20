params ["_wnded", "_medic"];

if (isDedicated) exitWith {};
if !(local _wnded) exitWith { [_wnded, _medic] remoteExec ["PAR_remote_sortie", 2] };

if (lifeState _wnded != "INCAPACITATED" || (!alive _wnded)) exitWith { [_medic, _wnded] call PAR_fn_medicRelease };

if (!isPlayer _medic) then {
	private _msg = format [localize "STR_PAR_ST_01", name _medic, name _wnded];
	[_wnded, _msg] call PAR_fn_globalchat;
	private _bleedOut = _wnded getVariable ["PAR_BleedOutTimer", 0];
	_wnded setVariable ["PAR_BleedOutTimer", _bleedOut + PAR_bleedout_extra, true];
	_medic setDir (_medic getDir _wnded);
	if (stance _medic == "PRONE") then {
		_medic switchMove "AinvPpneMstpSlayWrflDnon_medicOther";
		_medic playMoveNow "AinvPpneMstpSlayWrflDnon_medicOther";
	} else {
		_medic switchMove "AinvPknlMstpSlayWrflDnon_medicOther";
		_medic playMoveNow "AinvPknlMstpSlayWrflDnon_medicOther";
	};
	[_wnded] call PAR_spawn_gargbage;
	_cnt = 6;
	while { _cnt > 0 && (_wnded getVariable ["PAR_myMedic", objNull] == _medic) } do {
		sleep 1;
		_cnt = _cnt -1
	};
};

if (lifeState _medic == "INCAPACITATED" || (!alive _wnded)) exitWith { [_medic, _wnded] call PAR_fn_medicRelease };

// Revived
if (PAR_revive == 2) then {
	_medic removeItem "FirstAidKit";
};

if (PAR_ai_revive > 0 && !isPlayer _wnded && local _wnded) then {
	[_wnded] spawn PAR_revive_max;
};

if ([_medic] call PAR_is_medic) then {
	_wnded setDamage 0;
} else {
	_wnded setDamage 0.25;
};

_wnded setUnconscious false;
_wnded setVariable ["PAR_isUnconscious", false, true];
_wnded setVariable ["PAR_isDragged", 0, true];

_wnded switchMove "AinjPpneMstpSnonWrflDnon_rolltofront";
_wnded playMoveNow "AinjPpneMstpSnonWrflDnon_rolltofront";
sleep 2;
_wnded switchmove "AidlPpneMstpSrasWrflDnon_G01";

[_medic, _wnded] call PAR_fn_medicRelease;
[[_medic, _wnded]] call PAR_fn_fixPos;

if (_wnded == player) then {
	group _wnded selectLeader _wnded;
	private _opfor_sectors = (sectors_allSectors - blufor_sectors);
	private _bounty_ok = (([(GRLIB_capture_size * 2), getPosATL _medic] call F_getNearestSector) in _opfor_sectors && _medic getVariable ["PAR_lastRevive",0] < time);
	if (isPlayer _medic && _bounty_ok) then {
		private _bonus = 5;
		[_medic, _wnded, _bonus] remoteExec ["PAR_remote_bounty", 2];
	};
} else {
	_wnded setSpeedMode (speedMode group player);
	_wnded doFollow player;
};

[_wnded] spawn {
	params ["_unit"];
	sleep 10;   //time to recover
	_unit setVariable ["PAR_wounded", false, true];
	_unit allowDamage true;
	_unit setCaptive false;
};
