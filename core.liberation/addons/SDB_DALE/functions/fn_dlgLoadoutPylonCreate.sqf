disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _display = param [0,displayNull,[displayNull]];
private _veh = _display getVariable ["DALE_var_LoadoutVehicle",objNull];
private _cfgVeh = configFile >> "CfgVehicles" >> typeOf _veh;
private _cfgComponent = _cfgVeh >> "Components" >> "TransportPylonsComponent";

private _cfgLoadoutCtrls = missionConfigFile >> "DALE_RscLoadout" >> "controls";
private _imgW = getNumber (_cfgLoadoutCtrls >> "picture" >> "w");
private _imgH = getNumber (_cfgLoadoutCtrls >> "picture" >> "h");

private _cfgButton = missionConfigFile >> "DALE_RscButton";
private _buttonW = getNumber (_cfgButton >> "w");
private _buttonH = getNumber (_cfgButton >> "h");
private _buttonIdc = getNumber (_cfgButton >> "idc");

private _cfgCombo = missionConfigFile >> "DALE_RscCombo";
private _comboW = getNumber (_cfgCombo >> "w");
private _comboH = getNumber (_cfgCombo >> "h");
private _comboIdc = getNumber (_cfgCombo >> "idc");

{
	private _offsets = getArray (_x >> "UIposition");
	private _offsetX = safeZoneW * ((_offsets select 0) call BIS_fnc_parseNumber);
	private _offsetY = safeZoneH * ((_offsets select 1) call BIS_fnc_parseNumber);
	private _posX = safezoneX + safezoneW*0.500 + _offsetX - _imgW/2 - _comboW/2;
	private _posY = safezoneY + safezoneH*0.525 + _offsetY - _imgH/2 - _comboH/2;
	
	private _button = _display ctrlCreate ["DALE_RscButton",_buttonIdc+_forEachIndex];
	_button ctrlSetPosition [_posX,_posY,_buttonW,_buttonH];
	_button ctrlCommit 0;
	[_button,_forEachIndex] call DALE_fnc_dlgLoadoutOwnerFill;
	_button ctrlAddEventHandler ["ButtonDown",DALE_fnc_dlgLoadoutOwnerChange];
	
	private _combo = _display ctrlCreate ["DALE_RscCombo",_comboIdc+_forEachIndex];
	_combo ctrlSetPosition [_posX+_buttonW,_posY,_comboW-_buttonW,_comboH];
	_combo ctrlCommit 0;
	[_combo,_forEachIndex] call DALE_fnc_dlgLoadoutPylonFill;
	_combo ctrlAddEventHandler ["LBSelChanged",DALE_fnc_dlgLoadoutPylonChange];
} forEach ("isClass _x" configClasses (_cfgComponent >> "Pylons"));