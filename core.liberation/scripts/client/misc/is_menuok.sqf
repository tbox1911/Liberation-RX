params ["_vehicle"];
private _ret = false;

private _R3F_move = isNull R3F_LOG_joueur_deplace_objet;
private _alive = alive player;
private _onfoot = isNull objectParent player;
private _noflight = (isTouchingGround player || (round (getPosATL player select 2) <= 20));

if (_alive && _R3F_move && _noflight && build_confirmed == 0) then { // && _onfoot
	_ret = true;
};

if ( !isNil "_vehicle" ) then {
	if ( (uavControl _vehicle select 1 != "") || !alive _vehicle || !isNull ( _vehicle getVariable ["R3F_LOG_est_transporte_par", objNull]) ) then {
		_ret = false;
	};
};
_ret;
