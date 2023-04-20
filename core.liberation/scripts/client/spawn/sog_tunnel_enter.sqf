// Enter SoG tunnel

private _tunnel_marker = [(allMapMarkers select {_x select [0,20] == "side_mission_sog_tun" && markerPos _x distance2D player <= GRLIB_capture_size}), player] call F_nearestPosition;
private _tunnel_name = format ["LRX%1", (_tunnel_marker select [12, 11])];
private _tunnel = missionNameSpace getVariable [_tunnel_name, objNull];

// AI follow
private _ai_follow = false;
private _ai_follow_max = 2;
private _unit_list_redep = [];

// Enter SoG tunnel with AI
if (_ai_follow) then {
    if (count (player getVariable ["SOG_unit_list", []]) == 0) then {
        _unit_list_redep = ([(units group player), { !(isPlayer _x) && vehicle _x == _x && (_x distance2D (getPosATL _tunnel)) < 40 && lifestate _x != 'INCAPACITATED' }] call BIS_fnc_conditionalSelect) select [0,_ai_follow_max];
        [_unit_list_redep] spawn {
            sleep 1;
            params ["_list"];
            {
                _x setpos ([getPosATL player, 1, random 360] call BIS_fnc_relPos);
                _x doFollow leader player;
                sleep 0.3;
            } forEach _list;
        };
        player setVariable ["SOG_unit_list", _unit_list_redep];
    };
};
{ doStop _x } foreach (units group player);

private _position = (_tunnel getVariable ["tunnel_position", 0]) + 1;
private _msg = format ["You enter in the <t color='#008f00'>Guerrilla</t> tunnel no <t color='#008f00'>%1</t> !<br/><br/>
Expect NO <t color='#00008f'>Support</t>,  NO <t color='#00008f'>Help</t>. <br/>
...Expect NO <t color='#8f0000'>Mercy</t> !!<br/><br/>
You are on your own....", _position];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

showMap false;
[player, _tunnel_name] remoteExec [ "sog_tunnel_enter_remotecall", 2 ];
player setVariable ["SOG_player_in_tunnel", true];
