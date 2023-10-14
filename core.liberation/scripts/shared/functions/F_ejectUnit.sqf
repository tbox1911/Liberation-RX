params ["_unit", ["_slow", true]];
if (isNull _unit) exitWith {};
if (isNull objectParent _unit) exitWith {};
if (!local _unit) exitWith {if (isServer) then {[_unit, _slow] remoteExec ["F_ejectUnit", owner _unit]}};

private _backpack_save = _unit getVariable "GRLIB_para_backpack";
if (!isNil "_backpack_save") then {
	[_unit, _backpack_save] spawn {
		params ["_unit", "_backpack"];
		waituntil {sleep 2; !(alive _unit) || (isTouchingGround _unit)};
		if !(alive _unit) exitWith {};
		removeBackpack _unit;
		_unit addBackpack _backpack;
		clearAllItemsFromBackpack _unit;
		_backpack_content = _unit getVariable ["GRLIB_para_backpack_contents", []];
		if (count _backpack_content > 0) then {
			{_unit addItemToBackpack _x} foreach _backpack_content;
		};
		_unit setVariable ["GRLIB_para_backpack", nil];
		_unit setVariable ["GRLIB_para_backpack_contents", nil];	
	};
};

if ((vehicle _unit) iskindof "ParachuteBase") exitWith {};

private _unit_side = side group _unit;
if (_unit_side == GRLIB_side_enemy) then { _unit allowDamage false };

unAssignVehicle _unit;
[_unit] orderGetIn false;

if (_slow) then { sleep 2 };
moveOut _unit;
sleep 1;
if (!alive _unit) exitWith {};

if (getPos _unit select 2 >= 50) then {
	_pos = _unit getPos [50, 360];
	if (backpack _unit != "B_Parachute") then {
		_para = createVehicle ["Steerable_Parachute_F",_pos,[],0,"FLY"];
		_unit moveInDriver _para;
		sleep 2;
		if (isNull (driver _para)) then { deleteVehicle _para };
	};
};

if (_unit_side == GRLIB_side_enemy) then { sleep 3; _unit allowDamage true };
