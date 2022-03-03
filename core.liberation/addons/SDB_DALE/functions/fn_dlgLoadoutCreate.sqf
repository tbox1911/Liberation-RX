disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _veh = param [0,objNull,[objNull]];
private _cfgVeh = configFile >> "CfgVehicles" >> typeOf _veh;
private _cfgComponent = _cfgVeh >> "Components" >> "TransportPylonsComponent";
private _selectedPreset = _veh getVariable ["DALE_var_LoadoutPreset",0];
private _selectedPriority = _veh getVariable ["DALE_var_LoadoutPriority",0];

private _dlgLoadout = "DALE_RscLoadout";
createDialog _dlgLoadout;
private _display = uiNamespace getVariable [_dlgLoadout,displayNull];

private _cfgLoadoutCtrls	= missionConfigFile >> _dlgLoadout >> "controls";
private _ctrlText			= _display displayCtrl getNumber (_cfgLoadoutCtrls >> "title" >> "idc");
private _ctrlImg			= _display displayCtrl getNumber (_cfgLoadoutCtrls >> "picture" >> "idc");
private _ctrlPreset			= _display displayCtrl getNumber (_cfgLoadoutCtrls >> "comboPreset" >> "idc");
private _ctrlPriority		= _display displayCtrl getNumber (_cfgLoadoutCtrls >> "comboPriority" >> "idc");

// Set title and background image
private _text = parseText format ["<t align = 'left'>%1</t><t align = 'right'>%2</t>",getText (_cfgVeh >> "displayName"),profileName];
private _img = getText (_cfgComponent >> "uiPicture");
_ctrlText ctrlSetStructuredText _text;
_ctrlImg ctrlSetText _img;

// Fill preset combobox
_ctrlPreset lbSetData [_ctrlPreset lbAdd (localize "STR_DALE_Dialogs_Custom"),""];
{
	_ctrlPreset lbSetData [_ctrlPreset lbAdd getText (_x >> "displayName"),configName _x];
} forEach ("isClass _x" configClasses (_cfgComponent >> "Presets"));
_ctrlPreset lbSetCurSel _selectedPreset;
_ctrlPreset ctrlAddEventHandler ["LBSelChanged",DALE_fnc_dlgLoadoutChangePreset];

// Fill priority combobox
{_ctrlPriority lbAdd (localize _x );} forEach ["STR_DALE_Dialogs_Single","STR_DALE_Dialogs_Double","STR_DALE_Dialogs_Burst"];
_ctrlPriority lbSetCurSel _selectedPriority;
_ctrlPriority ctrlAddEventHandler ["LBSelChanged",DALE_fnc_dlgLoadoutChangePriority];

// Save vehicle to displayNamespace
_display setVariable ["DALE_var_LoadoutVehicle",_veh];

_display;