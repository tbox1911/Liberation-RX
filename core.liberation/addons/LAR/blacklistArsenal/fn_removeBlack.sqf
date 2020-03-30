params[ [ "_whiteList", []  ], [ "_blackList", [] ] ];

//Remove blacklist items from the whitelist
{
	_item = _x;
	{
		if ( !isNil "_x" && { _item in _x } ) then {
			_tmp = _x - [ _item ];
			_whiteList set [ _forEachIndex, _tmp ];
		};
	}forEach _whiteList;
}forEach _blackList;

_whiteList