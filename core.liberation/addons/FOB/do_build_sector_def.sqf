// LRX Sector Defense
// by pSiKO

private _fob = (player nearObjects [FOB_typename, 20] select 0);
if (isNil "_fob") exitWith {};

createDialog "Sector_Defense";
waitUntil { dialog };

private _display = findDisplay 2310;
private _icon = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
private ["_selected_item", "_entrytext", "_sector_name", "_defense_type"];

//check sector defense type

build_action = 0;
build_type = 0;

private _refresh = true;
while { dialog && alive player } do {
    if (_refresh) then {
        _refresh = false;
        lbClear 110;
        // add FOB
        {
            _entrytext = [_x] call F_getLocationName;
            (_display displayCtrl (110)) lnbAddRow [_entrytext, "None"];
            lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
        } forEach GRLIB_all_fobs;

        // add Sectors
        {
            _entrytext = (markerText _x);
            (_display displayCtrl (110)) lnbAddRow [_entrytext, "None"];
            lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
        } foreach blufor_sectors;
        lbSetCurSel [110, -1];

    };


    if (build_action != 0) then {
        _selected_item = lbCurSel 110;
        _sector_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];
        _defense_type = (_display displayCtrl (110)) lnbText [_selected_item, 1];
        if (_selected_item > 0) then {
            //_defense_template = GRLIB_FOB_Defense select _selected_item select 1;
            //_objects_to_build = ([] call compile preprocessFileLineNumbers _defense_template);
        };
        closeDialog 0;
    };
    sleep 0.2;
};

if (build_action == 0) exitWith {};

//if (!([parseNumber _defense_price] call F_pay)) exitWith {};
gamelogic globalChat format ["Set Defense type %1 on %2", _defense_type, _sector_name];

// Set Defense

// GRLIB_sector_defense ["sectorname", type of def (0,1,2,3)]