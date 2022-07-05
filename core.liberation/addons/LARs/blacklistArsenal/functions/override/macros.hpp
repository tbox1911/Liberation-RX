//item, weapon, magazine, backpack
#define CONDITION( GEAR ) switch ( toUpper (( GEAR call BIS_fnc_itemType ) select 0 ) ) do { \
	case ( "EQUIPMENT" ) : { \
		switch ( toUpper (( GEAR call BIS_fnc_itemType ) select 1 ) ) do { \
			case ( "BACKPACK" ) : { \
				(( toLower GEAR ) in ( _whitelist select 3 )) || { "%all" in ( _whiteList select 3 ) } \
			}; \
			default { \
				(( toLower GEAR ) in ( _whitelist select 0 )) || { "%all" in ( _whiteList select 0 ) } \
			}; \
		}; \
	}; \
	case ( "ITEM" ) : { \
		(( toLower GEAR ) in ( _whitelist select 0 )) || { "%all" in ( _whiteList select 0 ) } \
	}; \
	case ( "WEAPON" ) : { \
		(( toLower GEAR ) in ( _whitelist select 1 )) || { "%all" in ( _whiteList select 1 ) } \
	}; \
	case ( "MINE" ); \
	case ( "MAGAZINE" ) : { \
		(( toLower GEAR ) in ( _whitelist select 2 )) || { "%all" in ( _whiteList select 2 ) } \
	}; \
	default { \
		false \
	}; \
}