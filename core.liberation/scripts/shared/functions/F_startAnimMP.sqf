params ["_unit", "_anim"];

_unit switchMove "";
_unit disableAI "MOVE";
_unit disableAI "ANIM";
sleep 2;

_unit removeAllEventHandlers "AnimDone";
_unit addEventHandler [ "AnimDone", {
    params[ "_unit", "_anim" ];
    _unit switchMove _anim;
    _unit playMoveNow _anim; 
}];

sleep 1;
[_unit, _anim] remoteExec ["switchMove", 0];
[_unit, _anim] remoteExec ["playMoveNow", 0];
