disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _ctrl = param [0,controlNull,[controlNull]];
private _index = param [1,0,[0]];
private _display = ctrlParent _ctrl;
private _veh = _display getVariable ["DALE_var_LoadoutVehicle",objNull];

private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";
private _preset = _cfgComponent >> "Presets" >> (_ctrl lbData _index);

if (!isClass _preset) exitWith {};

private _cfgCombo = missionConfigFile >> "DALE_RscCombo";
private _comboIdc = getNumber (_cfgCombo >> "idc");

private _loadout = getArray (_preset >> "attachment");

{
	private _mag = _loadout param [_forEachIndex,"",[""]];
	private _ctrl = _display displayCtrl (_comboIdc+_forEachIndex);
	_ctrl ctrlRemoveAllEventHandlers "LBSelChanged";
	for "_i" from 0 to (-1+lbSize _ctrl) do {
		if ((_ctrl lbData _i) == _mag) exitWith {_ctrl lbSetCurSel _i;};
	};
	_ctrl ctrlAddEventHandler ["LBSelChanged",DALE_fnc_dlgLoadoutPylonChange];
} forEach ("isClass _x" configClasses (_cfgComponent >> "Pylons"));