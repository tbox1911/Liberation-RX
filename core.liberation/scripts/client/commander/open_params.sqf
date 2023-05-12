private ["_nextparam", "_idx", "_control", "_selection", "_value", "_value_raw", "_save_data"];

waitUntil {!(isNull (findDisplay 46))};
disableUserInput false;
disableUserInput true;
disableUserInput false;

if ( !([] call is_admin) && GRLIB_param_open_params == 1) then {
	waitUntil {
		titleText ["... Waiting for LRX Configuration ...", "BLACK FADED", 100];
		uIsleep 2;
		titleText ["... Please Wait ...", "BLACK FADED", 100];
		uIsleep 2;
		GRLIB_param_open_params == 0;
	};
	titleText ["", "BLACK FADED", 100];
};
if !([] call is_admin) exitWith {};

createDialog "liberation_params";
disableSerialization;
waitUntil { dialog };

private _display = findDisplay 5119;
private _noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

private _lrx_getParamData = {
	params ["_param"];
	private _def = ["Unknown!", ["---"], []];
	{
		if (_x select 0 == _param) exitWith { _def = [_x select 1, _x select 2, _x select 3] };
	} forEach LRX_Mission_Params_Def;
	_def;
};

private _params_save = profileNamespace getVariable format ["%1-config", GRLIB_save_key];
private _params_array = [];
param_id = -1;
param_value = -1;
save_changes = 0;

{
	_data = [_x select 0] call _lrx_getParamData;
	_name = _data select 0;
	_values =  _data select 1;
	_values_raw = _data select 2;
	if (isNil "_values_raw") then {_values_raw = []};
	_params_array pushback [ _x select 0, _x select 1, _forEachIndex + 1, _name, _values, _values_raw ];
} foreach _params_save;

{
	_nextparam = _x;
	_idx = _nextparam select 2;

	if ( _idx % 2 == 0 ) then {
		_control = _display ctrlCreate [ "RscBackground", -1, _display displayCtrl 9969 ];
		_control ctrlSetPosition [ 0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025 * safezoneH];
		_control ctrlSetBackgroundColor [0.75,1,0.75,0.12];
		_control ctrlCommit 0;
	};

	_control = _display ctrlCreate [ "RscText", (100 + _idx), _display displayCtrl 9969 ];
	_control ctrlSetPosition [ 0,  (_idx * 0.025) * safezoneH, 0.3 * safeZoneW, 0.025  * safezoneH];
	_control ctrlSetText (_nextparam select 3);
	_control ctrlCommit 0;

	_control = _display ctrlCreate [ "RscCombo", (200 + _idx), _display displayCtrl 9969 ];
	_control ctrlSetPosition [ ((0.072 * 7) - 0.02) * safeZoneW, ((_idx * 0.025) * safezoneH) + 0.0025, (0.095 * safeZoneW), 0.022  * safezoneH];
	_control ctrlSetBackgroundColor [0.2,0.23,0.18,0.85];
	if ( _idx % 2 == 0 ) then {
		 _control ctrlSetBackgroundColor [0.27,0.30,0.23,0.85];
	};
	{ _control lbAdd _x } forEach (_nextparam select 4);

	_selection = _nextparam select 1;
	if (count (_nextparam select 5) > 0) then {
		_selection = (_nextparam select 5) find _selection;
	};
	_control lbSetCurSel _selection;

	_control ctrlAddEventHandler ["LBSelChanged", {
		params ["_control", "_lbCurSel"];
		param_id = (ctrlIDC _control) - 201;
		param_value = _lbCurSel;
	}];
	_control ctrlCommit 0;
} foreach _params_array;

while { dialog && alive player } do {

	if (param_id != -1) then {
		_value = param_value;
		_value_raw = _params_array select param_id select 5;
		if (count _value_raw > 0) then {
			_value = _value_raw select param_value;
		};
		_save_data = _params_save select param_id;
		_save_data set [1, _value];
		_params_save set [param_id, _save_data];
		param_id = -1;
	};

	if ( save_changes == 1 ) then {
		save_changes = 0;
		[
			[_params_save],
			{
				params ["_params"];
				profileNamespace setVariable [format ["%1-config", GRLIB_save_key], _params];
				GRLIB_param_open_params = 0;
				publicVariable "GRLIB_param_open_params";
			}
		] remoteExec ["bis_fnc_call", 2];

		waitUntil { sleep 1; GRLIB_param_open_params == 0 };
		closeDialog 0;
	};

	sleep 0.5;
};

disableUserInput true;
_display displayRemoveEventHandler ["KeyDown", _noesckey];
