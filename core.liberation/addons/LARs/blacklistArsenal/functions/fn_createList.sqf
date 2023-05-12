private [ "_init", "_dataTypes" ];

//If params fails ( we have not sent _newList ) then we are initialising a new list
if !( params[ "_listType", "_list", [ "_newList", [] ] ] ) then {
//	private [ "_dataTypes" ];

	//we are initialising a new list
	_init = true;

	//if the list is not an array make it into one
	if !( _list isEqualType [] ) then {
		_list = [ _list ];
	};

}else{
	//_newList was passed so this is an iteration of the script
	_init = false;

	if !( _list isEqualType [] ) then {
		_list = [ _list ];
	};
};


switch ( toLower _listType ) do {

	case "white";
	case "black" : {

		//BLACK ( a blacklist is just a list of items, no need for structure )
		//foreach passed item, side, global variable( STRING name ) or array holding any of previous
		{
			switch ( typeName _x ) do {

				//if we passed a side
				case ( typeName sideUnknown ) : {
					//Add sides gear to the list
					_newList = _newList + ( LARs_sideGear select ( _x call BIS_fnc_sideID ));
				};

				//if we passed an item classname or a global var or CfgPatches class
				case ( typeName "" ) : {

					//If it is not a global var
					if ( isNil { missionNamespace getVariable [ _x, nil ] } ) then {
						//Is it a CfgPatches class
						if ( isClass( configFile >> "CfgPatches" >> _x ) ) then {
							{
								{
									_itemType = ( _x call BIS_fnc_itemType ) select 0;
									if ( _itemType in [ "Weapon", "Item", "Equipment", "Magazine", "Mine" ] ) then {
										_newlist pushBack _x;
									};
								}forEach _x;
							}forEach [
								getArray( configFile >> "CfgPatches" >> _x >> "units" ),
								getArray( configFile >> "CfgPatches" >> _x >> "weapons" )
							];
						}else{
							//Its a classname so push item into the list
							_newlist pushBack _x;
						};
					}else{
						//Get global vars data
						_tmpData = missionNamespace getVariable [ _x, [] ];
						//recall script passing global var contents
						_newList = [ _listType, _tmpdata, _newlist ] call LARs_fnc_createList;
					};
				};

				//if we passed an array
				case ( typeName [] ) : {
					{
						//foreach item in the array recall this script
						_newList = [ _listType, _x, _newlist ] call LARs_fnc_createList;
					}forEach _list;
				};

			};
		}forEach _list;
	};

	//CARGO - Same structure as addVirtualCargo [ Items, Weapons, Magazines, Backpacks ]
	case "cargo" : {
		{
			_item = _x;
			_itemType = _item call BIS_fnc_itemType;
//diag_log format ["DBG1: %1 %2", _item, _itemType];

			_index = if !( ( _itemType select 0 ) isEqualTo "" ) then {
				switch ( _itemType select 0 ) do {
					case "Item" : {
						if ( _itemType select 1 == "binocular" ) then {
							1
						}else{
							0
						};
					};
					case "VehicleWeapon";
					case "Weapon" : {
						1
					};
					case "Magazine";
					case 'Mine' : {
						2
					};
					case "Equipment" : {
						if ( ( _itemType select 1 ) == 'Backpack' ) then {
							3
						}else{
							0
						};
					};
				};
			};

			if !( isNil "_index" ) then {
				if ( count _newlist > _index ) then {

					_tmpList = _newList select _index;
					if !( isNil "_tmpList" ) then {
						_nul = _tmpList pushBack _item;
					}else{
						_newList set [ _index, [ _item ] ];
					};
				}else{
					_newList set [ _index, [ _item ] ];
				};
			}else{
				if (
					isClass( configFile >> "CfgWeapons" >> _item ) ||
					isClass( configFile >> "CfgGlasses" >> _item )
				) then {
					format[ "VirtualCargo Index for %1 not found", _item ] call BIS_fnc_error;
					diag_log format[ "VirtualCargo Index for %1 not found", _item ];
				};
			};

		}forEach _list;
	};
};

//If base pass clean the array and make lower case before returning
if ( _init && { !( _listType isEqualTo "cargo" ) } ) then {
	{
		if ( !isNil { _x } ) then {
			//if an array
			if ( _x isEqualType [] ) then {
				private [ "_tmp" ];
				//Get rid of duplicates
				_tmp = _x arrayIntersect _x;
				_newList set [ _forEachIndex, _tmp ];
			};
		}else{
			_newList set [ _forEachIndex, [] ];
		};
	}forEach _newList;
};

if ( _init ) then {
	switch( toLower _listType ) do {
//		case ( "white" ) : {
//			if ( count _newList < count _dataTypes ) then {
//				_newList resize ( count _dataTypes );
//			};
//			_newList = _newList apply{ if( isNil "_x" ) then { [] }else{ _x } };
//		};
		case ( "cargo" ) : {
			if ( count _newList < 4 ) then {
				_newList resize 4;
			};
			_newList = _newList apply{ if( isNil "_x" ) then { [] }else{ _x } };
		};
	};
};

_newList