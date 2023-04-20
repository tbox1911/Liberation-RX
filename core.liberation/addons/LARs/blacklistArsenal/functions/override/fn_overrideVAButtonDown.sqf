#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#include "macros.hpp"

#define IDCS_LEFT\
	IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,\
	IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,\
	IDC_RSCDISPLAYARSENAL_TAB_VEST,\
	IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,\
	IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,\
	IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,\
	IDC_RSCDISPLAYARSENAL_TAB_NVGS,\
	IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,\
	IDC_RSCDISPLAYARSENAL_TAB_MAP,\
	IDC_RSCDISPLAYARSENAL_TAB_GPS,\
	IDC_RSCDISPLAYARSENAL_TAB_RADIO,\
	IDC_RSCDISPLAYARSENAL_TAB_COMPASS,\
	IDC_RSCDISPLAYARSENAL_TAB_WATCH,\
	IDC_RSCDISPLAYARSENAL_TAB_FACE,\
	IDC_RSCDISPLAYARSENAL_TAB_VOICE,\
	IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA

#define IDCS_RIGHT\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC\

#define IDCS	[IDCS_LEFT,IDCS_RIGHT]

//diag_log "Override Button Down";

_display = _this select 0;
_key = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;
_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
_return = false;
_ctrlTemplate = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
_inTemplate = ctrlFade _ctrlTemplate == 0;

switch true do {
	case (_key == DIK_ESCAPE): {
		["buttonClose",[_display]] spawn BIS_fnc_arsenal;
		_return = true;
	};

	//--- Enter
	case (_key in [DIK_RETURN,DIK_NUMPADENTER]): {
		_ctrlTemplate = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		if (ctrlFade _ctrlTemplate == 0) then {
			if (BIS_fnc_arsenal_type == 0) then {
				[_display] call LARs_fnc_overrideVATemplateOK;
			} else {
				["buttonTemplateOK",[_display]] spawn BIS_fnc_garage;
			};
			_return = true;
		};
	};

	//--- Prevent opening the commanding menu
	case (_key == DIK_1);
	case (_key == DIK_2);
	case (_key == DIK_3);
	case (_key == DIK_4);
	case (_key == DIK_5);
	case (_key == DIK_1);
	case (_key == DIK_7);
	case (_key == DIK_8);
	case (_key == DIK_9);
	case (_key == DIK_0): {
		_return = true;
	};

	//--- Tab to browse tabs
	case (_key == DIK_TAB): {
		_idc = -1;
		{
			_ctrlTab = _display displayCtrl (IDC_RSCDISPLAYARSENAL_TAB + _x);
			if !(ctrlEnabled _ctrlTab) exitWith {_idc = _x;};
		} forEach [IDCS_LEFT];
		_idcCount = {!isNull (_display displayCtrl (IDC_RSCDISPLAYARSENAL_TAB + _x))} count [IDCS_LEFT];
		_idc = if (_ctrl) then {(_idc - 1 + _idcCount) % _idcCount} else {(_idc + 1) % _idcCount};
		if (BIS_fnc_arsenal_type == 0) then {
			["TabSelectLeft",[_display,_idc]] call BIS_fnc_arsenal;
		} else {
			["TabSelectLeft",[_display,_idc]] call BIS_fnc_garage;
		};
		_return = true;
	};

	//--- Export to script
	case (_key == DIK_C): {
		_mode = if (_shift) then {"config"} else {"init"};
		if (BIS_fnc_arsenal_type == 0) then {
			if (_ctrl) then {['buttonExport',[_display,_mode]] call BIS_fnc_arsenal;};
		} else {
			if (_ctrl) then {['buttonExport',[_display,_mode]] call BIS_fnc_garage;};
		};
	};
	//--- Export from script
	case (_key == DIK_V): {
		if (BIS_fnc_arsenal_type == 0) then {
			if (_ctrl) then {['buttonImport',[_display]] call BIS_fnc_arsenal;};
		} else {
			if (_ctrl) then {['buttonImport',[_display]] call BIS_fnc_garage;};
		};
	};
	//--- Save
	case (_key == DIK_S): {
		if (_ctrl) then {['buttonSave',[_display]] call BIS_fnc_arsenal;};
	};
	//--- Open
	case (_key == DIK_O): {
		if (_ctrl) then {['buttonLoad',[_display]] call bis_fnc_arsenal;[_display] call LARs_fnc_applyLBColors;};
	};
	//--- Randomize
	case (_key == DIK_R && getMissionConfigValue[ "LARs_overrideVA_random", 0 ] isEqualTo 0 ): {
		if (_ctrl) then {
			if (BIS_fnc_arsenal_type == 0) then {
				if (_shift) then {
					_soldiers = [];
					{
						_soldiers set [count _soldiers,configName _x];
					} forEach ("isclass _x && getnumber (_x >> 'scope') > 1 && gettext (_x >> 'simulation') == 'soldier'" configClasses (configFile >> "cfgvehicles"));
					//[_center,_soldiers call BIS_fnc_selectRandom] call BIS_fnc_loadInventory;
					[_center, selectRandom _soldiers] call BIS_fnc_loadInventory;
					["ListSelectCurrent",[_display]] call BIS_fnc_arsenal;
				}else {
					['buttonRandom',[_display]] call BIS_fnc_arsenal;
				};
			} else {
				['buttonRandom',[_display]] call BIS_fnc_garage;
			};
		};
	};
	//--- Toggle interface
	case (_key == DIK_BACKSPACE && !_inTemplate): {
		['buttonInterface',[_display]] call BIS_fnc_arsenal;
		_return = true;
	};

	//--- Acctime
	case (_key in (actionKeys "timeInc")): {
		if (accTime == 0) then {setAccTime 1;};
		_return = true;
	};
	case (_key in (actionKeys "timeDec")): {
		if (accTime != 0) then {setAccTime 0;};
		_return = true;

	};

	//--- Vision mode
	case (_key in (actionKeys "nightvision") && !_inTemplate): {
		_mode = missionNamespace getVariable ["BIS_fnc_arsenal_visionMode",-1];
		_mode = (_mode + 1) % 3;
		missionNamespace setVariable ["BIS_fnc_arsenal_visionMode",_mode];
		switch _mode do {
			//--- Normal
			case 0: {
				camUseNVG false;
				false setCamUseTi 0;
			};
			//--- NVG
			case 1: {
				camUseNVG true;
				false setCamUseTi 0;
			};
			//--- TI
			default {
				camUseNVG false;
				true setCamUseTi 0;
			};
		};
		playSound ["RscDisplayCurator_visionMode",true];
		_return = true;

	};
};
_return
