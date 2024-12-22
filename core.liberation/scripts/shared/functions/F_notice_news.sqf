private _leadingzero_hour = "";
private _leadingzero_minute = "";
if ( (date select 3) < 10 ) then { _leadingzero_hour = "0" };
if ( (date select 4) < 10 ) then { _leadingzero_minute = "0" };

private _count_players = count (AllPlayers - (entities "HeadlessClient_F"));
private _count_blufor = count blufor_sectors;
private _count_opfor = count opfor_sectors;
private _datestring = format ["<t color='#0000A0'>%1%2:%3%4</t>", _leadingzero_hour, date select 3, _leadingzero_minute, date select 4];
private _msg = format ["<t color='#4BC9B0' shadow='2' size='1.75'>Today's LRX News</t><br/>"];
_msg = _msg + "<t color='#777777'>------------------------------</t><br/>";
_msg = _msg + format ["Latest Fresh News from <t color='#008000'>%1</t> at %2<br/><br/>", worldname, _datestring];
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>There's actually <t color='#000080'>%1</t> players on the Server.</t><br/>", _count_players];
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>Our forces control <t color='#000080'>%1</t> Sectors.</t><br/>", _count_blufor];
_msg = _msg + format ["<t color='#FFFFFF' size='1.0'>the Enemy still control <t color='#800000'>%1</t> Sectors.</t><br/><br/>", _count_opfor];

private _color = "";
if (count active_sectors > 0) then {
    _msg = _msg + format ["<t color='#FFFFFF' size='1.0'>The news are not peacful today...</t><br/>"];
    {
        _color = "#800000";
        if (_x in blufor_sectors) then { _color = "#000080" };
        _msg = _msg + format ["<t color='#FFFFFF' size='1.0'>Combat reported near <t color='%1'>%2</t>.</t><br/>", _color, [markerPos _x] call F_getLocationName];
    } forEach active_sectors;
} else {
    _msg = _msg + format ["<t color='#FFFFFF' size='1.0'>There's actually NO fight in progress. Sweet time!</t><br/>"];
};

private _reput = [player] call F_getReputText;
private _color = _reput select 0;
private _text = _reput select 1;

_msg = _msg + format ["<br/><t color='#FFFFFF' size='1.0'>Your Reputation with Civilians is <t color='%1'>%2</t></t><br/>", _color, _text];
_msg = _msg + "<t color='#777777'>------------------------------</t><br/>";
_msg = _msg + "<br/>Stay tuned for the next News report...";

[_msg, 0, -1, 8, 0, -2, 5];
