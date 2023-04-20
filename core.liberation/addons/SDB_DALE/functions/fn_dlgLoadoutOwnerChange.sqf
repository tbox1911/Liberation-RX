disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _ctrl = param [0,controlNull,[controlNull]];
private _display = ctrlParent _ctrl;
private _veh = _display getVariable ["DALE_var_LoadoutVehicle",objNull];

private _text = _ctrl getVariable ["DALE_var_ButtonOwner",""];
private _textNew = ["driver","gunner"] select (_text == "driver");

_ctrl setVariable ["DALE_var_ButtonOwner",_textNew];
_ctrl ctrlSetText getText (missionConfigFile >> "DALE_RscLoadout" >> ("icon"+_textNew));