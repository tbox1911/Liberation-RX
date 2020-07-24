//**********************************
//[ myBox, [ whitelist, blacklist ], targets, name, condition ] call LARs_fnc_blacklistArsenal;
//**********************************
//myBox - object to init arsenal on
//**********************************
//whitelist/blacklist
//ARRAY of equipment
//OR
//STRING name of a global variable holding the array of equipment to be blacklisted or CfgPatches class
//- saves passing large blacklist arrays across the network
//SIDE - experimental list from config of side equipment
//**********************************
//targets ( OPTIONAL ) - as per remoteExec ( https://community.bistudio.com/wiki/remoteExec )
//NUMBER, OBJECT, SIDE, GROUP or ARRAY of previous types, clients where function will be executed
//use FALSE to only run locally,
//if targets is provided the function is added to the JIP que and the function will return a STRING of the JIP que ID
//**********************************
//NAME - unique name for arsenal, also displayed in action
//**********************************
//condition ( OPTIONAL default {true} )
//CODE condition for showing Arsenal action, passed variables as per addAction, _target - the box, _this - caller
//**********************************

#define ERROR if !
#define OK if
#define PARMS( _var, _index, _count ) [ [], _var select [ _index, _count ] ] select ( count _var >= ( _index + _count ) )

//Arsenal OBJECT
ERROR ( params [
	[ "_box", objNull, [ objNull ] ]
] ) exitWith {
	"Invalid OBJECT to attach arsenal to" call BIS_fnc_error;
};

//Remote targets
PARMS( _this, 2, 1 ) params[
	[ "_target", false, [ 0, objNull, sideUnknown, grpNull, [], false ] ]
];

//Have we given the arsenal a name
ERROR( PARMS( _this, 3, 1 ) params[ [ "_arsenalName", "default", [ "" ] ] ] ) then {
	diag_log "WARNING - LARs Arsenal created without name! - default used instead";
	//format[ "No name supplied for LARs Arsenal on %1", str _box ] call BIS_fnc_error;
};

//If the box already has an arsenal of this name throw a warning in the RPT
ERROR( isNil { _box getVariable [ format[ "LARs_arsenal_%1_data", _arsenalName ], nil ] } ) then {
	diag_log format[ "WARNING - Overwriting LARs Arsenal %1 on %2", _arsenalName, str _box ];
};

//[ _box ] call BIS_fnc_objectVar;

if !( _target isEqualType false )  exitWith {
	_this set [ 2, false ];
	_this remoteExec [ "LARs_fnc_blacklistArsenal", _target, format[ "%1_%2", _box, _arsenalName ] ]
};


_thread = _this spawn {

	//If initlizing box at mission start then register a loading screen
	_isLoading = isNil "BIS_fnc_init";
	if ( _isLoading ) then {
		[ "LARs_blacklist" ] call BIS_fnc_startLoadingScreen;
	};

	params[ "_box",
		[ "_lists", [], [ [] ] ],
		"_target",
		"_arsenalName",
		[ "_condition", {true} , [ {} ] ]
	];

	waitUntil {sleep 1; !isNil "LARs_allGearInit" };

  //Get whiteList or default to BIS whitelist
  _whiteList = _lists param[ 0, LARs_allGear, [ [], "", sideUnknown, true ] ];
  if !( _whiteList isEqualType [] ) then {
    _whiteList = if ( _whiteList isEqualType true ) then {
      if ( _whiteList ) then {
        LARs_allGear;
      }else{
        [];
      };
    }else{
      [ _whiteList ];
    };
  };

	//Get blackList or default to []
	_blackList = _lists param[ 1, [], [ [], "", sideUnknown ] ];
	if !( _blackList isEqualType [] ) then {
		_blackList = [ _blackList ];
	};

	//If a list requires a side and calculateSideGear is not in use exit with error
	if ( {
		{
			if !( isNil "_x" ) then {
				typeName _x isEqualTo typeName sideUnknown
			}else{
				false
			};
		}count _x > 0
	}count[ _whiteList, _blackList ] > 0 && { isNil "LARs_sideGear" } ) exitWith {
		"SIDE used in white/blacklist - currently no side data, switch on LARs_calculateSideGear in description" call BIS_fnc_error;
	};

	//Create lists
	_whiteList = [ "white", _whiteList ] call LARs_fnc_createList;
	_blackList = [ "black", _blackList ] call LARs_fnc_createList;

	//Remove blacklist items from the whitelist
	_whiteList = [ _whiteList, _blackList ] call LARs_fnc_removeBlack;

	//Fix for weapon name compares ( sigh )
	_whiteList = [ _whiteList ] call LARs_fnc_fixWeaponNames;

	//Create a cargo list
	_cargo = [ "cargo", _whitelist ] call LARs_fnc_createList;


	//Add aresnal data and condition to the box
	_box setVariable [ format[ "LARs_arsenal_%1_data", _arsenalName], _whiteList];
	_box setVariable [ format[ "LARs_arsenal_%1_condition", _arsenalName], _condition];
	_box setVariable [ format[ "LARs_arsenal_%1_cargo", _arsenalName ], _cargo ];

	//Init local Arsenal action
	//["AmmoboxInit",[_box,false,_condition]] call BIS_fnc_arsenal;
	_box setVariable [format [ "LARs_arsenal_%1_action", _arsenalName], _box addAction [
		format [ "%1 - %2", localize "STR_A3_Arsenal", _arsenalName ],
		compile format[ "
			_box = _this select 0;
			_unit = _this select 1;

			_savedD = BIS_fnc_arsenal_data;
			_data = _box getVariable 'LARs_arsenal_%1_data';
			BIS_fnc_arsenal_data = _data;

			_savedC = _box getVariable [ 'bis_addVirtualWeaponCargo_cargo', [] ];
			_cargo = _box getVariable 'LARs_arsenal_%1_cargo';
			_box setvariable [ 'bis_addVirtualWeaponCargo_cargo', _cargo ];

			['Open',[nil,_box]] call BIS_fnc_arsenal;

			_nul = [ _box, _savedD, _savedC ] spawn {
				_box = _this select 0;

				comment'wait until the arsenal is open';
				waituntil{ sleep 0.5; !isNull ( uiNamespace getvariable [ 'RscDisplayArsenal', displayNull ] ) };

				comment'wait until the arsenal has been closed';
				waitUntil { sleep 0.5; isNull ( uinamespace getvariable ['BIS_fnc_arsenal_cam',objnull] ) };

				comment'reapply default arsenal whitelist';
				BIS_fnc_arsenal_data = _this select 1;
				_box setVariable [ 'bis_addvirtualWeaponCargo_cargo', _this select 2 ];
			};
		", _arsenalName ],
		[],
		6,
		true,
		false,
		"",
		format[ "
			_cargo = _target getvariable ['LARs_arsenal_%1_data', [] ];
			if (count _cargo == 0) then {
				_target removeaction (_target getvariable ['LARs_arsenal_%1_action', -1 ]);
				_target setvariable ['LARs_arsenal_%1_action',nil];
			};
			_condition = _target getvariable ['LARs_arsenal_%1_condition',{true}];
			alive _target && {_target distance _this < 5} && {call _condition}
		", _arsenalName ]
	]];

	LARs_initBlacklist = true;

	if ( _isLoading ) then {
		[ "LARs_blacklist" ] call BIS_fnc_endLoadingScreen;
	};

};
