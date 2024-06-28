params [[ "_source_position", (getPos player)]];

private _fob_type = -1;
private _fob_sign = _source_position nearObjects [FOB_sign, 20] select 0;
if (!isNil "_fob_sign") then {
	private _fob_class = _fob_sign getVariable ["GRLIB_fob_type", FOB_typename];
	switch (_fob_class) do {
		case FOB_typename: { _fob_type = 0 };
		case FOB_outpost:  { _fob_type = 1 };
		case FOB_carrier:  { _fob_type = 2 };
		default {};
	};
};

_fob_type;
