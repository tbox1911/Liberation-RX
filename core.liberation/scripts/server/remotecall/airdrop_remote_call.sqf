if (!isServer) exitWith {};
params [ "_unit", "_class" ];
{
	_dist = round (_unit distance2D _x);
	if (_dist <= 500) then {["parasound"] remoteExec ["playSound", owner _x]};
} forEach allPlayers;

_pos = (getPosATL _unit) vectorAdd [0, 0, 400];
_veh = createVehicle [_class, _pos, [], 0, "NONE"];
_veh setdir (random 360);
_text = format ["Player %1 call Air Support.  Dropping: %2 !", name _unit, getText (configFile >> "CfgVehicles" >> typeOf _veh >> "displayName")];
[gamelogic, _text] remoteExec ["globalChat", 0];
[_unit] remoteExec ["remote_call_airdrop", owner _unit];


waitUntil {sleep 0.5;(getposATL _veh select 2) < 150};
_para = createVehicle ["B_Parachute_02_F",(getposATL _veh), [], 0, "NONE"];
_veh attachTo [_para, [0,0,0]];

waitUntil {sleep 0.2;(getposATL _veh select 2) < 7};
detach _veh;
_veh allowDamage false;

"SmokeShellBlue" createVehicle (getposATL _veh);
"SmokeShellBlue" createVehicle (getposATL _veh);
sleep 6;
deleteVehicle _para;
_veh allowDamage true;