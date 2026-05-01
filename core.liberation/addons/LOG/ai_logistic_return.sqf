params ["_transport", "_dest"];

private _driver = driver _transport;
private _timeout = [_transport, _dest] call ai_logistic_dest;
if (_timeout) exitWith { [_driver, "collect"] call ai_logistic_failed };
[_transport] call ai_logistic_unload;
