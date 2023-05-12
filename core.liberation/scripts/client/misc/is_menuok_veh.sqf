params ["_vehicle"];

private _ret = GRLIB_player_is_menuok;
if (!_ret) exitWith { _ret };
if ( !isNil "_vehicle" ) then {
	//private _R3F_disable = _vehicle getVariable ["R3F_LOG_disabled", false];
	if ( (uavControl _vehicle select 1 != "") || !alive _vehicle || !isNull ( _vehicle getVariable ["R3F_LOG_est_transporte_par", objNull]) ) then {
		_ret = false;
	};
};
_ret;
