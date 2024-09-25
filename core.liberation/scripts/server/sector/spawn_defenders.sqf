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

private _msg = format ["Spawn Defenders on %1, Each players pays %2 Ammo.", ([_sector_pos] call F_getLocationName), _cost];
[gamelogic, _msg] remoteExec ["globalChat", 0];
diag_log _msg;

private _squad_type = blufor_squad_inf_light;
if (_defense_type == 2) then {
	_squad_type = blufor_squad_inf;
};
if (_defense_type == 3) then {
	_squad_type = blufor_squad_mix;
};

_grp = [_sector_pos, _squad_type, GRLIB_side_friendly, "defender"] call F_libSpawnUnits;
_grp setCombatMode "RED";
_grp setCombatBehaviour "COMBAT";
{
    _x setSkill 0.65;
    _x setSkill ["courage", 1];
    _x allowFleeing 0;
    _x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
} foreach (units _grp);
[_grp, _sector_pos, 50] spawn defence_ai;

if (!_fob) then {
    if (_defense_type == 3) then {
        private _vehicleClass = [];
        {
            if ((_x select 0) isKindOf "Wheeled_APC_F") then { _vehicleClass pushBack (_x select 0) };
        } forEach (light_vehicles + heavy_vehicles);

        if (count _vehicleClass > 0) then {
            private _vehiclePos = _sector_pos findEmptyPosition [5, 120, "B_Heli_Transport_03_unarmed_F"];
            _vehicle = [_vehiclePos, selectRandom _vehicleClass, 3, false, GRLIB_side_friendly] call F_libSpawnVehicle;
            _vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
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
    sleep 5;
};

[_grp, _vehicle, _arsenal];
