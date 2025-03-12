params ["_unit"];


_unitPos = getWPPos [_unit, 0];

_units = units _unit;

_unitWP = createHashMap;

_group = group _unit;

// Store all of the waypoints of group members before leader loses ownership of the squad
if (leader _unit == _unit) then {
	{
		if (vehicle _x != _x) then {
			_x disableAI "FSM";
			_x disableAI "PATH";
			_x setBehaviour "CARELESS";
			//if any group members are already in a vehicle, add the vehicle to the group so that the ai leader is less likely to tell them to dismount
			(group _x) addVehicle (vehicle _x);
		};
		_wp = getWPPos [_x, 0];
		if !(_wp isEqualTo [0,0,0]) then {
			_unitWP set [hashValue _x, _wp];
		};
	} forEach _units;
};

if (rating _unit < -2000) exitWith {_unit setDamage 1};
if (!([] call F_getValid)) exitWith {_unit setDamage 1};
private _cur_revive = 1;
if (PAR_ai_revive > 0 && !isPlayer _unit && local _unit) then {
	_cur_revive = _unit getVariable ["PAR_revive_max", PAR_ai_revive];
};
if (_cur_revive <= 0) exitWith {_unit setDamage 1};

_unit setUnconscious true;
_unit setCaptive true;
_unit allowDamage false;
_unit setVariable ["PAR_busy", nil];
_unit setVariable ["PAR_myMedic", nil];
_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_bleedout), true];
_unit setVariable ["PAR_isDragged", 0, true];

if (isPlayer _unit) then {
	//If an ai takes control of your squad, try to hold it still
	_group removeAllEventHandlers "LeaderChanged";

    _group addEventHandler ["LeaderChanged", {
        params ["_group", "_newLeader"];
        if (!isPlayer _newLeader) then {
            {
                doStop _x;
            } forEach units _group;
        };
    }];
	private _mk1 = createMarkerLocal [format ["PAR_marker_%1", PAR_Grp_ID], getPosATL player];
	_mk1 setMarkerTypeLocal "loc_Hospital";
	_mk1 setMarkerTextLocal format ["%1 Injured", name player];
	_mk1 setMarkerColor "ColorRed";
	if ([_unit] call F_getScore > GRLIB_perm_log + 5) then { [_unit, -1] remoteExec ["F_addScore", 2] };
	if (GRLIB_disable_death_chat) then { for "_channel" from 0 to 4 do { _channel enableChannel false } };
	PAR_backup_loadout = [player] call F_getCargoUnit;
} else {
	_unit setVariable ["GRLIB_can_speak", false, true];
	[_unit] call F_deathSound;
	sleep 3;
};

waitUntil { sleep 0.5; isNull objectParent _unit };
_unit switchMove "AinjPpneMstpSnonWrflDnon_rolltoback";
_unit playMoveNow "AinjPpneMstpSnonWrflDnon_rolltoback";
sleep 5;

if (!alive _unit) exitWith {};
waituntil { sleep 1; (round (getPos _unit select 2) <= 0) };

private _bld = [_unit] call PAR_spawn_blood;
private _cnt = 0;
private ["_medic", "_msg"];
while { alive _unit && ([_unit] call PAR_is_wounded) && time <= (_unit getVariable ["PAR_BleedOutTimer", 0])} do {
	// Stop automatically assigning medics to players, let the player decide
	if (!isPlayer _unit) then {
		_unit setOxygenRemaining 1;
		if ( {alive _x} count PAR_AI_bros > 0 ) then {
			_medic = _unit getVariable "PAR_myMedic";
			if (isNil "_medic") then {
				_unit groupchat localize "STR_PAR_UC_01";
				_medic = [_unit] call PAR_fn_medic;
				if (!isNil "_medic") then { [_unit, _medic] call PAR_fn_911 };
			};
		} else {
			_msg = format [localize "STR_PAR_UC_03", name player];
			if ([player] call PAR_is_wounded) then {
				_msg = format [localize "STR_PAR_UC_02", name player];
			};
			_last_msg = player getVariable ["PAR_last_message", 0];
			if (time > _last_msg) then {
				[_unit, _msg] call PAR_fn_globalchat;
				player setVariable ["PAR_last_message", round(time + 20)];
			};
		};
	} else {
		_medic = _unit getVariable ["PAR_myMedic", nil];
        if (isNil "_medic") then {
			//Renable the call medic button for the player if their medic gets lost
            ((findDisplay 5566) displayCtrl 679) ctrlEnable true;
        };
	};
	sleep 10;
};

if (!isNull _bld) then { _bld spawn {sleep (30 + floor(random 30)); deleteVehicle _this} };

if (isPlayer _unit) then {
	deletemarker format ["PAR_marker_%1", PAR_Grp_ID];
	if (GRLIB_disable_death_chat) then { for "_channel" from 0 to 4 do { _channel enableChannel true } };
};

if (alive _unit) then {
    if (time > _unit getVariable ["PAR_BleedOutTimer", 0]) then {
		//Too late
        _unit setDamage 1;
        [(_unit getVariable ["PAR_myMedic", objNull]), _unit] call PAR_fn_medicRelease;
    } else {
		//Revived
        if (isPlayer _unit) then {
            (group _unit) selectLeader _unit;
            if (primaryWeapon _unit != "") then {
                _unit selectWeapon primaryWeapon _unit
            };
        } else {
            _unit setVariable ["GRLIB_can_speak", true, true];
            _unit setSpeedMode (speedMode group player);
            _unit doFollow player;
        };
    };
};

//Finally, lets get out units back to their waypoints before the ai group leader messed it up
{
    _x enableAI "FSM";
    _x enableAI "PATH";
    _wp = _unitWP get (hashValue _x);
    if (!isNil "_wp" && {!(_wp isEqualTo [0,0,0])}) then {
        if (round (_x distance2D _wp) < 100) then {
            _x doMove _wp;
        } else {
            doStop _x;
        };
    };
} forEach _units;