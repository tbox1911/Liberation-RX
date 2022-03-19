

addMissionEventHandler ['EntityKilled',{
	
	params ["_unit", "_killer"];
	
	if (isPlayer _unit) then {
		
		_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
		if (_hs_unconscious == true) then {
			_unit setVariable ["GREUH_ammo_count", ( (_unit getVariable ["GREUH_ammo_count", 25]) - 25), true];
		};
		
	}else{
		
		if ( (side group _unit == opfor) && (isPlayer _killer) ) then {
			_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 0]) + 1), true];
			[_killer, 1] remoteExec ["addScore", 2];
		};
		
		if (side group _unit == civilian && side _killer == blufor) then {
			_msg = format ["%1 killed a civillian. Penalty: -15 rank and ammo", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 15]) - 15), true];
			[_killer, -15] remoteExec ["addScore", 2];
		};
		
	};
	
}];

addMissionEventHandler ['HandleDisconnect',{
	_unit = _this select 0;
	_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
	if (_hs_unconscious == true) then {
		_unit setVariable ["GREUH_ammo_count", ( (_unit getVariable ["GREUH_ammo_count", 25]) - 25), true];
	};
}];


/*
["B_Soldier_F", "InitPost", {
	if ( isServer ) then {
		params ["_vehicle"];
		_vehicle addMPEventHandler ["MPHit", {
			params ["_unit", "_causedBy", "_damage", "_instigator"];
			if (isPlayer _causedBy) then {
				_msg = format ["Friendly fire from %1 to %2. Penalty: -1 rank and ammo", name _causedBy, name _unit];
				[gamelogic, _msg] remoteExec ["globalChat", 0];
				_causedBy setVariable ["GREUH_ammo_count", ( (_causedBy getVariable ["GREUH_ammo_count", 1]) - 1), true];
				[_causedBy, -1] remoteExec ["addScore", 2];
			};
		}];
	};
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_GER_Operator_Medic", "InitPost", {
	if ( isServer ) then {
		params ["_vehicle"];
		_vehicle addMPEventHandler ["MPHit", {
			params ["_unit", "_causedBy", "_damage", "_instigator"];
			if (isPlayer _causedBy) then {
				_msg = format ["Friendly fire from %1 to %2. Penalty: -1 rank and ammo", name _causedBy, name _unit];
				[gamelogic, _msg] remoteExec ["globalChat", 0];
				_causedBy setVariable ["GREUH_ammo_count", ( (_causedBy getVariable ["GREUH_ammo_count", 1]) - 1), true];
				[_causedBy, -1] remoteExec ["addScore", 2];
			};
		}];
	};
}, nil, nil, true] call CBA_fnc_addClassEventHandler;
*/



/*

if (_hs_unconscious == true) then { [_unit, -25] remoteExec ["addScore", 2]; };

_msg = format [ "%1 killed by %2 (%3)", side group _unit, name _killer, side _killer ];
[gamelogic, _msg] remoteExec ["globalChat", 0];
		
		if (side group _unit == civilian && side _killer == blufor) then {
			_msg = format ["%1 killed a civillian. Penalty: -25 rank and ammo", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 25]) - 25), true];
			[_killer, -25] remoteExec ["addScore", 2];
		};

			_msg = format ["%1 killed an enemy. Bonus: +1 rank and ammo", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			
*/

["Initialize", [true]] call BIS_fnc_dynamicGroups;

