params ["_target", "_caller", "_actionId", "_arguments"];

GRLIB_AI_logistic_continue = true;
[_target, _caller, _actionId, "CONTINUE"] execVM "scripts\client\actions\do_logistic.sqf";
