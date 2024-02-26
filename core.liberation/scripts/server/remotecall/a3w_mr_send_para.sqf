if (!isServer && hasInterface) exitWith {};
params [ "_target_pos" ];

private _grp1 = [_target_pos, false, 250] call send_paratroopers;
sleep 20;
private _grp2 = [_target_pos, false, 300] call send_paratroopers;
sleep  20;
private _grp3 = [_target_pos, false, 300] call send_paratroopers;
sleep  5;

GRLIB_A3W_Mission_MR = [_grp1, _grp2, _grp3];
publicVariable "GRLIB_A3W_Mission_MR";

sleep 3;
private _location_name = [_target_pos] call F_getLocationName;
["lib_reinforcements", [_location_name]] remoteExec ["bis_fnc_shownotification", 0];