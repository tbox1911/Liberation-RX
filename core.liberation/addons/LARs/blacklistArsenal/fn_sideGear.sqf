
LARs_sideGear = [
	[  ],	//east
	[  ],	//west
	[  ],	//independent
	[  ]	//civilian
];

_fnc_LinkedWeaponItems = {
	private [ "_item" ];
	"
		if ( isText( _x >> 'Item' ) ) then {
			_item = getText( _x >> 'Item' );
			if ( count _item > 0 && { !( _item in _gear ) } ) then {
				_nul = _gear pushBack ( getText( _x >> 'Item' ) );
			};
		};
	"configClasses _this;
};

_fnc_transClasses = {
	params[
		[ "_class", ""],
		[ "_type", ""]
	];
	"
		if ( isText( _x >> _type ) ) then {
			_item = getText( _x >> _type );
			if !( _item in _gear ) then {
				_nul = _gear pushBack _item;
			};
		};
	"configClasses _class;
};


"
	_cfgName = configname _x;
	switch ( true ) do {

		comment'Soldiers';
		case ( _cfgName iskindof 'CAManBase' && isNumber( _x >> 'side' ) ) : {
			_side = getNumber( _x >> 'side' );
			if ( _side in [0,1,2,3] ) then {
				_gear = ( LARs_sideGear select _side );
				{
					{
						if ( count _x > 0 && { !( _x in _gear ) } ) then {
							_nul = _gear pushback _x;
						};
					}foreach _x;
				}foreach [
					getArray ( _x >> 'allowedHeadgear' ),
					getArray( _x >> 'allowedHeadgearB' ),
					getArray( _x >> 'allowedHeadgearSides' ),
					getArray( _x >> 'allowedUniformSides' ),
					getArray( _x >> 'linkedItems' ),
					getArray( _x >> 'magazines' ),
					getArray( _x >> 'RespawnItems' ),
					getArray( _x >> 'respawnLinkedItems' ),
					getArray( _x >> 'respawnMagazines' )
				];

				{
					_weapon = _x;
					if !( _weapon in [ 'Throw', 'Put' ] ) then {
						_base = _x call BIS_fnc_baseWeapon;
						if !( _base in _gear ) then {
							_nul = _gear pushback _base;
						};

						( configFile >> 'CfgWeapons' >> _weapon >> 'linkedItems' ) call _fnc_LinkedWeaponItems;
					};
					{
						_mags = if ( _x isequalto 'this' ) then {
							getArray( configFile >> 'CfgWeapons' >> _weapon >> 'magazines' )
						}else{
							getArray( configFile >> 'CfgWeapons' >> _weapon >> _x >> 'magazines' )
						};
						{
							if !( _x in _gear ) then {
								_nul = _gear pushBack _x;
							};
						}forEach _mags;
					}foreach getArray( configfile >> 'CfgWeapons' >> _weapon >> 'muzzles' );

				}foreach ( getArray( _x >> 'weapons' ) );

				if !( getText( _x >> 'uniformClass' ) in _gear ) then {
					_nul = _gear pushback getText( _x >> 'uniformClass' );
				};

				if !( getText( _x >> 'backpack' ) in _gear ) then {
					_nul = _gear pushback getText( _x >> 'backpack' );
				};

				LARs_sideGear set [ _side, _gear ];
			};
		};

		comment'special backpacks';
		case ( _cfgName isKindOf 'ReammoBox' && ( isText( _x >> 'faction' ) ) ) : {
			_faction = getText( _x >> 'faction' );
			_side = getNumber( configfile >> 'CfgFactionClasses' >> _faction >> 'side' );
			if ( _side in [0,1,2,3] ) then {
				_gear = LARs_sideGear select _side;
				if !( _cfgName in _gear ) then {
					_nul = _gear pushBack _cfgName;
				};
				LARs_sideGear set [ _side, _gear ];
			};
		};

		comment'Ammo boxes';
		case ( _cfgName iskindof 'ReammoBox_F' ) : {
			_side = switch ( tolower( ( _cfgName splitstring '_' ) select 1 ) ) do {
				case ( 'east' ) : {
					0
				};
				case ( 'fia' ) : {
					0
				};
				case ( 'nato' ) : {
					1
				};
				case ( 'ind' ) : {
					2
				};
			};
			if ( _side in [0,1,2,3] ) then {
				_gear = LARs_sideGear select _side;
				{
					_x call _fnc_transClasses;
				}foreach [
					[ ( _x >> 'TransportItems' ), 'name' ],
					[ ( _x >> 'TransportMagazines' ), 'magazine' ],
					[ ( _x >> 'TransportWeapons' ), 'weapon' ]
				];
				LARs_sideGear set [ _side, _gear ];
			};
		};

	};
