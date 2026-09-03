private _access = false;
if (isServer && hasInterface) then { _access = true };

private _uid = "unknow";
private _netid = remoteExecutedOwner;
if (!_access) then {
    if (!isServer && hasInterface && !isRemoteExecuted) exitWith {};
    if (_netid == 0) exitWith {};
    private _caller = (allPlayers select { owner _x == _netid }) select 0;
    if (isNil "_caller") exitWith {};
    _uid = getPlayerUID _caller;
    if (admin _netid == 2) then { _access = true };
};

if (!_access) exitWith {
    diag_log format ["--- LRX SECURITY: Unauthorized remoteExec attempt by UID %1 / NETID %2", _uid, _netid];
};

diag_log format ["--- LRX SECURITY: Admin call from UID %1 / NETID %2", _uid, _netid];

params ["_cmd", "_data"];

if (_cmd == "export") exitWith {
    [] call save_game_mp;
	[missionNamespace, ["output_save", (profileNamespace getVariable GRLIB_save_key)]] remoteExec ["setVariable", owner _data];
	["Copy the save game from the text field."] remoteExec ["hintSilent", owner _data];
};

if (_cmd == "import") exitWith {
    GRLIB_server_stopped = true;
    profileNamespace setVariable [GRLIB_save_key, _data];
    saveProfileNamespace;
    ["END"] remoteExec ["endMission", 0];
};

if (_cmd == "kick") exitWith {
    private _kicked = _data call BIS_fnc_getUnitByUID;
    if (isPlayer _kicked) then {
        private _name = name _kicked;
        ["LOSER"] remoteExec ["endMission", owner _kicked];
        serverCommand format ["#kick %1", _name];
        private _msg = format [localize "STR_ADMIN_KICK_PLAYER", _name];
        [gamelogic, _msg] remoteExec ["globalChat", -2];
    };
};

if (_cmd == "ban") exitWith {
    private _player = _data call BIS_fnc_getUnitByUID;
    if (isPlayer _player) then {
        BTC_logic setVariable [_data, 99, true];
        [_player] remoteExec ["LRX_tk_actions", owner _player];
        private _msg = format [localize "STR_ADMIN_BAN_PLAYER", name _player];
        [gamelogic, _msg] remoteExec ["globalChat", -2];
    };
};

if (_cmd == "capture") exitWith {
    blufor_sectors pushBackUnique _data;
    opfor_sectors = (sectors_allSectors - blufor_sectors);
    publicVariable "blufor_sectors";
};

if (_cmd == "save") exitWith {
    { [_x, getPlayerUID _x] call save_context } foreach (AllPlayers - (entities "HeadlessClient_F"));
    [] call save_game_mp;
};

if (_cmd == "kill") exitWith {
	{if (_x distance2D _data <= GRLIB_sector_size) then {_x setDamage 1}} foreach (units GRLIB_side_enemy);
};
