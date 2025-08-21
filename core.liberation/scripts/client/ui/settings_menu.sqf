if (isDedicated || !hasInterface) exitWith {};

GRLIB_SetupParamMenu = {
    if (!dialog || !GRLIB_DialogOpen || !hasInterface) exitWith {};
    GRLIB_ParamControls = [];
    _display = findDisplay 5119;
    _idx = 1;

    {
        _category = _x;
        _paramArray = GRLIB_groupedParams get _category;
        if (!isNil "_paramArray") then {
            _control = _display ctrlCreate [ "RscBackground", -1, _display displayCtrl 9969 ];
            _control ctrlSetPosition [ 0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025 * safezoneH];
            _control ctrlSetBackgroundColor [0,0,0.80,0.12];
            _control ctrlCommit 0;
            GRLIB_ParamControls pushBack _control;

            _control = _display ctrlCreate [ "RscText", (100 + _idx), _display displayCtrl 9969 ];
            _control ctrlSetPosition [ 0,  (_idx * 0.025) * safezoneH, 0.5 * safeZoneW, 0.025  * safezoneH];
            _control ctrlSetText format ["%1 %2 %1", GRLIB_PARAM_separatorKey, _category];
            _control ctrlCommit 0;
            GRLIB_ParamControls pushBack _control;

            _idx = _idx + 1;

            {
                _key = _x select 0;
                _hash = _x select 1;
                if ( _idx % 2 == 0 ) then {
                    _control = _display ctrlCreate [ "RscBackground", -1, _display displayCtrl 9969 ];
                    _control ctrlSetPosition [ 0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025 * safezoneH];
                    _control ctrlSetBackgroundColor [0.75,1,0.75,0.12];
                    _control ctrlCommit 0;
                    GRLIB_ParamControls pushBack _control;
                };
                _control = _display ctrlCreate [ "RscText", (100 + _idx), _display displayCtrl 9969 ];
                _control ctrlSetPosition [ 0,  (_idx * 0.025) * safezoneH, 0.45 * safeZoneW, 0.025  * safezoneH];
                _control ctrlSetText (_hash get GRLIB_PARAM_NameKey);
                _description = _hash get GRLIB_PARAM_DescriptionKey;
                if (!isNil "_description") then {
                    _control ctrlSetTooltip _description;
                };
                _control ctrlCommit 0;
                GRLIB_ParamControls pushBack _control;

                _control = _display ctrlCreate [ "RscCombo", (200 + _idx), _display displayCtrl 9969 ];
                _control ctrlSetPosition [ ((0.072 * 6.5) - 0.02) * safeZoneW, ((_idx * 0.025) * safezoneH) + 0.0025, ((0.072 * 2) * safeZoneW), 0.022  * safezoneH];
                _control ctrlSetBackgroundColor [0.2,0.23,0.18,0.85];
                if ( _idx % 2 == 0 ) then {
                    _control ctrlSetBackgroundColor [0.27,0.30,0.23,0.85];
                };
                GRLIB_ParamControls pushBack _control;

                {
                    _control lbAdd _x;
                } forEach (_hash get GRLIB_PARAM_OptionLabelKey);
                _optionDescription = _hash getOrDefault [GRLIB_PARAM_OptionDescriptionKey, []];
                {
                    _control lbSetTooltip [_forEachIndex, _x];
                } forEach _optionDescription;

                _default = _hash get GRLIB_PARAM_ValueKey;
                _selection = (GRLIB_ModParams getOrDefault [_key, _hash]) getOrDefault [GRLIB_PARAM_ValueKey, _default];
                _values = _hash get GRLIB_PARAM_OptionValuesKey;
                if (count (_values) > 0) then {
                    _selection = (_values) find _selection;
                    if (_selection == -1) then { _selection = 0 };
                };
                _control lbSetCurSel _selection;
                _control ctrlAddEventHandler ["LBSelChanged", format ["[(_this#1),%1] call GRLIB_SetValue;", str _key]];
                _control ctrlCommit 0;
                _idx = _idx + 1;
            } forEach _paramArray;
        };
    } foreach GRLIB_PARAM_CatOrder;

};

