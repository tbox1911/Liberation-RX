params [ "_sector", "_number" ];
if (_sector in active_sectors) exitWith {};
if (_number == 0) exitWith {};
if (_number >= 1) then {
	[ _sector, _number - 1 ] spawn static_manager;
};

// Create
private _grp = createGroup [GRLIB_side_enemy, true];
private _spawn_pos = [ getMarkerPos _sector, floor(random 50), random 360 ] call BIS_fnc_relPos;
private _vehicle = [ _spawn_pos, selectRandom opfor_statics ] call F_libSpawnVehicle;
_vehicle setVariable ["GRLIB_counter_TTL", round(time + 900)];
opfor_spotter createUnit [ getposATL _vehicle, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
opfor_spotter createUnit [ getposATL _vehicle, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
(crew _vehicle) joinSilent _grp;
{ _x setVariable ["OPFor_vehicle", _vehicle] } forEach units _grp;

diag_log format [ "Spawn Static Patrol on sector %1 at %2", _sector, time ];
if ( local _grp ) then {
    _headless_client = [] call F_lessLoadedHC;
    if ( !isNull _headless_client ) then {
        _grp setGroupOwner ( owner _headless_client );
    };
};

// Default for HMG, GMG
private _radius = 800;
private _kind = "Man";
private _veh_class = typeOf _vehicle;
if (_veh_class isKindOf "StaticMortar") then {_radius = 1000; _kind = "Man"};
if (_veh_class isKindOf "AT_01_base_F") then {_radius = 2000; _kind = "LandVehicle"};
if (_veh_class isKindOf "AA_01_base_F") then {_radius = 3000; _kind = "Air"};

private _timeout = time + (5 * 60);

// AI
while { count (units _grp) > 0 } do {
    _gunner = units _grp select 0;
    _vehicle = _gunner getVariable ["OPFor_vehicle", objNull];
    if (!isNull _vehicle) then {
        // Keep gunner
        if (_gunner != gunner _vehicle) then {
            _gunner assignAsGunner _vehicle;
            [_gunner] orderGetIn true;
        } else {
            _scan_target = [units GRLIB_side_friendly, {
                alive _x &&
                (vehicle _x) isKindOf _kind &&
                !(_x getVariable ['R3F_LOG_disabled', false]) &&
                !([_x, "LHD", GRLIB_sector_size] call F_check_near) &&
                !([_x, "FOB", GRLIB_sector_size] call F_check_near) &&
                _x distance2D (getPosATL _vehicle) <= _radius
            } ] call BIS_fnc_conditionalSelect;

            if (count (_scan_target) > 0 ) then {
                // closest first
                _target_list = _scan_target apply {[_x distance2D _vehicle, _x]};
                _target_list sort true;
                _next_target = _target_list select 0 select 1;

                _vehicle setDir (_vehicle getDir _next_target);
                _grp setBehaviour "COMBAT";
                _gunner reveal [_next_target, 2];
                _gunner doTarget _next_target;
                if (_veh_class isKindOf "StaticMortar") then {
                    _vehicle fireAtTarget [_next_target];
                    sleep 15;
                };
                //diag_log format ["--- LRX: OPFor defender %1 spot unit %2 (%3) dist %4m", _veh_class, _next_target, typeOf _next_target, round (_gunner distance2D _next_target)];
            };
        };
    };

    // Cleanup
    if ( [getpos (leader _grp), (_radius * 1.5), GRLIB_side_friendly] call F_getUnitsCount == 0 && time > _timeout ) then {
        {
            if ( vehicle _x != _x ) then {
                deleteVehicle (vehicle _x);
            };
            deleteVehicle _x;
        } foreach (units _grp);
        deleteGroup _grp;
    };

    sleep 10;
};
