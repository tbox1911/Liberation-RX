params ["_transport", "_driver", "_dest"];

private _timeout = [_transport, _driver, _dest] call ai_logistic_dest;
if (_timeout) exitWith { [_driver, "collect"] call ai_logistic_failed };
[_transport] call ai_logistic_unload;
