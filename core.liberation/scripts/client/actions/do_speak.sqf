params ["_unit", "", "", ["_msg", 0]];

private _msgid = _unit getVariable ["GRLIB_civ_incd", 0];
if (_msgid > 0) then { _msg = _msgid };

[_unit, _msg] spawn speak_manager;
