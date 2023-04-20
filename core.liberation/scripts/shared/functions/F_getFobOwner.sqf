params [[ "_source_position", (getPosATL player)]];

private _fob_owner = "";
private _fob_sign = _source_position nearObjects [FOB_sign, 20] select 0;
if (!isNil "_fob_sign") then {
	_fob_owner = _fob_sign getVariable ["GRLIB_vehicle_owner", ""];
};

_fob_owner;
