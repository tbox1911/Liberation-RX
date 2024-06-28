// LRX FOB Defense
// by pSiKO

private _fob_sign = player nearObjects [FOB_sign, 20] select 0;
if (isNil "_fob_sign") exitWith {};

private _fob_class = _fob_sign getVariable ["GRLIB_fob_type", FOB_typename];
private _fob = (player nearObjects [_fob_class, 20] select 0);
if (isNil "_fob") exitWith {};

private _fob_pos = getPosATL _fob;
private _fob_dir = getDir _fob;

private _walls = count (_fob_pos nearObjects ["Wall_F", GRLIB_fob_range]);
_walls = _walls + count (_fob_pos nearObjects ["HBarrier_base_F", GRLIB_fob_range]);
if (_walls > 10) exitWith { hint "Cannot start Construction!\nFortification already present here!" };

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
            } else { systemchat "Error: Invalid data!" };
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
private _msg = format ["%1 Build %2 (%3 objects) on FOB %4 ", name player, _defense_name, _count_objects, ([_fob_pos] call F_getFobName)];
[gamelogic, _msg] remoteExec ["globalChat", 0];
_msg = format ["Defense Template: %1\nCreated by: %2\nThanks to him !!", _defense_name, _template_creator];
[_msg] remoteExec ["hint", 0];

// Build defense in FOB direction
private _defenses_blacklist = GRLIB_recycleable_blacklist + all_friendly_classnames;
private ["_nextclass", "_nextobject", "_nextpos", "_nextdir"];
_fob_pos set [2, 0];
{
    if (_forEachIndex % 20 == 0) then {
        [player, "Land_Carrier_01_blast_deflector_up_sound"] remoteExec ["sound_range_remote_call", 2];
        gamelogic globalChat format ["Construction in progress, %1 objects left...", (_count_objects - _forEachIndex)];
    };
	_nextclass = (_x select 0);
	_nextpos = (_x select 1);
	_nextdir = (_x select 2) + _fob_dir;
    _nextpos = _fob_pos vectorAdd ([_nextpos, -_fob_dir] call BIS_fnc_rotateVector2D);

    if (!surfaceIsWater _nextpos && !isOnRoad _nextpos && !(_nextclass in _defenses_blacklist)) then {
        _nextobject = _nextclass createVehicle _nextpos;
        _nextobject allowDamage false;
        _nextobject setPosATL _nextpos;
        if (_nextobject in GRLIB_FOB_Defense_Sea_level) then { 
            _nextobject setVectorDirAndUp [[_nextdir, _nextdir, 0], [0,0,1]];
        } else {
            _nextobject setVectorDirAndUp [[-cos _nextdir, sin _nextdir, 0] vectorCrossProduct surfaceNormal _nextpos, surfaceNormal _nextpos];
        };
        sleep 0.1;
    };
} foreach _objects_to_build;

gamelogic globalChat "Construction completed.";
sleep 1;
build_confirmed = 0;