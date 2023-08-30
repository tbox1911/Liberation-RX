params ["_vehicle"];

if (isNull _vehicle) exitWith {};

// Tracted
private _tractor = _vehicle getVariable ["R3F_LOG_est_transporte_par", objNull];;
if (!isNull _tractor) then {
	_vehicle setVariable ["R3F_LOG_est_transporte_par", objNull, true];
	_tractor setVariable ["R3F_LOG_remorque", objNull, true];
	[_vehicle, "detachSetVelocity", [0, 0, 0.1]] call R3F_LOG_FNCT_exec_commande_MP;
	//waitUntil { sleep 0.1; (isNull attachedTo _vehicle) };
};

// Tractor
private _tracted = _vehicle getVariable ["R3F_LOG_remorque", objNull];
if (!isNull _tracted) then {
	_tracted setVariable ["R3F_LOG_est_transporte_par", objNull, true];
	_vehicle setVariable ["R3F_LOG_remorque", objNull, true];
	[_tracted, "detachSetVelocity", [0, 0, 0.1]] call R3F_LOG_FNCT_exec_commande_MP;
	//waitUntil { sleep 0.1; (isNull attachedTo _vehicle) };
};
