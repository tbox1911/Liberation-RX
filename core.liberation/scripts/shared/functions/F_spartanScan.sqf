private [ "_spartans", "_spartan" ];

_spartans = [entities huron_typename, {(_x getVariable ["GRLIB_vehicle_ishuron", false])}] call BIS_fnc_conditionalSelect;
_spartan = objNull;
if ( count _spartans != 0 ) then { _spartan = _spartans select 0 };

_spartan
