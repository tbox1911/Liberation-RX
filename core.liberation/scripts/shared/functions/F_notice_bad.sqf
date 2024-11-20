private _leadingzero_hour = "";
private _leadingzero_minute = "";
if ( (date select 3) < 10 ) then { _leadingzero_hour = "0" };
if ( (date select 4) < 10 ) then { _leadingzero_minute = "0" };

private _datestring = format ["<t color='#0000A0'>%1%2:%3%4</t>", _leadingzero_hour, date select 3, _leadingzero_minute, date select 4];
private _msg = format ["<t color='#4BC9B0' shadow='2' size='1.75'>The Fuckers</t><br/>"];
_msg = _msg + "<t color='#777777'>------------------------------</t><br/>";
_msg = _msg + format ["Worst Civilian relation on <t color='#008000'>%1</t> at %2<br/><br/>", worldname, _datestring];

private _HoF = [];
private _rep = 0;
{
    _rep = (_x select 4);
    if (_rep < 0) then { _HoF pushback [_rep,  (_x select 5)] };
} foreach GRLIB_player_scores;
_HoF sort false;

private _max = 5;
if (count _HoF < _max) then { _max = count _HoF };

private _ind = "";
private _icon = "<img image='\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa'/>";
for "_i" from 0 to (_max-1) do {
    switch (_i) do {
        case 0 : { _ind = _icon + _icon + _icon + _icon };
        case 1 : { _ind = " " + _icon + _icon + _icon };
        case 2 : { _ind = "  " + _icon + _icon };
        default  { _ind = "   " + _icon };
    };
    _msg = _msg + format ["<t color='#FFFFFF' size='1.0'>%1</t>  <t color='#000080'>%2</t><br/><br/>", _ind, (_HoF select _i) select 1];
};

[_msg, 0, -1, 8, 0, -2, 5];