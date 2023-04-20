//[ box, arsenalName, [ white, black ], _targets ] call LARs_fnc_updateArsenal

params[ "_box", "_arsenalName", [ "_lists", [] ], [ "_target", false, [ 0, objNull, sideUnknown, grpNull, [], false ] ] ];

if ( isNil "_box" || { isNull _box } ) exitWith {
	"Object not found for call to LARs_fnc_updateArsenal" call BIS_fnc_error;
};

if !( _target isEqualType false )  exitWith {
	_this set [ 3, false ];
	_this remoteExec [ "LARs_fnc_updateArsenal", _target, format[ "%1_%2_update", _box, _arsenalName ] ];
};

if ( isNil { _box getVariable [ format[ "LARs_arsenal_%1_data", _arsenalName ], nil ] } ) exitWith {
	format[ "Arsenal %1 not found on %2 for call to LARs_fnc_updateArsenal", _arsenalName, _box ] call BIS_fnc_error;
};

_lists params[ [ "_whiteList", [] ], [ "_blackList", [] ] ];

_oldWhite = _box getVariable [ format[ "LARs_arsenal_%1_data", _arsenalName ], [] ];

if !( _whiteList isEqualType [] ) then {
	_whiteList = _oldWhite + [ _whitelist ];
}else{
	_whiteList = _oldWhite + _whitelist;
};

//Create lists
_whiteList = [ "white", _whiteList ] call LARs_fnc_createList;
_blackList = [ "black", _blacklist ] call LARs_fnc_createList;


if ( count _blackList > 0 ) then {
	//Remove blacklist items from the whitelist
	_whiteList = [ _whiteList, _blackList ] call LARs_fnc_removeBlack;
};

_cargo = [ "cargo", _whitelist ] call LARs_fnc_createList;

_box setVariable [ format[ "LARs_arsenal_%1_data", _arsenalName], _whiteList ];
_box setVariable [ format[ "LARs_arsenal_%1_cargo", _arsenalName ], _cargo ];