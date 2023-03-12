#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
LARs_fnc_overrideVAButtonDown = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_overrideVAButtonDown.sqf";
LARs_fnc_overrideVATemplateOK = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_overrideVATemplateOK.sqf";

params[ "_display" ];

//_msg = format[ "SEH: VCargo: %1", uiNamespace getVariable "LARs_override_virtualCargo" ];
//diag_log _msg;

//VA template button OK
_ctrlTemplateButtonOK = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
_ctrlTemplateButtonOK ctrlRemoveAllEventHandlers "buttonclick";
_ctrlTemplateButtonOK ctrlAddEventHandler ["buttonclick","[ctrlparent (_this select 0)] call LARs_fnc_overrideVATemplateOK;"];

//_msg = format[ "SEH: OK: %1", _ctrlTemplateButtonOK ];
//diag_log _msg;

//VA template listbox DblClick
_ctrlTemplateValue = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_ctrlTemplateValue ctrlRemoveAllEventHandlers "lbdblclick";
_ctrlTemplateValue ctrlAddEventHandler ["lbdblclick","[ctrlparent (_this select 0)] call LARs_fnc_overrideVATemplateOK;"];

//_msg = format[ "SEH: OK: %1", _ctrlTemplateValue ];
//diag_log _msg;

//VA button down, needed to override ENTER on template listbox
_display displayRemoveAllEventHandlers "keyDown";
_display displayAddEventHandler ["keydown","_this call LARs_fnc_overrideVAButtonDown;"];

_ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
_ctrlButtonLoad ctrlRemoveAllEventHandlers "buttonclick";
_ctrlButtonLoad ctrlAddEventHandler ["buttonclick","with uinamespace do {['buttonLoad',[ctrlparent (_this select 0)]] call bis_fnc_arsenal;};"];

//_msg = format[ "SEH: OK: %1", _ctrlButtonLoad ];
//diag_log _msg;

_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
_ctrlTemplateButtonDelete ctrlRemoveAllEventHandlers "buttonclick";
_ctrlTemplateButtonDelete ctrladdeventhandler ["buttonclick","['buttonTemplateDelete',[ctrlparent (_this select 0)]] call bis_fnc_arsenal;"];

if ( LARs_overrideVA_random > 0 ) then {
	_display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM ctrlEnable false;
};