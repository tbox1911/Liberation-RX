// LRX FOB Defense
// by pSiKO

private _fob = (player nearObjects [FOB_typename, 20] select 0);
if (isNil "_fob") exitWith {};
private _fob_pos = getPosATL _fob;
private _fob_dir = getDir _fob;
private _fob_owner = [_fob_pos] call F_getFobOwner;
if ((PAR_Grp_ID != _fob_owner) && !([] call is_admin)) exitWith { hintSilent localize "STR_HINT_FOB_WRONG_OWNER" };

createDialog "FOB_Defense";
waitUntil { dialog };

build_action = 0;
private _display = findDisplay 2309;
private _icon = getMissionPath "res\ui_build.paa";
private ["_selected_item", "_entrytext", "_defense_template", "_defense_name", "_defense_price"];

lbClear 110;
{
    _entrytext = (_x select 0);
    _defense_price = 50;
    if (count _entrytext > 25) then { _entrytext = _entrytext select [0,25] };	
    (_display displayCtrl (110)) lnbAddRow [_entrytext, str _defense_price];
    lnbSetPicture  [110, [((lnbSize 110) select 0) - 1, 0], _icon];
} foreach GRLIB_FOB_Defense;
lbSetCurSel [110, -1];

while { dialog && alive player } do {
    if (build_action != 0) then {
        _selected_item = lbCurSel 110;
        _defense_name = (_display displayCtrl (110)) lnbText [_selected_item, 0];
        _defense_price = (_display displayCtrl (110)) lnbText [_selected_item, 1];
        _defense_template = GRLIB_FOB_Defense select _selected_item select 1;
        closeDialog 0;
    };
    sleep 0.2;
};

systemchat str _defense_template;
private _objects_to_build = ([] call compile preprocessFileLineNumbers _defense_template);
gamelogic globalChat format ["Build %1 cost %2 on FOB %3 ", _defense_name, _defense_price, ([_fob_pos] call F_getFobName)];

// Build defense in FOB direction
private ["_nextclass", "_nextobject", "_nextpos", "_nextdir"];
_fob_pos set [2, 0];
{
	_nextclass = (_x select 0);
	_nextpos = (_x select 1);
	_nextdir = (_x select 2) + _fob_dir;
    _nextpos = _fob_pos vectorAdd ([_nextpos, -_fob_dir] call BIS_fnc_rotateVector2D);

    if (!surfaceIsWater _nextpos && !isOnRoad _nextpos) then {
        _nextobject = _nextclass createVehicle _nextpos;
        _nextobject allowDamage false;
        _nextobject setPosATL _nextpos;
        if ([_nextclass, ["Wall_F", "HBarrier_base_F"]] call F_itemIsInClass)  then {
            _nextobject setVectorDirAndUp [[-cos _nextdir, sin _nextdir, 0] vectorCrossProduct surfaceNormal _nextpos, surfaceNormal _nextpos];
        } else {
            _nextobject setVectorDirAndUp [[_nextdir, _nextdir, 0], [0,0,1]];
        };
        sleep 0.3;
    };
} foreach _objects_to_build;
