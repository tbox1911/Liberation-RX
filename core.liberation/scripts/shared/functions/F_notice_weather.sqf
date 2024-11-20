private _leadingzero_hour = "";
private _leadingzero_minute = "";
if ( (date select 3) < 10 ) then { _leadingzero_hour = "0" };
if ( (date select 4) < 10 ) then { _leadingzero_minute = "0" };

private _datestring = format ["<t color='#0000A0'>%1%2:%3%4</t>", _leadingzero_hour, date select 3, _leadingzero_minute, date select 4];
private _msg = format ["<t color='#4BC9B0' shadow='2' size='1.75'>Today's Weather Info</t><br/>"];
_msg = _msg + "<t color='#777777'>------------------------------</t><br/>";
_msg = _msg + format ["Latest Fresh Meteo from <t color='#008000'>%1</t> at %2<br/><br/>", worldname, _datestring];

private _data = ["Weather"] call lrx_getParamData select 1;
private _value = _data select (["Weather"] call lrx_getParamValue);
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>Global Weather is <t color='#000080'>%1</t></t><br/>", _value];
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>The day Start at <t color='#000080'>0%1</t> AM</t><br/>", GRLIB_nights_stop];
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>The day Ends at <t color='#008000'>%1</t> PM</t><br/>", GRLIB_nights_start];
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>The risk of Rain is <t color='#A0A0A0'>%1</t>%2</t><br/>", round(linearConversion [0, 1, rain, 0, 100, true]), "%"]; 
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>The Fog level is <t color='#808080'>%1</t>%2</t><br/>", round(linearConversion [0, 1, fog, 0, 100, true]), "%"]; 
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>The Wind direction is <t color='#0000A0'>%1</t> degrees<br/>with a speed of <t color='#0000A0'>%2</t> km/h</t><br/>", round windDir, round (windStr * 100)];
_msg = _msg + "<t color='#777777'>------------------------------</t><br/>";
_msg = _msg + "<br/>Have a nice day....";

[_msg, 0, -1, 8, 0, -2, 5];
