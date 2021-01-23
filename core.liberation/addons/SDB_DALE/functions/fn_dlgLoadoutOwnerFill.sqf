disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _ctrl = param [0,controlNull,[controlNull]];
private _index = param [1,0,[0]];
private _display = ctrlParent _ctrl;
private _veh = _display getVariable ["DALE_var_LoadoutVehicle",objNull];

private _path = [_veh,1+_index] call DALE_fnc_getPylonTurret;
private _textNew = ["driver","gunner"] select (_path isEqualTo [0]);

_ctrl setVariable ["DALE_var_ButtonOwner",_textNew];
_ctrl ctrlSetText getText (missionConfigFile >> "DALE_RscLoadout" >> ("icon"+_textNew));

_ctrl ctrlEnable ([0] in allTurrets _veh);