params ["_max"];
private ["_HoF", "_msg", "_info"];

if (isNil "_max") then {
   	_max = 5;
	if (count GRLIB_player_scores < _max) then {
		_max =  count GRLIB_player_scores;
	};
};

_HoF=[];
{ _HoF pushback [(_x select 1),  (_x select 3)]} foreach GRLIB_player_scores;
_HoF sort false;

_msg = format ["<t color='#4BC9B0' shadow='2' size='1.75'>Hall of Fame</t><br/><t color='#777777'>------------------------------</t><br/><br/>"];

for [{_i=0}, {_i<_max}, {_i=_i+1}] do  {
    _msg = _msg + format ["<t color='#FFFFFF' size='1.0'>Name : <t color='#000080'>%1</t> -- Score : <t color='#008000'>%2</t></t><br/><br/>", (_HoF select _i) select 1, (_HoF select _i) select 0];
};
_info = [_msg, 0, 0, 10, 0, -2, 5];

_info;
