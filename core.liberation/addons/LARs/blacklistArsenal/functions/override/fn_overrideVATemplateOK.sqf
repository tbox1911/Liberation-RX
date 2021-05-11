
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#include "macros.hpp"

diag_log  "Override OK";

private[ "_notification" ];

_display = _this select 0;
_center = (missionNamespace getVariable ["BIS_fnc_arsenal_center",player]);
_hideTemplate = true;

_ctrlTemplateName = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
if (ctrlEnabled _ctrlTemplateName) then {
	//--- Save
	diag_log "Override OK: Save";
	[
		_center,
		[profileNamespace,ctrlText _ctrlTemplateName],
		[
			_center getVariable ["BIS_fnc_arsenal_face",face _center],
			speaker _center,
			_center call BIS_fnc_getUnitInsignia
		]
	] call BIS_fnc_saveInventory;
} else {
	//--- Load
	diag_log "Override OK: Load";
	_ctrlTemplateValue = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
	if ((_ctrlTemplateValue lbValue lnbCurSelRow _ctrlTemplateValue) >= 0) then {
		_inventory = _ctrlTemplateValue lnbText [lnbCurSelRow _ctrlTemplateValue,0];
		_notification = [_center,[profileNamespace,_inventory], LARs_override_virtualCargo] call LARs_fnc_loadInventory_whiteList;

		//--- Load custom data
		_ctrlTemplateValue = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_data = profileNamespace getVariable ["bis_fnc_saveInventory_data",[]];
		_name = _ctrlTemplateValue lnbText [lnbCurSelRow _ctrlTemplateValue,0];
		_nameID = _data find _name;
		if (_nameID >= 0) then {
			_inventory = _data select (_nameID + 1);
			_inventoryCustom = _inventory select 10;
			if ( count _inventoryCustom isEqualTo 3 ) then {
				_center setFace (_inventoryCustom select 0);
				_center setVariable ["BIS_fnc_arsenal_face",(_inventoryCustom select 0)];
				_center setSpeaker (_inventoryCustom select 1);
				[_center,_inventoryCustom select 2] call BIS_fnc_setUnitInsignia;
			};
		};

		["ListSelectCurrent",[_display]] call BIS_fnc_arsenal;
	} else {
		_hideTemplate = false;
	};
};



if (_hideTemplate) then {
	
	if ( !isNil "_notification" ) then {
		if !( _notification isEqualTo "" ) then {
			[ _display, _notification, true ] call LARs_fnc_showRestrictedItems;
		}else{
			[ _display, "", false ] call LARs_fnc_showRestrictedItems;
		};
	}else{
		[ _display, "", false ] call LARs_fnc_showRestrictedItems;
	};
};
