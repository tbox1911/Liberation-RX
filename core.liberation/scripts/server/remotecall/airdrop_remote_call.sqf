if (!isServer && hasInterface) exitWith {};
params [ "_unit", "_class", "_forced_pos" ];

private _text = "";
private _vehicle = objNull;

if (isNil "_forced_pos") then {
	_text = format ["Player %1 call Air Drop Support.", name _unit];
	private _pos = (getPosATL _unit) vectorAdd [0, 0, 400];
	_vehicle = createVehicle [_class, _pos, [], 0, "NONE"];
	_vehicle addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	[_vehicle, "lock", (getPlayerUID _unit)] call F_vehicleLock;
} else {
	_text = format ["Player %1 Air Drop Vehicle.", name _unit];
	_vehicle = _class;
	_vehicle setPos _forced_pos;
};
[gamelogic, _text] remoteExec ["globalChat", 0];
[_vehicle] spawn F_addParachute;

diag_log format [ "Done Airdrop vehicle %1 at %2", (typeOf _vehicle), time ];
