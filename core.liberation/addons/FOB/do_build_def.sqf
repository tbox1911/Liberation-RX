// LRX FOB Defense
// by pSiKO

private _fob_sign = player nearObjects [FOB_sign, 20] select 0;
if (isNil "_fob_sign") exitWith {};

private _fob_class = _fob_sign getVariable ["GRLIB_fob_type", FOB_typename];
private _fob = (player nearObjects [_fob_class, 20] select 0);
if (isNil "_fob") exitWith {};

private _fob_pos = getPosATL _fob;
private _fob_dir = (getDir _fob_sign - 90);

private _walls = count (_fob_pos nearObjects ["Wall_F", GRLIB_fob_range]);
_walls = _walls + count (_fob_pos nearObjects ["HBarrier_base_F", GRLIB_fob_range]);
if (_walls > 10) exitWith { hint localize "STR_FOB_CONSTRUCTION_TOO_MANY_WALLS" };

createDialog "FOB_Defense";
waitUntil { dialog };

private _input_controls = [521,522,523,524,525,526,527];
{ ctrlShow [_x, false] } foreach _input_controls;

private _display = findDisplay 2309;
private _icon = getMissionPath "res\ui_build.paa";
private ["_selected_item", "_text", "_defense_template", "_template_creator", "_defense_name", "_defense_price"];

lbClear 110;
{
    _text = (_x select 0);
    _defense_price = (_x select 2);
    if (GRLIB_player_score >= GRLIB_perm_max || _defense_price < 100) then {
        if (count _text > 25) then { _text = _text select [0,25] };
        lnbAddRow [110, [_text, str _defense_price]];
        lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
    };
} foreach GRLIB_FOB_Defense;
lbSetCurSel [110, -1];

build_action = 0;
private _objects_to_build = [];

while { dialog && alive player } do {
    if (build_action != 0) then {
        _selected_item = lbCurSel 110;
        _defense_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];
        _defense_price = (_display displayCtrl (110)) lnbText [_selected_item, 1];
        _defense_template = GRLIB_FOB_Defense select _selected_item select 1;
        if (count _defense_template > 0) then {
            _template_creator = GRLIB_FOB_Defense select _selected_item select 3;
            _objects_to_build = ([] call compile preprocessFileLineNumbers _defense_template);
        } else {
            { ctrlShow [_x, true] } foreach _input_controls;
            input_save = "";
            waitUntil {uiSleep 0.3; ((input_save != "") || !(dialog) || !(alive player))};
            if ( input_save select [0,1] == "[" && input_save select [(count input_save)-1,(count input_save)] == "]") then {
                _objects_to_build = (parseSimpleArray input_save);
            } else { systemChat localize "STR_FOB_ERROR_INVALID_DATA" };
            { ctrlShow [_x, false] } foreach _input_controls;
        };
        closeDialog 0;
    };
    sleep 0.2;
};

if (build_action == 0) exitWith {};

private _count_objects = count _objects_to_build;
if (_count_objects == 0) exitWith {};
if (!([parseNumber _defense_price] call F_pay)) exitWith {};

build_confirmed = 1;
private _msg = format [localize "STR_FOB_BUILD_STATUS", name player, _defense_name, _count_objects, ([_fob_pos] call F_getFobName)];
[gamelogic, _msg] remoteExec ["globalChat", 0];
_msg = format [localize "STR_FOB_DEFENSE_TEMPLATE_INFO", _defense_name, _template_creator];
[_msg] remoteExec ["hint", 0];
diag_log format ["--- LRX FOB Defense Template '%1' - %2 objects to build at FOB %3", _defense_name, _count_objects, ([_fob_pos] call F_getFobName)];

// Build defense in FOB direction
private ["_nextclass", "_nextobject", "_nextpos", "_nextdir"];
private _building_count = 0;
_fob_pos set [2, 0];
{
    if (_forEachIndex % 20 == 0) then {
        [player, "Land_Carrier_01_blast_deflector_up_sound"] remoteExec ["sound_range_remote_call", 2];
        gamelogic globalChat format [localize "STR_FOB_CONSTRUCTION_IN_PROGRESS", (_count_objects - _forEachIndex)];
    };
	_nextclass = (_x select 0);
	_nextpos = (_x select 1);
	_nextdir = (_x select 2) + _fob_dir;
    _nextpos = _fob_pos vectorAdd ([_nextpos, -_fob_dir] call BIS_fnc_rotateVector2D);
    if (_nextclass in fob_defenses_classnames) then {
        if (!surfaceIsWater _nextpos && !isOnRoad _nextpos) then {
            _building_count = _building_count + 1;
            _nextobject = _nextclass createVehicle _nextpos;
            _nextobject setVariable ["R3F_LOG_disabled", true, true];
            _nextobject allowDamage false;
            _nextobject setPosATL _nextpos;
            if (_nextclass in GRLIB_FOB_Defense_Sea_level) then {
                _nextobject setVectorDirAndUp [[sin _nextdir, cos _nextdir, 0], [0, 0, 1]];
            } else {
                _nextobject setVectorDirAndUp [[-cos _nextdir, sin _nextdir, 0] vectorCrossProduct surfaceNormal _nextpos, surfaceNormal _nextpos];
            };
            sleep 0.1;
        };
    } else {
        diag_log format [localize "STR_FOB_DEFENSE_TEMPLATE_REJECTED", _defense_name, _nextclass];
    };
} foreach _objects_to_build;

gamelogic globalChat format [localize "STR_FOB_CONSTRUCTION_COMPLETED", _building_count, _count_objects];
diag_log format ["--- LRX FOB Defense Construction Completed (%1/%2)", _building_count, _count_objects];
sleep 1;
build_confirmed = 0;