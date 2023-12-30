params ["_vehicle"];

if (isNull _vehicle) exitWith {};

// Tracted
private _tractor = _vehicle getVariable ["R3F_LOG_est_transporte_par", objNull];
if (!isNull _tractor) exitWith {
	_vehicle setVariable ["R3F_LOG_est_transporte_par", objNull, true];
	_tractor setVariable ["R3F_LOG_remorque", objNull, true];
	detach _vehicle;
	_vehicle setVelocity [0, 0, 0.1];
};

// Tractor
private _tracted = _vehicle getVariable ["R3F_LOG_remorque", objNull];
if (!isNull _tracted) exitWith {
	_tracted setVariable ["R3F_LOG_est_transporte_par", objNull, true];
	_vehicle setVariable ["R3F_LOG_remorque", objNull, true];
	detach _tracted;
	_tracted setVelocity [0, 0, 0.1];
};
