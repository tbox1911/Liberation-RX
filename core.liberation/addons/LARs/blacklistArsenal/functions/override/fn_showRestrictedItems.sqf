#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#include "macros.hpp"


params[ "_display", "_notification", [ "_show", false ] ];

if ( _show ) then {
	
	_showNotification = getMissionConfigValue[ "LARs_overrideVA_showMsg", 0 ];
	
	if ( _showNotification < 0 || _showNotification > 0 ) then {

		_ctrlTemplate = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlPos = ctrlPosition( _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME );
	
		{
			_ctrl = _display displayCtrl _x;
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0;
			_ctrl ctrlEnable false;
		}forEach [
			IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONCANCEL,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN1,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN2,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN3,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN4,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN5
		];
		
		( _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE ) ctrlSetText "Restricted Items";
		['showMessage',[_display,"Some restricted items have been removed"]] call bis_fnc_arsenal;
		
		_ctrlGrp = _display ctrlCreate [ "RscControlsGroupNoHScrollbars", 1000, _ctrlTemplate  ];
		_ctrlGrp ctrlSetPosition _ctrlPos;
		_ctrlGrp ctrlCommit 0;
		
		_ctrlSText = _display ctrlCreate [ "RscStructuredText", 1000, _ctrlGrp ];
		_ctrlSText ctrlSetPosition (( _ctrlPos select [ 0, 3 ] ) + [ 2 ] );
		_ctrlSText ctrlCommit 0;
		_ctrlSText ctrlSetStructuredText parseText _notification;
		
		_buttonOK = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_buttonOK setVariable [ "LARs_showNotification_ctrls", [ _ctrlSText, _ctrlGrp ] ];
		_buttonOK ctrlSetText "OK";
		ctrlSetFocus _ctrlGrp;
		
		_buttonOK ctrlRemoveAllEventHandlers "buttonClick";
		_buttonOK ctrlAddEventHandler [ "buttonClick", {
			params[ "_buttonOK" ];
			
			[ ctrlParent _buttonOK, "", false ] call LARs_fnc_showRestrictedItems;			
		}];
		
		//VA button down, clear restricted items display
		_display displayRemoveAllEventHandlers "keyDown";
		_display displayAddEventHandler ["keyDown",{
			params[ "_display", "_keyCode", "_shft", "_ctr", "_alt" ];
			
			switch ( true ) do {
				case ( _keyCode == DIK_ESCAPE ) ;
				case ( _keyCode == DIK_RETURN ) ;
				case ( _keyCode == DIK_NUMPADENTER ) : {
					[ _this select 0, '', false ] call LARs_fnc_showRestrictedItems;
				};
			};
		}];
		
		if ( _showNotification > 0 ) then {
			LARs_overrideVA_threadMsg = [ _display, _showNotification ] spawn {
				disableSerialization;
				params[ "_display", "_delay" ];
				
				_endTime = time + _delay;
				_ctrlTemplate = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
				while { time < _endTime } do {
					( _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE ) ctrlSetText format[ "Restricted Items ...%1", floor ( _endTime - time ) ];
					uiSleep 0.5;
				};
				with uiNamespace do {
					[ _display, '', false ] call LARs_fnc_showRestrictedItems;
				};
				LARs_overrideVA_thread = nil;
			};
		};	
	};
	
}else{
	
	_ctrlTemplate = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
	_ctrlTemplate ctrlSetFade 1;
	_ctrlTemplate ctrlCommit 0;
	_ctrlTemplate ctrlEnable false;
	
	_ctrlMouseBlock = _display displayCtrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
	_ctrlMouseBlock ctrlEnable false;
	
	_buttonOK = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
	_restrictedCtrls = _buttonOk getVariable "LARs_showNotification_ctrls";
	if !( isNil "_restrictedCtrls" ) then {
		
		{
			ctrlDelete _x;
		}forEach _restrictedCtrls;
		
		{
			_ctrl = _display displayCtrl _x;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlCommit 0;
			_ctrl ctrlEnable true;
		}forEach [
			IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONCANCEL,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN1,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN2,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN3,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN4,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_COLUMN5
		];
		
		_thread = uiNamespace getVariable "LARs_overrideVA_threadMsg";
		if ( !isNil "_thread" && !scriptDone _thread ) then {
			terminate _thread;
		};
		
		_buttonOK setVariable [ "LARs_showNotification_ctrls", nil ];
		_buttonOK ctrlAddEventHandler ["buttonclick","with uinamespace do {[ctrlparent (_this select 0)] call LARs_fnc_overrideVATemplateOK;};"];
		
		[ _display ] call LARs_fnc_addVAKeyEvents;

	};
		
};