GRLIB_SetValue = {
    if (!dialog || !GRLIB_DialogOpen || !hasInterface) exitWith {};
    params ["_lbCurSel", "_key"];
    _parHash = LRX_Mission_Params get _key;
    _values = _parHash get GRLIB_PARAM_OptionValuesKey;
    _newValue = _values#_lbCurSel;
    GRLIB_ModParams set [_key, createHashMapFromArray [[GRLIB_PARAM_ValueKey, _newValue]]];
};

GRLIB_CreateParamDialog = {
    if (!hasInterface) exitWith {};
    closeDialog 0;
    GRLIB_DialogOpen = true;
    createDialog "liberation_params";
    waitUntil { dialog };
    _display = findDisplay 5119;
    (findDisplay 5119) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { [] call GRLIB_cancelParams; (findDisplay 5119) displayRemoveEventHandler ['KeyDown', _thisEventHandler];  }"];
    _control = _display ctrlCreate ["RscText", (100 + 0), _display displayCtrl 9969];
    _control ctrlSetPosition [0,  (0 * 0.025) * safezoneH, 0.3 * safeZoneW, 0.025  * safezoneH];
    _control ctrlSetText format ["Parameters Profile name: %1", GRLIB_paramsV2_save_key];
    _control ctrlSetTextColor [0.5,0.5,0.5,1];
    _control ctrlCommit 0;
    GRLIB_ModParams = +GRLIB_LRX_params;
    [] call GRLIB_SetupParamMenu;
};

GRLIB_refreshDialog = {
    if (!dialog || !GRLIB_DialogOpen || !hasInterface) exitWith {};
    // Reset the dialog without closing it
    {
        ctrlDelete _x;
    } forEach GRLIB_ParamControls;
    [] call GRLIB_SetupParamMenu;
};

GRLIB_resetParams = {
    if (!dialog || !GRLIB_DialogOpen || !hasInterface) exitWith {};
    GRLIB_ModParams = ([] call GRLIB_DefaultParams);
    [] call GRLIB_refreshDialog;
};

GRLIB_cancelParams = {
    if (!dialog || !GRLIB_DialogOpen || !hasInterface) exitWith {};
    [] call GRLIB_CloseDialog;
    private _mod_west = [GRLIB_PARAM_ModPresetWest] call lrx_getParamValue;
    private _mod_east = [GRLIB_PARAM_ModPresetEast] call lrx_getParamValue;
    private _lrx_liberation_savegame = profileNamespace getVariable [GRLIB_save_key, nil];
    private _side_west = _lrx_liberation_savegame select 7;
	private _side_east = _lrx_liberation_savegame select 8;
    private _prefly_check = (
		(typeName _mod_west != "STRING" || typeName _mod_east != "STRING") ||
		(_mod_west == "---" || _mod_east == "---") ||
		(GRLIB_mod_list_west find _mod_west < 0 || GRLIB_mod_list_east find _mod_east < 0) ||
		(([_mod_west, _mod_east] findIf {!([_x] call GRLIB_Template_Modloaded)}) != -1) ||
        (GRLIB_force_load == 0 && (_side_west != _mod_west || _side_east != _mod_east))
	);
	if (_prefly_check) then { ["LOSER"] remoteExec ["endMission", 0] };
    GRLIB_ParamsInitialized = true;
    publicVariable "GRLIB_ParamsInitialized";
};

GRLIB_saveParams = {
    if (!dialog || !GRLIB_DialogOpen || !hasInterface) exitWith {};
    [] call GRLIB_CloseDialog;
    [
        [GRLIB_ModParams],
        {
            params ["_params"];
            profileNamespace setVariable [GRLIB_paramsV2_save_key, _params];
            saveProfileNamespace;
            GRLIB_LRX_params = _params;
            publicVariable "GRLIB_LRX_params";
            GRLIB_ParamsInitialized = true;
            publicVariable "GRLIB_ParamsInitialized";
        }
    ] remoteExec ["bis_fnc_call", 2];

    waitUntil { sleep 0.5; GRLIB_ParamsInitialized};

    // If dialog opened mid-game - we may be able to upgrade this to modify variables mid-game
    if (!(isNil "GRLIB_init_server")) then {
        [localize "STR_MISSION_RESTART_REQUIRED",localize "STR_LRX_SETTINGS_TITLE",true] call BIS_fnc_guiMessage;
    };
};

GRLIB_CloseDialog = {
    if (!dialog || !GRLIB_DialogOpen || !hasInterface) exitWith {};
    GRLIB_DialogOpen = false;
    closeDialog 0;
};
