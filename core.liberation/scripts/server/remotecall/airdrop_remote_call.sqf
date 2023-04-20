if (!isServer && hasInterface) exitWith {};
params [ "_unit", "_class" ];
{
	if ((_unit distance2D _x) <= 500) then {["parasound"] remoteExec ["playSound", owner _x]};
} forEach (AllPlayers - (entities "HeadlessClient_F"));

private _pos = (getPosATL _unit) vectorAdd [0, 0, 400];
private _vehicle = createVehicle [_class, _pos, [], 0, "NONE"];
_vehicle addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
[_vehicle, objNull] spawn F_addParachute;

private _text = format ["Player %1 call Air Support.  Dropping: %2 !", name _unit, ([_class] call F_getLRXName)];
[gamelogic, _text] remoteExec ["globalChat", 0];

diag_log format [ "Done Airdrop vehicle %1 at %2", _class , time ];
