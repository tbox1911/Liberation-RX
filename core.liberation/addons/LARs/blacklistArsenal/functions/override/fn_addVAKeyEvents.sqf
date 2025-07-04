params ["_display"];

#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

// VA template button OK
_ctrlTemplateButtonOK = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
_ctrlTemplateButtonOK ctrlRemoveAllEventHandlers "buttonclick";
_ctrlTemplateButtonOK ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0)] call LARs_fnc_overrideVATemplateOK"];

// VA template listbox DblClick
_ctrlTemplateValue = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_ctrlTemplateValue ctrlRemoveAllEventHandlers "lbdblclick";
_ctrlTemplateValue ctrlAddEventHandler ["lbdblclick","[ctrlparent (_this select 0)] call LARs_fnc_overrideVATemplateOK"];

// VA button down, needed to override ENTER on template listbox
_display displayRemoveAllEventHandlers "keyDown";
_display displayAddEventHandler ["keydown","_this call LARs_fnc_overrideVAButtonDown"];

// VA load button down
_ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
_ctrlButtonLoad ctrlRemoveAllEventHandlers "buttonclick";
_ctrlButtonLoad ctrlAddEventHandler ["buttonclick","with uinamespace do {['buttonLoad',[ctrlparent (_this select 0)]] call bis_fnc_arsenal}"];

// VA delete button down
_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
_ctrlTemplateButtonDelete ctrlRemoveAllEventHandlers "buttonclick";
_ctrlTemplateButtonDelete ctrlAddEventHandler ["buttonclick","with uinamespace do {['buttonTemplateDelete',[ctrlparent (_this select 0)]] call bis_fnc_arsenal}"];

// Enable/Disable Random  (0/1)- will disable random button and shortcut keys
LARs_overrideVA_random = 0;
// if ( LARs_overrideVA_random > 0 ) then {
// 	_display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM ctrlEnable false;
// };