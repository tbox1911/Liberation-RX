if (!isServer && hasInterface) exitWith {};
params [ "_unit", "_class", "_forced_pos" ];
{
	if ((_unit distance2D _x) <= 500) then {["parasound"] remoteExec ["playSoundNow", owner _x]};
} forEach (AllPlayers - (entities "HeadlessClient_F"));

private _pos = zeropos;
private _text = "";

if (isNil "_forced_pos") then {
	_pos = (getPosATL _unit) vectorAdd [0, 0, 400];
	private _vehicle = createVehicle [_class, _pos, [], 0, "NONE"];
	_vehicle addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	[_vehicle, "lock", (getPlayerUID _unit)] call F_vehicleLock;
	[_vehicle, objNull] spawn F_addParachute;
	_text = format ["Player %1 call Air Support.  Dropping: %2.", name _unit, ([_class] call F_getLRXName)];
} else {
	_pos = _forced_pos;
	_class setPos _pos;
	sleep 1;
	[_class, objNull] spawn F_addParachute;
	_text = format ["Player %1 Air Drop vehicle %2 at %3.", name _unit, ([typeOf _class] call F_getLRXName), _pos];
};
[gamelogic, _text] remoteExec ["globalChat", 0];

diag_log format [ "Done Airdrop vehicle %1 on %2 at %3", _class, _pos, time ];
