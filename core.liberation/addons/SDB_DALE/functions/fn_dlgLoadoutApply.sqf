disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _ctrl = param [0,controlNull,[controlNull]];
private _display = ctrlParent _ctrl;
private _veh = _display getVariable ["DALE_var_loadoutVehicle",objNull];

private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";

private _cfgLoadoutCtrls = missionConfigFile >> "DALE_RscLoadout" >> "controls";
private _ctrlPreset = _display displayCtrl getNumber (_cfgLoadoutCtrls >> "comboPreset" >> "idc");
private _ctrlPriority = _display displayCtrl getNumber (_cfgLoadoutCtrls >> "comboPriority" >> "idc");
private _cfgButton = missionConfigFile >> "Dale_RscButton";
private _buttonIdc = getNumber (_cfgButton >> "idc");
private _cfgCombo = missionConfigFile >> "Dale_RscCombo";
private _comboIdc = getNumber (_cfgCombo >> "idc");

// Get pylon loadout magazines & turrets
private _pylonMagazines = [];
private _pylonPaths = [];
{
	private _combo = _display displayCtrl (_comboIdc+_forEachIndex);
	private _button = _display displayCtrl (_buttonIdc+_forEachIndex);
	private _index = lbCurSel _combo;
	private _role = _button getVariable ["DALE_var_ButtonOwner","driver"];
	_pylonMagazines pushBack (["",_combo lbData _index] select (_index > -1));
	_pylonPaths pushBack ([[],[0]] select (_role == "gunner"));
} forEach ("isClass _x" configClasses (_cfgComponent >> "Pylons"));

// Save variables to vehicle
_veh setVariable ["DALE_var_loadoutPreset",lbCurSel _ctrlPreset,true];
_veh setVariable ["DALE_var_loadoutPriority",lbCurSel _ctrlPriority,true];

// Apply pylon loadout to vehicle
[_veh,_pylonMagazines,_pylonPaths] remoteExec ["DALE_fnc_setPylonLoadout",2,false];

_display closeDisplay 0;