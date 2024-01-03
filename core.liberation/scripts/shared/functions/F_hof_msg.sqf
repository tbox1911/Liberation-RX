params ["_max"];

if (isNil "_max") then {
   	_max = 5;
	if (count GRLIB_player_scores < _max) then {
		_max = count GRLIB_player_scores;
	};
};

private _HoF = [];
{ _HoF pushback [(_x select 1),  (_x select 4)]} foreach GRLIB_player_scores;
_HoF sort false;

private _msg = "<t color='#4BC9B0' shadow='2' size='1.75'>Hall of Fame</t><br/><t color='#777777'>------------------------------</t><br/><br/>";
for "_i" from 0 to _max do {
    _msg = _msg + format ["<t color='#FFFFFF' size='1.0'>Name : <t color='#000080'>%1</t> -- Score : <t color='#008000'>%2</t></t><br/><br/>", (_HoF select _i) select 1, (_HoF select _i) select 0];
};

[_msg, 0, -1, 10, 0, -2, 5];
