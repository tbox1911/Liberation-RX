private _ret = false;

private _alive = alive player;
private _onfoot = isNull objectParent player;
private _R3F_move = isNull R3F_LOG_joueur_deplace_objet;
private _noflight = (isTouchingGround player || getPos player select 2 <= 1);
private _notunnel = !(player getVariable ["SOG_player_in_tunnel", false]);

if (_alive && _onfoot && _R3F_move && _noflight && _notunnel && build_confirmed == 0) then {
	_ret = true;
};

_ret;
