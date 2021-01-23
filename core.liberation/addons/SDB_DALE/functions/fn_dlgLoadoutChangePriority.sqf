disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _ctrl = param [0,controlNull,[controlNull]];
private _index = param [1,0,[0]];
private _display = ctrlParent _ctrl;
private _veh = _display getVariable ["DALE_var_LoadoutVehicle",objNull];

private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";
private _pylonCount = -1+count (_cfgComponent >> "Pylons");

private _priorityArray = [];
switch (_index) do {
	case 0: {
		for "_i" from 0 to _pylonCount do {
			_priorityArray pushBack (abs(2*_i-_pylonCount) + ([1,0] select (_i > _pylonCount/2)));
		};
	};
	case 1: {
		for "_i" from 0 to _pylonCount do {
			_priorityArray pushBack (abs(2*_i-_pylonCount));
		};
	};
	case 2: {
		for "_i" from 0 to _pylonCount do {
			_priorityArray pushBack 0;
		};
	};
};

_veh setVariable ["DALE_var_LoadoutPriority",_index,true];
_veh setPylonsPriority _priorityArray;