params ["_target", "_caller", "_actionId", "_arguments"];
PAR_isDragging = true;

_target attachTo [player, [0, 1.1, 0.092]];
_target setDir 180;
_target setVariable ["PAR_isDragged", 1, true];

player switchMove "AcinPknlMstpSrasWrflDnon";
sleep 1;

// Wait until release action is used
waitUntil {
	sleep 0.1;
	!alive player || player getVariable ["PAR_isUnconscious", 1] == 1 ||
	!alive _target || _target getVariable ["PAR_isUnconscious", 1] == 0 ||
	_target getVariable ["PAR_isDragged", 0] == 0 || lifeState _target != 'INCAPACITATED' ||
	!PAR_isDragging
};

if (!isNull _target && alive _target) then
{
	_target switchMove "AinjPpneMstpSnonWrflDnon";
	_target setVariable ["PAR_isDragged", 0, true];
	detach _target;
};

// Switch back to default animation
player switchMove "amovpknlmstpsraswrfldnon";
sleep 1;

// Handle release action
PAR_isDragging = false;