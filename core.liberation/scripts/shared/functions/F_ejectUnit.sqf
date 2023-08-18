params ["_vehicle", "_unit", ["_slow", true]];
if (isNull _unit) exitWith {};
if (!local _unit) exitWith {
	if (isServer) then {
		[_vehicle, _unit] remoteExec ["F_ejectUnit", owner _unit];
	} else {
		[_vehicle, _unit] remoteExec ["F_ejectUnit", 2];
	};
};

_unit allowDamage false;
unAssignVehicle _unit;
_unit action ["eject", _vehicle];
_unit action ["getout", _vehicle];
if (_slow) then { sleep random 3 };
sleep 1;
if (!isNull objectParent _unit) then { moveOut _unit };
if (!alive _unit) exitWith {};

if (getPos _unit select 2 >= 20) then {
	_unit setPos (getPosATL _vehicle vectorAdd [([[-20,0,20], 3] call F_getRND), ([[-20,0,20], 3] call F_getRND), 0]);
	if (_unit getVariable ["GRLIB_para_backpack", ""] != "") then {
		[_unit] spawn {
			params ["_unit"];
			waituntil {sleep 2; !(alive _unit) || (isTouchingGround _unit)};
			if (!(alive _unit)) exitWith {};
			_unit addBackpack (_unit getVariable ["GRLIB_para_backpack", ""]);
			clearAllItemsFromBackpack _unit;
			{_unit addItemToBackpack _x} foreach (_unit getVariable ["GRLIB_para_backpack_contents", []]);
		};
	};
	private _para = createVehicle ['Steerable_Parachute_F',(getPos _unit),[],0,'none'];
	_unit moveInDriver _para;
	sleep 2;
	if (isNull (driver _para)) then { deleteVehicle _para };
	sleep 5;
};

sleep 2;
_unit allowDamage true;
