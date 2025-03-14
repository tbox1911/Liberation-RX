params ["_unit", ["_slow", true]];
if (isNull objectParent _unit || isNull _unit) exitWith {};
if ((vehicle _unit) isKindOf "ParachuteBase") exitWith {};

private _unit_side = side group _unit;
if (_unit_side == GRLIB_side_enemy) then { _unit allowDamage false };

unAssignVehicle _unit;
[_unit] orderGetIn false;
[_unit] allowGetIn false;

if (_slow) then { sleep 2 };
moveOut _unit;
sleep 1;
if (!alive _unit) exitWith {};

private _unit_alt = getPos _unit select 2;
if (_unit_alt >= 50) then {
	private _pos = [getPos _unit, 25] call F_getRandomPos;
	_pos set [2, _unit_alt];
	if (backpack _unit != "B_Parachute") then {
		private _para = createVehicle ["Steerable_Parachute_F",_pos,[],0,"FLY"];
		_unit moveInDriver _para;
		sleep 3;
		if (isNull (driver _para)) then { deleteVehicle _para };
	};

	private _backpack_save = _unit getVariable "GRLIB_para_backpack";
	if (!isNil "_backpack_save") then {
		[_unit, _backpack_save] spawn {
			params ["_unit", "_backpack"];
			waitUntil { sleep 1; (round (getPos _unit select 2) <= 0) };
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
};

if (_unit_side == GRLIB_side_enemy) then { sleep 3; _unit allowDamage true };
