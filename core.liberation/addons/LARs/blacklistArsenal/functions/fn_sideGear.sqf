
LARs_sideGear = [
	[  ],	//east
	[  ],	//west
	[  ],	//independent
	[  ]	//civilian
];

_fnc_LinkedWeaponItems = {
	private [ "_item" ];
	{
		if ( isText( _x >> "Item" ) ) then {
			_item = getText( _x >> "Item" );
			_nul = _gear pushBackUnique _item;
		};
	}forEach ( "true" configClasses _this );
};

_fnc_compatibleWeaponItems = {
	private [ "_item" ];
	{
		if ( isArray( _x >> "compatibleItems" ) ) then {
			{
				_nul = _gear pushBackUnique _x;
			}forEach getArray( _x >> "compatibleItems" );
		};
	}forEach ( "true" configClasses _this );
};

_fnc_transClasses = {
	params[
		[ "_class", ""],
		[ "_type", ""]
	];
	{
		if ( isText( _x >> _type ) ) then {
			_item = getText( _x >> _type );
			_nul = _gear pushBackUnique _item;
		};
	}forEach ( "true" configClasses _class );
};


//Config Vehicles - Soldiers, Backpacks and Ammo Boxes
{
	_cfgName = configName _x;
	switch ( true ) do {

		//Soldiers
		case ( _cfgName isKindOf "CAManBase" && isNumber( _x >> "side" ) ) : {
			_side = getNumber( _x >> "side" );
			if ( _side in [0,1,2,3] ) then {
				_gear = ( LARs_sideGear select _side );
				{
					{
						_nul = _gear pushBackUnique _x;
					}forEach _x;
				}forEach [
					getArray ( _x >> "allowedHeadgear" ),
					getArray( _x >> "allowedHeadgearB" ),
					getArray( _x >> "allowedHeadgearSides" ),
					getArray( _x >> "allowedUniformSides" ),
					getArray( _x >> "linkedItems" ),
					getArray( _x >> "magazines" ),
					getArray( _x >> "RespawnItems" ),
					getArray( _x >> "respawnLinkedItems" ),
					getArray( _x >> "respawnMagazines" )
				];

				{
					{
						_weapon = _x;
						if ( { _weapon == _x }count [ "Throw", "Put" ] isEqualTo 0 ) then {
							_base = _x call BIS_fnc_baseWeapon;
							_nul = _gear pushBackUnique _base;

							( configFile >> "CfgWeapons" >> _weapon >> "linkedItems" ) call _fnc_LinkedWeaponItems;
							( configFile >> "CfgWeapons" >> _weapon >> "weaponSlotsInfo" ) call _fnc_compatibleWeaponItems;
						};
						{
							_mags = if ( _x isEqualTo "this" ) then {
								getArray( configFile >> "CfgWeapons" >> _weapon >> "magazines" )
							}else{
								getArray( configFile >> "CfgWeapons" >> _weapon >> _x >> "magazines" )
							};
							{
								_nul = _gear pushBackUnique _x;
							}forEach _mags;
						}forEach getArray( configFile >> "CfgWeapons" >> _weapon >> "muzzles" );
					}forEach _x;

				}forEach [
					getArray( _x >> "weapons" ),
					getArray( _x >> "respawnWeapons" )
				];

				_gear pushBackUnique ( getText( _x >> "uniformClass" ));

				_gear pushBackUnique ( getText( _x >> "backpack" ));

				LARs_sideGear set [ _side, _gear ];
			};
		};

		//"special backpacks";
		case ( _cfgName isKindOf "ReammoBox" && ( isText( _x >> "faction" ) ) ) : {
			_faction = getText( _x >> "faction" );
			_side = getNumber( configFile >> "CfgFactionClasses" >> _faction >> "side" );
			if ( _side in [0,1,2,3] ) then {
				_gear = LARs_sideGear select _side;
				_nul = _gear pushBackUnique _cfgName;
				LARs_sideGear set [ _side, _gear ];
			}else{
				if( _side isEqualTo -1 ) then {
					{
						_gear = LARs_sideGear select _x;
						_nul = _gear pushBackUnique _cfgName;
						LARs_sideGear set [ _x, _gear ];
					}forEach [ 0, 1, 2, 3 ];
				};
			};
		};

		//"Ammo boxes";
		case ( _cfgName isKindOf "ReammoBox_F" ) : {
			_nameArray = _cfgName splitString "_";
			_sideName = if ( _nameArray select 1 == "t" ) then {
				_nameArray select 2
			}else{
				_nameArray select 1
			};
			_side = switch ( toLower _sideName ) do {
				case ( "east" ) : {
					0
				};
				case ( "fia" ) : {
					0
				};
				case ( "syndicate" ) : {
					0
				};
				case ( "csat" ) : {
					0
				};
				case ( "nato" ) : {
					1
				};
				case ( "aaf" ) : {
					1
				};
				case ( "ind" ) : {
					2
				};
				case ( "gen" );
				case ( "ied" ) : {
					3
				};
				
			};
			if ( _side in [0,1,2,3] ) then {
				_gear = LARs_sideGear select _side;
				{
					_x call _fnc_transClasses;
				}forEach [
					[ ( _x >> "TransportItems" ), "name" ],
					[ ( _x >> "TransportMagazines" ), "magazine" ],
					[ ( _x >> "TransportWeapons" ), "weapon" ]
				];
				LARs_sideGear set [ _side, _gear ];
			};
		};

	};
}forEach ( "getNumber( _x >> 'scope' ) isEqualTo 2" configClasses ( configFile >> "CfgVehicles" ));


