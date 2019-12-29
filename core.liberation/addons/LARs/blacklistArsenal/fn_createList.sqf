private [ "_init", "_dataTypes" ];

//Our default list of item types ( structure is what arsenal expects to receive )
_dataTypes = [
	["assaultrifle","machinegun","sniperrifle",	"shotgun","rifle","submachinegun"],
	["launcher","missilelauncher","rocketlauncher"],
	["handgun"],
	["uniform"],
	["vest"],
	["backpack"],
	["headgear"],
	["glasses"],
	["nvgoggles"],
	["binocular","laserdesignator"],
	["map"],
	["gps","uavterminal"],
	["radio"],
	["compass"],
	["watch"],
	[],
	[],
	[],
	["accessorysights"],
	["accessorypointer"],
	["accessorymuzzle"],
	["bullet"],
	["grenade","smokeshell"],
	["mine","minebounding","minedirectional"],
	["firstaidkit","medikit","minedetector","toolkit"],
	["accessorybipod"]
];

//If params fails ( we have not sent _newList ) then we are initialising a new list
if !( params[ "_listType", "_list", [ "_newList", [] ] ] ) then {
	private [ "_dataTypes" ];

	//we are initialising a new list
	_init = true;

	//turn list of stuff passed to lower case
	_list = _list call LARs_fnc_toLower;

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



_fnc_findDataType = {
	private[ "_itemType" ];

	//Get passed items type
	_itemType = toLower (( _this call BIS_fnc_itemType ) select 1 );

	//Find sub array in data type that item belongs to
	{
		//If passed items type is in sub array
		if ( _itemType in _x ) exitWith {

			//if our new list is big enough to hold new data
			if ( count _newList > _forEachIndex ) then {

				//Get the current data at index from new list
				_tmpList = _newList select _forEachIndex;

				//if its blank ( something may have been inserted further on causing index to be nil )
				if ( isNil "_tmpList" ) then {
					//set index of new list as item as array
					_newlist set [ _forEachIndex, [ _this ] ];
				}else{
					//if not nil push item into array at index
					_nul = _tmpList pushBack _this;
				};
			}else{
				//If new list is not big enough, insert item at index as array
				_newList set [ _forEachIndex, [ _this ] ];
			};
		};
	}forEach _dataTypes;
};


switch ( toLower _listType ) do {

	//WHITE - seperates items into categories see _dataTypes
	case "white" : {

		//foreach passed item, side, global variable( STRING name ) or array holding any of previous
		{
			switch ( typeName _x ) do {

				//If we have passed a side
				case ( typeName sideUnknown ) : {
					//For each item in the sideGear
					{
						//find type and add to appropriate index
						_x call _fnc_findDataType;
					}forEach ( LARs_sideGear select ( _x call BIS_fnc_sideID ));
				};

				//if weve passed an item as STRING classname or global variable reference or CfgPatches class
				case ( typeName "" ) : {
					//if its not a global variable
					if ( isNil { missionNamespace getVariable [ _x, nil ] } ) then {
						//Is it a CfgPatches class
						if ( isClass( configFile >> "CfgPatches" >> _x ) ) then {
							{
								_x call _fnc_findDataType;
							}forEach getArray( configFile >> "CfgPatches" >> _x >> "units" );
						}else{
							//Its a classname so find type and add to appropriate index
							_x call _fnc_findDataType;
						};
					}else{
						//Get the data from the global variable
						_tmpdata = missionNamespace getVariable [ _x, [] ];
						//recall this script with data
						_newList = [ _listType, _tmpdata, _newList ] call LARs_fnc_createList;
					};
				};

				//if weve passed an array of items, sides, global vars
				case ( typeName [] ) : {
					{
						//foreach item in the array recall this script
						_newList = [ _listType, _x, _newlist ] call LARs_fnc_createList;
					}forEach _x;
				};
			};
		}forEach _list;
	};

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
								_nul = _newlist pushBack _x;
							}forEach getArray( configFile >> "CfgPatches" >> _x >> "units" );
						}else{
							//Its a classname so push item into the list
							_nul = _newlist pushBack _x;
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
			if !( isNil "_x" ) then {

				{

					_item = _x;
					_index = -1;
					_itemType = _item call BIS_fnc_itemType;
					if !( ( _itemType select 0 ) isEqualTo "" ) then {
						switch ( _itemType select 0 ) do {
							case "Item" : {
								_index = 0;
							};
							case "Weapon" : {
//								_item = configName( configFile >> "CfgWeapons" >> _item );
								_index = 1;
							};
							case "Magazine" : {
								_index = 2;
							};
							case 'Mine' : {
								_index = 2;
							};
							case "Equipment" : {
								if ( ( _itemType select 1 ) isEqualTo 'Backpack' ) then {
									_index = 3;
								}else{
									_index = 0;
								};
							};
						};
					};
					if ( _index > -1 ) then {
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
					};
				}forEach _x;
			};
		}forEach _list;
	};
};

//If base pass clean the array and make lower case before returning
if ( _init && !( _listType isEqualTo "cargo" ) ) then {
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
	//make all items lower case
	_newList = _newList call LARs_fnc_toLower;
};

if ( _init ) then {
	switch( toLower _listType ) do {
		case ( "white" ) : {
			if ( count _newList < count _dataTypes ) then {
				_newList resize ( count _dataTypes );
			};
			_newList = _newList apply{ if( isNil "_x" ) then { [] }else{ _x } };
		};
		case ( "cargo" ) : {
			if ( count _newList < 4 ) then {
				_newList resize 4;
			};
			_newList = _newList apply{ if( isNil "_x" ) then { [] }else{ _x } };
		};
	};
};

_newList