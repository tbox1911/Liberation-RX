params ["_unit", "_vehicle"];

if (_vehicle iskindof "Steerable_Parachute_F") exitWith {};

waitUntil {sleep 0.2; (round (speed vehicle _vehicle) == 0 && (round(getPosATL _vehicle select 2) < 5)) || damage _vehicle > 0.8 || driver _vehicle == _unit };  // No eject when driving
[_unit, false] spawn F_ejectUnit;
