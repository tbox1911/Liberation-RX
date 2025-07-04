params ["_sector_pos", "_defense_type", ["_fob", false]];

private _grp = grpNull;
private _vehicle = objNull;
private _arsenal = objNull;
private _players = (AllPlayers - (entities "HeadlessClient_F"));
if (count _players == 0) exitWith {};
private _cost = round ((GRLIB_defense_costs select _defense_type) / (count _players));
{
    if (_x getVariable ["GREUH_ammo_count", 0] > GREUH_start_ammo) then {
        [_x, -_cost, 0] call ammo_add_remote_call;
    };
} forEach _players;

private _msg = format ["Spawn level %1 Defenders on %2, Each players pays %3 Ammo.", _defense_type, ([_sector_pos] call F_getLocationName), _cost];
[gamelogic, _msg] remoteExec ["globalChat", 0];
diag_log _msg;

private _squad_type = blufor_squad_inf_light;
private _nb_unit = 5;
if (_defense_type == 2) then {
	_squad_type = blufor_squad_inf;
    _nb_unit = 8;
};
if (_defense_type == 3) then {
	_squad_type = blufor_squad_mix;
    _nb_unit = 12;
};

private _defenders_pool = [];
for "_i" from 0 to _nb_unit do { _defenders_pool pushBack (selectRandom _squad_type) };
_grp = [_sector_pos, _defenders_pool, GRLIB_side_friendly, "defender", true] call F_libSpawnUnits;
_grp setCombatMode "YELLOW";
_grp setBehaviourStrong "COMBAT";
{
    _x setSkill 0.65;
    _x setSkill ["courage", 1];
    _x allowFleeing 0;
    _x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
} foreach (units _grp);
[_grp, _sector_pos, 80] spawn defence_ai;

if (!_fob) then {
    if (_defense_type == 3) then {
        private _vehicles_typename = ["MRAP_01_base_F", "MRAP_02_base_F", "Wheeled_APC_F"];
        private _vehicles_pool = (heavy_vehicles select {[(_x select 0), _vehicles_typename] call F_itemIsInClass}) apply { _x select 0 };
        if (count _vehicles_pool > 0) then {
            private _vehiclePos = _sector_pos findEmptyPosition [5, 120, "B_Heli_Transport_03_unarmed_F"];
            _vehicle = [_vehiclePos, selectRandom _vehicles_pool, 3, false, GRLIB_side_friendly] call F_libSpawnVehicle;
            [(group driver _vehicle), _sector_pos] spawn defence_ai;
        };
    };

    _arsenal = createVehicle [Arsenal_typename, _sector_pos, [], 20, "NONE"];
    [_arsenal] call F_clearCargo;
};

private _ownership = [_sector_pos] call F_sectorOwnership;
private _defenders_timer = round (time + 180);
while { time < _defenders_timer && ({alive _x} count (units _grp) > 0) && _ownership == GRLIB_side_enemy } do {
    _ownership = [_sector_pos] call F_sectorOwnership;
    sleep 10;
};

[_grp, _vehicle, _arsenal];
