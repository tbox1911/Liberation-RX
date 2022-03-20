#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_getPlayerInventory

    File: fn_cratefiller_getPlayerInventory.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Gets all weapons of the selected player.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlPlayers = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOPLAYERS;
private _ctrlMainWeapon = _dialog displayCtrl KP_CRATEFILLER_IDC_MAINWEAPON;
private _ctrlHandgun = _dialog displayCtrl KP_CRATEFILLER_IDC_HANDGUN;
private _ctrlSecondaryWeapon = _dialog displayCtrl KP_CRATEFILLER_IDC_SECONDARYWEAPON;

// Read controls
private _index = lbCurSel _ctrlPlayers;

// Get the selected player from the namespace
private _player = (CCGVAR("players", [])) select _index;

// Get the player weapons
private _mainWeapon = primaryWeapon _player;
private _handgun = handgunWeapon _player;
private _secondaryWeapon = secondaryWeapon _player;

// Variables
private _config = configNull;
private _picture = "";
private _tooltip = [];
private _description = "";
private _magazine = "";
private _attachments = "";

// Set the main weapon picture and tooltip
if !(_mainWeapon isEqualTo "") then {
    _config = [_mainWeapon] call KP_fnc_cratefiller_getConfigPath;
    _picture = getText (_config >> "picture");

    // Handle the tooltip stuff
    _tooltip append [getText (_config >> "displayName"), "\n"];
    _description = (getText (_config >> "descriptionShort")) splitString "<>";
    _tooltip append [_description select 0, "\n", _description select 2, "\n"];
    _magazine = (primaryWeaponMagazine _player) select 0;
    _config = [_magazine] call KP_fnc_cratefiller_getConfigPath;
    _tooltip append [getText (_config >> "displayName"), "\n"];
    _attachments = primaryWeaponItems _player;
    {
        _config = [_x] call KP_fnc_cratefiller_getConfigPath;
        _tooltip append [getText (_config >> "displayName"), "\n"];
    } forEach (_attachments select {!(_x isEqualTo "")});

    // Finally fill the control
    _ctrlMainWeapon ctrlSetText _picture;
    _ctrlMainWeapon ctrlSetTooltip (_tooltip joinString "");
} else {
    _ctrlMainWeapon ctrlSetText "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa";
};

// Set the handgun picture and tooltip
if !(_handgun isEqualTo "") then {
    _config = [_handgun] call KP_fnc_cratefiller_getConfigPath;
    _picture = getText (_config >> "picture");

    // Handle the tooltip stuff
    _tooltip append [getText (_config >> "displayName"), "\n"];
    _description = (getText (_config >> "descriptionShort")) splitString "<>";
    _tooltip append [_description select 0, "\n", _description select 2, "\n"];
    _magazine = (handgunMagazine _player) select 0;
    _config = [_magazine] call KP_fnc_cratefiller_getConfigPath;
    _tooltip append [getText (_config >> "displayName"), "\n"];
    _attachments = handgunItems _player;
    {
        _config = [_x] call KP_fnc_cratefiller_getConfigPath;
        _tooltip append [getText (_config >> "displayName"), "\n"];
    } forEach (_attachments select {!(_x isEqualTo "")});

    // Finally fill the control
    _ctrlHandgun ctrlSetText _picture;
    _ctrlHandgun ctrlSetTooltip (_tooltip joinString "");
} else {
    _ctrlHandgun ctrlSetText "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Handgun_ca.paa";
};

// Set the secondary weapon picture and tooltip
if !(_secondaryWeapon isEqualTo "") then {
    _config = [_secondaryWeapon] call KP_fnc_cratefiller_getConfigPath;
    _picture = getText (_config >> "picture");

    // Handle the tooltip stuff
    _tooltip append [getText (_config >> "displayName"), "\n"];
    _description = (getText (_config >> "descriptionShort")) splitString "<>";
    _tooltip append [_description select 0, "\n", _description select 2, "\n"];
    _magazine = (secondaryWeaponMagazine _player) select 0;
    _config = [_magazine] call KP_fnc_cratefiller_getConfigPath;
    _tooltip append [getText (_config >> "displayName"), "\n"];
    _attachments = secondaryWeaponItems _player;
    {
        _config = [_x] call KP_fnc_cratefiller_getConfigPath;
        _tooltip append [getText (_config >> "displayName"), "\n"];
    } forEach (_attachments select {!(_x isEqualTo "")});

    // Finally fill the control
    _ctrlSecondaryWeapon ctrlSetText _picture;
    _ctrlSecondaryWeapon ctrlSetTooltip (_tooltip joinString "");
} else {
    _ctrlSecondaryWeapon ctrlSetText "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\SecondaryWeapon_ca.paa";
};

true
