disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _ctrl = param [0,controlNull,[controlNull]];
private _index = param [1,0,[0]];
private _display = ctrlParent _ctrl;
private _veh = _display getVariable ["DALE_var_LoadoutVehicle",objNull];

private _cfgLoadoutCtrls = missionConfigFile >> "DALE_RscLoadout" >> "controls";
private _ctrlPreset = _display displayCtrl getNumber (_cfgLoadoutCtrls >> "comboPreset" >> "idc");
_ctrlPreset lbSetCurSel 0;