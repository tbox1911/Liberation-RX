#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#include "macros.hpp"

params[ "_display" ];

_whiteList = uiNamespace getVariable [ "LARs_override_virtualCargo", [] ];
if ( _whiteList isEqualTo [] ) exitWith { diag_log "No whiteList" };
if ( ctrlText ( _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE ) != "Load" ) exitWith {};

_ctrlTemplateValue = _display displayCtrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
_invData = profileNamespace getVariable [ "bis_fnc_saveInventory_data", [] ];

['showMessage',[_display,"Orange loadouts have restricted items that will be removed when loaded"]] call bis_fnc_arsenal;

_fnc_setLnBEntry = {
	params[ "_name", [ "_isOK", true ] ];
	
	_color = [ [ 0.819, 0.670, 0.082, 1.0 ], [ 1, 1, 1, 1 ] ] select _isOK;
	
	for "_LBindex" from 0 to (( lnbSize _ctrlTemplateValue ) select 0 ) - 1 do {
		if ( _ctrlTemplateValue lnbText [ _LBindex, 0 ] == _name ) then {
			_ctrlTemplateValue lnbSetColor [ [ _LBindex, 0 ], _color ];
			_ctrlTemplateValue lbSetValue [ _LBindex, 1 ];
		};
	};
};

_fnc_recurseInv = {
	private[ "_msg" ];
	params[ "_name", "_itemData", [ "_isBaseCall", true ], [ "_allowed", true ] ];
	
	if ( _isBaseCall ) then {
		_msg = format[ "Base N: %1, %2", _name, _itemData ];
	}else{
		_msg = format[ "Rec N: %1, D: %2", _name, [ str _itemData, _itemData ] select ( _itemData isEqualType [] ) ];
	};
	diag_log _msg;
	
	
	switch ( typeName _itemData ) do {
		case ( typeName "" ) : {
			if !( _itemData == "" ) then {
				_allowed = CONDITION( _itemData );
			};
		};
		case ( typeName [] ) : {
			if ( count _itemData > 0 ) then {
				{
					if !( isNil "_x" ) then {
						_allowed = [ _name, _x, false ] call _fnc_recurseInv;
					};
					if !( _allowed ) exitWith {};
				}forEach _itemData;
			};
		};
	};
	
	if ( _isBaseCall ) then {
		_msg = format[ "Ended with %1", _allowed ];
		diag_log _msg;
		[ _name, _allowed ] call _fnc_setLnBEntry;
	}else{
		_allowed
	};
	
};


for "_index" from 0 to (count _invData - 1) step 2 do {
	_name = _invData select _index;
	_data = _invData select ( _index + 1 );
	
	[ _name, _data select [ 0, 9 ] ] call _fnc_recurseInv;
};