"configClasses ( configFile >> "CfgVehicles" );

"
	_cfgName = configname _x;
	_cfg = _x;
	if ( getNumber( _cfg >> 'scope') isEqualTo 2 ) then {

		switch ( true ) do {

			comment 'Uniforms';
			case ( _cfgName isKindOf [ 'Uniform_Base', configFile >> 'CfgWeapons' ] ) : {

				_baseMan = getText( _cfg >> 'ItemInfo' >> 'uniformClass' );
				_side = getNumber( configfile >> 'CfgVehicles' >> _baseman >> 'side' );
				if ( _side in [0,1,2,3] ) then {
					_gear = ( LARs_sideGear select _side );
					_nul = _gear pushBackUnique _cfgName;
					LARs_sideGear set [ _side, _gear ];
				};
			};

			comment 'Vests';
			case ( _cfgName isKindOf [ 'Vest_Camo_Base', configFile >> 'CfgWeapons' ] || _cfgName isKindOf [ 'Vest_NoCamo_Base', configFile >> 'CfgWeapons' ] ) : {

				_found = false;
				{
					if ( [ _x, getText( _cfg >> 'displayName' ) ] call BIS_fnc_inString ) exitWith {
						_gear = LARs_sideGear select _forEachIndex;
						_nul = _gear pushBackUnique _cfgName;
						LARs_sideGear set [ _forEachIndex, _gear ];
						_found = true;
					};
				}forEach [ 'CSAT', 'NATO', 'AAF' ];
				if ( _found ) exitwith {};

				{
					_side = _x;
					if ( _side in ( getText( _cfg >> 'ItemInfo' >> 'uniformModel' ) splitString '\' ) ) exitwith {
						_gear = LARs_sideGear select _forEachIndex;
						_nul = _gear pushBackUnique _cfgName;
						LARs_sideGear set [ _forEachIndex, _gear ];
					};
				}forEach [ 'OPFOR', 'BLUFOR', 'INDEP', 'Civil' ];
			};

			comment 'Headgear';
			case ( _cfgName isKindOf [ 'H_HelmetB', configFile >> 'CfgWeapons' ] || _cfgName isKindOf [ 'HelmetBase', configFile >> 'CfgWeapons' ] ) : {

				_found = false;
				{
					if ( [ _x, getText( _cfg >> 'displayName' ) ] call BIS_fnc_inString ) exitWith {
						_gear = LARs_sideGear select _forEachIndex;
						_nul = _gear pushBackUnique _cfgName;
						LARs_sideGear set [ _forEachIndex, _gear ];
						_found = true;
					};
				}forEach [ 'CSAT', 'NATO', 'AAF' ];
				if ( _found ) exitwith {};

				{
					_side = _x;
					if ( _side in ( getText( _cfg >> 'ItemInfo' >> 'uniformModel' ) splitString '\' ) ) exitwith {
						_gear = LARs_sideGear select _forEachIndex;
						_nul = _gear pushBackUnique _cfgName;
						LARs_sideGear set [ _forEachIndex, _gear ];
						_found = true;
					};
				}forEach [ 'OPFOR', 'BLUFOR', 'INDEP', 'Civil' ];
				if ( _found ) exitwith {};

				{
					switch ( _side ) do {
						case 0;
						case 1;
						case 2 : {
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

				}forEach getArray( _cfg >> 'ItemInfo' >> 'modelSides' );
			};
		};
	};
" configClasses ( configFile >> "CfgWeapons" );

"
	_cfg = _x;
	_cfgName = configName _cfg;
	if ( getNumber( _cfg >> 'scope') isEqualTo 2 ) then {
		{
			_gear = LARs_sideGear select _x;
			_nul = _gear pushBackUnique _cfgName;
			LARs_sideGear set [ _x, _gear ];
		}forEach [0,1,2,3];
	};
" configClasses ( configFile >> "CfgGlasses" );

{
	_gear = _x - [ "" ];
	_gear = _gear arrayIntersect _gear;
	LARs_sideGear set [ _forEachIndex, _gear ];
}forEach LARs_sideGear;
LARs_sideGear = LARs_sideGear call LARs_fnc_toLower;

//diag_log "-------- LARs Arsenal Initialized --------";