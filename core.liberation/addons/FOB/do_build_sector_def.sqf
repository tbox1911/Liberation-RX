// LRX Sector Defense
// by pSiKO

private _fob = (player nearObjects [FOB_typename, 20] select 0);
if (isNil "_fob") exitWith {};

createDialog "Sector_Defense";
waitUntil { dialog };

private _display = findDisplay 2310;
private _icon = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
private ["_selected_item", "_text", "_defense_type", "_sector", "_sector_name"];
private _defense_list = ["None", "Light", "Medium", "Heavy"];

private _getDefenseType = {
    params ["_sector"];
    private _ret = 0;
    private _index = { if ((_x select 0) == _sector) exitWith { _forEachIndex } } forEach GRLIB_sector_defense;
    if (!isNil "_index") then {
        _ret = GRLIB_sector_defense select _index select 1;
    };
    (_defense_list select _ret);
};

private _setDefenseType = {
    params ["_sector", "_defense"];
    private _index = { if ((_x select 0) == _sector) exitWith { _forEachIndex } } forEach GRLIB_sector_defense;
    if (isNil "_index" && _defense == 0) exitWith {""};
    if (isNil "_index" && _defense > 0) exitWith {
        GRLIB_sector_defense pushBack [ _sector, _defense];
        _defense_list select _defense;
    };
    if (_defense == 0) exitWith {
        GRLIB_sector_defense deleteAt _index;
        "";
    };
    GRLIB_sector_defense set [_index, [_sector, _defense]];
   (_defense_list select _defense);
};

build_action = 0;
build_type = 0;
private _refresh = true;

while { dialog && alive player } do {
    if (_refresh) then {
        lbClear 110;
        {
            _text = [_x] call F_getLocationName;
            _defense_type = [str _x] call _getDefenseType;
            (_display displayCtrl (110)) lnbAddRow [_text, _defense_type];
            lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
            lnbSetData [110, [((lnbSize 110) select 0) - 1, 0], str _x];
        } forEach GRLIB_all_fobs;

        {
            if !(_x in active_sectors) then {
                _text = (markerText _x);
                _defense_type = [_x] call _getDefenseType;
                (_display displayCtrl (110)) lnbAddRow [_text, _defense_type];
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
        _defense_type = [_sector, build_type] call _setDefenseType;
        if (_defense_type == "") then {
            gamelogic globalChat format ["You Remove Defenses from %1.", _sector_name];
        } else {
            gamelogic globalChat format ["You Set %1 Defenses on %2.", _defense_type, _sector_name];
        };
        build_action = 0;
        _refresh = true;
    };
    sleep 0.2;
};

// if (build_action == 0) exitWith {};
// if (!([parseNumber _defense_price] call F_pay)) exitWith {};
// gamelogic globalChat format ["Set %1 Defense on %2.", _defense_type, _sector_name];