//Config Weapons - Uniforms, Vests, Headgear and Bipods
{
	_cfgName = configName _x;
	_cfg = _x;
	

	switch ( true ) do {

		// "Uniforms";
		case ( _cfgName isKindOf [ "Uniform_Base", configFile >> "CfgWeapons" ] ) : {

			_baseMan = getText( _cfg >> "ItemInfo" >> "uniformClass" );
			_side = getNumber( configFile >> "CfgVehicles" >> _baseman >> "side" );
			if ( _side in [0,1,2,3] ) then {
				_gear = ( LARs_sideGear select _side );
				_nul = _gear pushBackUnique _cfgName;
				LARs_sideGear set [ _side, _gear ];
			};
		};

		// "Vests";
		case ( _cfgName isKindOf [ "Vest_Camo_Base", configFile >> "CfgWeapons" ] || _cfgName isKindOf [ "Vest_NoCamo_Base", configFile >> "CfgWeapons" ] ) : {

			_found = false;
			{
				if ( [ _x, getText( _cfg >> "displayName" ) ] call BIS_fnc_inString ) exitWith {
					_gear = LARs_sideGear select _forEachIndex;
					_nul = _gear pushBackUnique _cfgName;
					LARs_sideGear set [ _forEachIndex, _gear ];
					_found = true;
				};
			}forEach [ "CSAT", "NATO", "AAF" ];
				
			if !( _found ) then {
				
				{
					_side = _x;
					if ( _side in ( getText( _cfg >> "ItemInfo" >> "uniformModel" ) splitString "\" ) ) exitWith {
						if ( _forEachIndex < 4 ) then {
							_gear = LARs_sideGear select _forEachIndex;
							_nul = _gear pushBackUnique _cfgName;
							LARs_sideGear set [ _forEachIndex, _gear ];
						}else{
							//Its Common add it to all sides
							{
								_gear = LARs_sideGear select _forEachIndex;
								_nul = _gear pushBackUnique _cfgName;
								LARs_sideGear set [ _forEachIndex, _gear ];
							}forEach [ 0, 1, 2, 3 ];
						};
					};
				}forEach [ "OPFOR", "BLUFOR", "INDEP", "Civil", "Common" ];
			};
		};

		// "Headgear";
		case ( _cfgName isKindOf [ "H_HelmetB", configFile >> "CfgWeapons" ] || _cfgName isKindOf [ "HelmetBase", configFile >> "CfgWeapons" ] ) : {

			_found = false;
			{
				if ( [ _x, getText( _cfg >> "displayName" ) ] call BIS_fnc_inString ) exitWith {
					_gear = LARs_sideGear select _forEachIndex;
					_nul = _gear pushBackUnique _cfgName;
					LARs_sideGear set [ _forEachIndex, _gear ];
					_found = true;
				};
			}forEach [ "CSAT", "NATO", "AAF" ];
			
			if !( _found ) then {
				
				{
					_side = _x;
					if ( _side in ( getText( _cfg >> "ItemInfo" >> "uniformModel" ) splitString "\" ) ) exitWith {
						_gear = LARs_sideGear select _forEachIndex;
						_nul = _gear pushBackUnique _cfgName;
						LARs_sideGear set [ _forEachIndex, _gear ];
						_found = true;
					};
				}forEach [ "OPFOR", "BLUFOR", "INDEP", "Civil" ];
					
				if !( _found ) then {
					
					_modelSides = getArray( _cfg >> "ItemInfo" >> "modelSides" );
					
					if ( count ( _modelSides - [ 3 ] ) > 0 ) then {
						_modelSides = _modelSides - [ 3 ];
					};
					
					{
						_side = _x;
						switch ( _side ) do {
							case 0;
							case 1;
							case 2;
							case 3 : {
								_gear = LARs_sideGear select _side;
								_nul = _gear pushBackUnique _cfgName;
								LARs_sideGear set [ _side, _gear ];
							};
							case 6 : {
								{
									_gear = LARs_sideGear select _x;
									_nul = _gear pushBackUnique _cfgName;
									LARs_sideGear set [ _x, _gear ];
								}forEach [ 0, 1, 2, 3 ];
							};
						};
		
					}forEach _modelSides;
				};
			};
		};
		
		//Bipods
//		case ( _cfgName isKindOf [ "bipod_01_F_snd", configFile >> "CfgWeapons" ] || { _cfgName == "bipod_01_F_snd" } ) : {
//
//			{
//				if ( [ _x, getText( _cfg >> "displayName" ) ] call BIS_fnc_inString ) exitWith {
//					_gear = LARs_sideGear select _forEachIndex;
//					_nul = _gear pushBackUnique _cfgName;
//					LARs_sideGear set [ _forEachIndex, _gear ];
//				};
//			}forEach [ "CSAT", "NATO", "AAF" ];
//		};
	};
}forEach ( "getnumber( _x >> 'scope' ) isEqualTo 2" configClasses ( configFile >> "CfgWeapons" ));


//Config Glasses - Add Glasses to all sides
{
	_cfg = _x;
	_cfgName = configName _cfg;
	{
		_gear = LARs_sideGear select _x;
		_nul = _gear pushBackUnique _cfgName;
		LARs_sideGear set [ _x, _gear ];
	}forEach [0,1,2,3];
}forEach ( "getnumber( _x >> 'scope' ) isEqualTo 2" configClasses ( configFile >> "CfgGlasses" ));


{
	_gear = _x - [ "" ];
	_gear = _gear arrayIntersect _gear;
	LARs_sideGear set [ _forEachIndex, _gear ];
}forEach LARs_sideGear;


//diag_log "gear finished";