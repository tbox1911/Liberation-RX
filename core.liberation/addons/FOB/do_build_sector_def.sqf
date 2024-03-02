// LRX Sector Defenses
// by pSiKO

createDialog "Sector_Defense";
waitUntil { dialog };

private _display = findDisplay 2310;
private _icon = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
private ["_selected_item", "_text", "_defense_type", "_sector", "_sector_name"];
private _defense_list = ["None", "Light", "Medium", "Heavy"];
private _max_defense = 6;

(_display displayCtrl 120) ctrlSetToolTip "Remove Defenses.";
(_display displayCtrl 121) ctrlSetToolTip format ["Set Light Defenses for %1 Ammo.", GRLIB_defense_costs select 1];
(_display displayCtrl 122) ctrlSetToolTip format ["Set Medium Defenses for %1 Ammo.", GRLIB_defense_costs select 2];
(_display displayCtrl 123) ctrlSetToolTip format ["Set Heavy Defenses for %1 Ammo.", GRLIB_defense_costs select 3];

private _score = [player] call F_getScore;
if (_score < GRLIB_perm_log) then { ctrlEnable [122, false] };
if (_score < GRLIB_perm_air) then { ctrlEnable [123, false] };

build_action = 0;
build_type = 0;
private _refresh = true;

while { dialog && alive player } do {
    if (_refresh) then {
        lbClear 110;
        {
            _text = [_x] call F_getLocationName;
            _defense_type = [str _x] call F_getDefenseType;
            lnbAddRow [110, [_text, (_defense_list select _defense_type)]];
            lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
            lnbSetData [110, [((lnbSize 110) select 0) - 1, 0], str _x];
        } forEach GRLIB_all_fobs;

        {
            if !(_x in active_sectors) then {
                _text = (markerText _x);
                _defense_type = [_x] call F_getDefenseType;
                lnbAddRow [110, [_text, (_defense_list select _defense_type)]];
                lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
                lnbSetData [110, [((lnbSize 110) select 0) - 1, 0], _x];
            };                
        } foreach blufor_sectors;
        //lbSetCurSel [110, -1];
        _refresh = false;        
    };

    if (build_action != 0) then {
        _selected_item = lbCurSel 110;
        _sector = (_display displayCtrl (110)) lnbData [_selected_item, 0];
        _sector_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];
        [_sector, build_type] remoteExec ["sector_defenses_remote_call", 2];

        if (build_type == 0) then {
            [_sector, build_type] remoteExec ["sector_defenses_remote_call", 2];
            gamelogic globalChat format ["You Remove Defenses from %1.", _sector_name];
        } else {
            if (count GRLIB_sector_defense < _max_defense ) then {
                [_sector, build_type] remoteExec ["sector_defenses_remote_call", 2];
                gamelogic globalChat format ["You Set %1 Defenses on %2.", (_defense_list select build_type), _sector_name];
            } else {
                gamelogic globalChat format ["You reach the Maximum Defenses limit (%1)!", _max_defense];
            };
        };
        sleep 0.3;
        build_action = 0;
        _refresh = true;
    };
    sleep 0.2;
};
