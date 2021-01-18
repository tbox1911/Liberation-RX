params[ [ "_whiteList", []  ], [ "_blackList", [] ] ];

//Remove blacklist items from the whitelist
//{
//	_item = _x;
//	{
//		if ( !isNil "_x" && { _item in _x } ) then {
//			_tmp = _x - [ _item ];
//			_whiteList set [ _forEachIndex, _tmp ];
//		};
//	}forEach _whiteList;
//}forEach _blackList;
//
//_whiteList

{
	_item = _x;
	{
		if ( _x isEqualType "" && { _item == _x } ) then {
			_whiteList set[ _forEachIndex, objNull ];
		};
	}forEach _whiteList;
}forEach _blackList;

_whiteList = _whiteList - [ objNull ];

_whiteList