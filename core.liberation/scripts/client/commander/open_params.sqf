private ["_selection", "_value", "_value_raw", "_data", "_save_data", "_category", "_groupParams", "_paramArray"];

waitUntil {!(isNull (findDisplay 46))};
disableUserInput false;
disableUserInput true;
disableUserInput false;

if ( !([] call is_admin) && GRLIB_param_open_params == 1) then {
	waitUntil {
		titleText [localize "STR_WAITING_FOR_LRX_CONFIG", "BLACK FADED", 100];
		uIsleep 2;
		titleText [localize "STR_PLEASE_WAIT", "BLACK FADED", 100];
		uIsleep 2;
		GRLIB_param_open_params == 0;
	};
	titleText ["", "BLACK FADED", 100];
};
if !([] call is_admin) exitWith { disableUserInput true };

waitUntil { sleep 0.5; !isNil "GRLIB_LRX_params" };

createDialog "liberation_params";
waitUntil { dialog };

private _display = findDisplay 5119;
private _noesckey = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

private _control = _display ctrlCreate ["RscText", (100 + 0), _display displayCtrl 9969];
_control ctrlSetPosition [0,  (0 * 0.025) * safezoneH, 0.3 * safeZoneW, 0.025  * safezoneH];
_control ctrlSetText format ["Parameters Profile name: %1", GRLIB_paramsV2_save_key];
_control ctrlSetTextColor [0.5,0.5,0.5,1];
_control ctrlCommit 0;

// Group the parameters by category
private _groupedParams = createHashMap;
{
	_key = _x;
	_hash = _y;
	_category = _hash get GRLIB_PARAM_CategoryKey;
	_groupParams = _groupedParams getOrDefault [_category, []];
	_groupParams pushBack [_key, _hash];
	_groupedParams set [_category, _groupParams];
} forEach LRX_Mission_Params;

private _idx = 1;
save_changes = 0;

{
	_category = _x;
	_paramArray = _groupedParams get _category;
	if (!isNil "_paramArray") then {
		_control = _display ctrlCreate [ "RscBackground", -1, _display displayCtrl 9969 ];
		_control ctrlSetPosition [ 0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025 * safezoneH];
		_control ctrlSetBackgroundColor [0,0,0.80,0.12];
		_control ctrlCommit 0;

		_control = _display ctrlCreate [ "RscText", (100 + _idx), _display displayCtrl 9969 ];
		_control ctrlSetPosition [ 0,  (_idx * 0.025) * safezoneH, 0.3 * safeZoneW, 0.025  * safezoneH];
		_control ctrlSetText format ["%1 %2 %1", GRLIB_PARAM_separatorKey, _category];
		_control ctrlCommit 0;

		_idx = _idx + 1;

		{
			_key = _x select 0;
			_hash = _x select 1;
			if ( _idx % 2 == 0 ) then {
				_control = _display ctrlCreate [ "RscBackground", -1, _display displayCtrl 9969 ];
				_control ctrlSetPosition [ 0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025 * safezoneH];
				_control ctrlSetBackgroundColor [0.75,1,0.75,0.12];
				_control ctrlCommit 0;
			};	
			_control = _display ctrlCreate [ "RscText", (100 + _idx), _display displayCtrl 9969 ];
			_control ctrlSetPosition [ 0,  (_idx * 0.025) * safezoneH, 0.3 * safeZoneW, 0.025  * safezoneH];
			_control ctrlSetText (_hash get GRLIB_PARAM_NameKey);
			_control ctrlCommit 0;

			_control = _display ctrlCreate [ "RscCombo", (200 + _idx), _display displayCtrl 9969 ];
			_control ctrlSetPosition [ ((0.072 * 6.5) - 0.02) * safeZoneW, ((_idx * 0.025) * safezoneH) + 0.0025, ((0.072 * 2) * safeZoneW), 0.022  * safezoneH];
			_control ctrlSetBackgroundColor [0.2,0.23,0.18,0.85];
			if ( _idx % 2 == 0 ) then {
				_control ctrlSetBackgroundColor [0.27,0.30,0.23,0.85];
			};
			{ _control lbAdd _x } forEach (_hash get GRLIB_PARAM_OptionLabelKey);

			_default = _hash get GRLIB_PARAM_ValueKey;
			_selection = (GRLIB_LRX_params getOrDefault [_key, _hash]) getOrDefault [GRLIB_PARAM_ValueKey, _default];
			_values = _hash get GRLIB_PARAM_OptionValuesKey;
			if (count (_values) > 0) then {
				_selection = (_values) find _selection;
				if (_selection == -1) then { _selection = 0 };
			};
			_control lbSetCurSel _selection;
			_control ctrlAddEventHandler ["LBSelChanged", compile ('params ["_control", "_lbCurSel"]; _key = ' + str _key + '; 
				_parHash = (LRX_Mission_Params get _key);
				_saveHash = GRLIB_LRX_params getOrDefault [_key, (LRX_Mission_Params get _key)];
				_values = _parHash get GRLIB_PARAM_OptionValuesKey;
				_newValue = _values select _lbCurSel;
				_saveHash set [GRLIB_PARAM_ValueKey, _newValue];
				GRLIB_LRX_params set [_key, _saveHash];')];

			_description = _hash get GRLIB_PARAM_DescriptionKey;
			if (!isNil "_description") then {
				_control ctrlSetTooltip _description;
			};

			_control ctrlCommit 0;
			_idx = _idx + 1;
		} forEach _paramArray;
	};
} foreach GRLIB_PARAM_CatOrder;

waitUntil { sleep 0.5; !dialog || !(alive player) };
if (save_changes == 1) then {
	[
		[],
		{
			profileNamespace setVariable [GRLIB_paramsV2_save_key, GRLIB_LRX_params];
			saveProfileNamespace;
			publicVariable "GRLIB_LRX_params";
			GRLIB_param_open_params = 0;
			publicVariable "GRLIB_param_open_params";
		}
	] remoteExec ["bis_fnc_call", 2];

	waitUntil { sleep 0.5; GRLIB_param_open_params == 0 };
	if !(isNil "GRLIB_init_server") then {
		[localize "STR_MISSION_RESTART_REQUIRED",localize "STR_LRX_SETTINGS_TITLE",true] call BIS_fnc_guiMessage;
	};
};

disableUserInput true;
_display displayRemoveEventHandler ["KeyDown", _noesckey];
