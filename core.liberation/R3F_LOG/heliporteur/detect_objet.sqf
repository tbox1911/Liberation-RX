private _vehicule_joueur = vehicle player;
private _objet_heliportable = (_vehicule_joueur nearEntities [["All"], 20]) select {
    _x != _vehicule_joueur && !(_x getVariable "R3F_LOG_disabled") &&
    (_x getVariable ["R3F_LOG_fonctionnalites", R3F_LOG_CST_zero_log] select R3F_LOG_IDX_can_be_lifted) &&
    ((getPosASL _vehicule_joueur select 2) - (getPosASL _x select 2) > 2 && (getPosASL _vehicule_joueur select 2) - (getPosASL _x select 2) < 15)
};

private _ret = false;
R3F_LOG_objet_heliporter = objNull;
if (count _objet_heliportable > 0) then {
    private _objet_sorted = _objet_heliportable apply {[_x distance2D _vehicule_joueur, _x]};
    _objet_sorted sort true;
    R3F_LOG_objet_heliporter = (_objet_sorted select 0 select 1);
    _ret = (
        !(_vehicule_joueur getVariable "R3F_LOG_disabled") && _pas_de_hook &&
        isNull (_vehicule_joueur getVariable "R3F_LOG_heliporte") && (vectorMagnitude velocity _vehicule_joueur < 6)
    );
    if (_ret) then {
        hintSilent format ["%1\n%2", STR_R3F_LOG_action_heliporter, [R3F_LOG_objet_heliporter] call F_getLRXName];
    };
};
_ret;