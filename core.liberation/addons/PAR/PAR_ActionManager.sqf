// PAR Player Actions Manager

if (PAR_revive == 0) exitWith {};
private ["_unit", "_wnded_list", "_id1", "_id2", "_id3"];
private _checkAction = {
	params ["_unit"];
	private _act = _unit getVariable ["PAR_isMenuActive", []];
	private _cnt = { _x in _act } count (actionIDs _unit);
	(_cnt < 3);
};

while {true} do {
	_wnded_list = (getPos player) nearEntities ["CAManBase", 30];
	_wnded_list = _wnded_list select {
		alive _x &&
		([_x] call PAR_is_wounded) &&
		([_x] call _checkAction) &&
		(isNull objectParent _x) &&
		(isNil {_x getVariable "PAR_busy"})
	};

	if (count _wnded_list > 0) then {
		{
			_unit = _x;
			_id1 = _unit addAction ["<t color='#C90000'>" + localize "STR_PAR_AC_02" + "</t>", "addons\PAR\PAR_fn_drag.sqf", ["action_drag"], 9, false, true, "", "alive _target && (_target getVariable ['PAR_isUnconscious', false]) && !PAR_isDragging", 3];
			_id2 = _unit addAction ["<t color='#C90000'>" + localize "STR_PAR_AC_03" + "</t>", { PAR_isDragging = false }, ["action_release"], 10, true, true, "", "PAR_isDragging"];
			_id3 = [
				_unit,
				"<t color='#00C900'>" + localize "STR_PAR_AC_01" + "</t>",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
				"
					(alive _target && _this distance _target <= 3) &&
					(_target getVariable ['PAR_isUnconscious', false]) &&
					(_target getVariable ['PAR_isDragged',0] == 0) &&
					(PAR_revive == 1 || [_this] call PAR_has_medikit || [_this] call PAR_is_medic)
				",
				"(alive _target && _caller distance _target < 3)",
				{
					[(_target getVariable ["PAR_myMedic", objNull]), _target] call PAR_fn_medicRelease;
					_target setVariable ["PAR_myMedic", _caller];
					private _msg = format [localize "STR_PAR_ST_01", name _caller, name _target];
					[_target, _msg] remoteExec ["PAR_fn_globalchat", 0];
					private _bleedOut = _target getVariable ["PAR_BleedOutTimer", 0];
					_target setVariable ["PAR_BleedOutTimer", _bleedOut + PAR_bleedout_extra, true];
					[_target] call PAR_spawn_gargbage;
					if (stance _caller == "PRONE") then {
						_caller switchMove "ainvppnemstpslaywrfldnon_medicother";
						_caller playMoveNow "ainvppnemstpslaywrfldnon_medicother";
					} else {
						_caller switchMove "ainvpknlmstpslaywrfldnon_medicother";
						_caller playMoveNow "ainvpknlmstpslaywrfldnon_medicother";
					};
				},
				{},
				{
					[_target, _caller] spawn PAR_fn_sortie;
				},
				{
					if (animationState _caller == "ainvppnemstpslaywrfldnon_medicother") then {
						_caller switchMove "amovppnemstpsraswrfldnon";
						_caller playMoveNow "amovppnemstpsraswrfldnon";
					} else {
						_caller switchMove "amovpknlmstpsraswrfldnon";
						_caller playMoveNow "amovpknlmstpsraswrfldnon";
					};
					[_caller, _target] call PAR_fn_medicRelease;
				},
				[time],6,12,false
			] call BIS_fnc_holdActionAdd;
			_unit setVariable ["PAR_isMenuActive", [_id1, _id2, _id3]];
			sleep 0.1;
		} forEach  _wnded_list;
	};

	sleep 5;
};
