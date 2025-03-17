// LRX Sector Defenses
// by pSiKO

createDialog "Sector_Defense";
waitUntil { dialog };

private _display = findDisplay 2310;
private _icon = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
private ["_selected_item", "_text", "_defense_type", "_sector", "_sector_name"];
private _defense_list = ["None", "Light", "Medium", "Heavy"];
private _max_defense = 6;

private _butons_id = [120, 121, 122, 123];
(_display displayCtrl 120) ctrlSetToolTip localize "STR_FOB_REMOVE_GARRISON_TOOLTIP";
(_display displayCtrl 121) ctrlSetToolTip format [localize "STR_FOB_SET_LIGHT_GARRISON", GRLIB_defense_costs select 1];
(_display displayCtrl 122) ctrlSetToolTip format [localize "STR_FOB_SET_MEDIUM_GARRISON", GRLIB_defense_costs select 2];
(_display displayCtrl 123) ctrlSetToolTip format [localize "STR_FOB_SET_HEAVY_GARRISON", GRLIB_defense_costs select 3];

private _score = [player] call F_getScore;
if (_score < GRLIB_perm_log) then {
    ctrlEnable [122, false];
    _butons_id = _butons_id - [122];
};
if (_score < GRLIB_perm_air) then {
    ctrlEnable [123, false];
    _butons_id = _butons_id - [123];
};

build_action = 0;
build_type = 0;
private _refresh = true;
private _sectors_def = [];
while { dialog && alive player } do {
    if (_refresh) then {
        _sectors_def = [];
        lbClear 110;
        {
            _text = [_x] call F_getLocationName;
            _sector = format ["fobmarker%1", _forEachIndex];
            _defense_type = [_sector] call F_getDefenseType;
            lnbAddRow [110, [_text, (_defense_list select _defense_type)]];
            lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
            lnbSetData [110, [((lnbSize 110) select 0) - 1, 0], _sector];
            _sectors_def pushback _sector;
        } forEach GRLIB_all_fobs;

        {
            _text = (markerText _x);
            _defense_type = [_x] call F_getDefenseType;
            lnbAddRow [110, [_text, (_defense_list select _defense_type)]];
            lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
            lnbSetData [110, [((lnbSize 110) select 0) - 1, 0], _x];
            _sectors_def pushback _x;
        } foreach (blufor_sectors - active_sectors);
        //lbSetCurSel [110, -1];
        _refresh = false;
    };

    sleep 0.2;

    if (build_action != 0) then {
        { ctrlEnable [_x, false] } forEach _butons_id;
        _selected_item = lbCurSel 110;
        _sector = (_display displayCtrl (110)) lnbData [_selected_item, 0];
        _sector_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];

        if (build_type == 0) then {
            [_sector, 0] remoteExec ["sector_defenses_remote_call", 2];
            gamelogic globalChat format [localize "STR_FOB_REMOVE_GARRISON_CONFIRM", _sector_name];
        } else {
            if (count GRLIB_sector_defense < _max_defense) then {
                [_sector, build_type] remoteExec ["sector_defenses_remote_call", 2];
                private _msg = format [localize "STR_FOB_PLAYER_SET_GARRISON", name player, (_defense_list select build_type), _sector_name];
                [gamelogic, _msg] remoteExec ["globalChat", 0];
            } else {
                gamelogic globalChat format [localize "STR_FOB_MAX_GARRISON_REACHED", _max_defense];
            };
        };
        sleep 1;
        { ctrlEnable [_x, true] } forEach _butons_id;
        build_action = 0;
        _refresh = true;
    };

    if (count _sectors_def != count GRLIB_sector_defense) then { _refresh = true };
};
