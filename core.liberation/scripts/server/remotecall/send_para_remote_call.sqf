if (!isServer && hasInterface) exitWith {};
params [ "_targetsector" ];

private _grp1 = [markerPos _targetsector] call send_paratroopers;
sleep 5;
private _grp2 = [markerPos _targetsector] call send_paratroopers;

GRLIB_A3W_Mission_MR = [_grp1, _grp2];
publicVariable "GRLIB_A3W_Mission_MR";
sleep 3;
["lib_reinforcements", [markertext _targetsector]] remoteExec ["bis_fnc_shownotification", 0];