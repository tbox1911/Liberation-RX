params[ [ "_list", [] ] ];

//Fix for weapon name compares ( sigh )
{
	if !( isNil "_x" ) then {
		_tmp = _x;
		{
			_weaponName = _x call BIS_fnc_baseWeapon;
			_tmp set [ _forEachIndex, _weaponName ];
		}forEach _tmp;
	};
}forEach ( _list select [ 0, 3 ] );
	
_list