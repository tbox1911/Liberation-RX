
private [ "_ret", "_list", "_res" ];
_list = _this;

//list maybe nil if working on a created list that has had items pushed into high indexes
if !( isNil "_list" ) then {

	//if weve passed an array
	if ( typeName _this isEqualTo typeName [] ) then {
		_ret =  [];
		//for each item
		{
			_res = nil;
			if !( isNil "_x" ) then {
				//recall function with item it could be a STRING item or a sub array
				_res = _x call LARs_fnc_tolower;
			};
			//if returned item is nil
			if ( isNil "_res" ) then {
				//set index as nil
				_ret set [ _forEachIndex, nil ];
			}else{
				//else push result back into array
				_ret pushBack _res;
			};
		}forEach _list;
	}else{
		//if passed _list is a STRING item or global var ( not needed for Gvar but Gvars are not case sensitive so does not hurt )
		if ( typeName _list isEqualTo typeName "" ) then {
			//turn to lower case
			_ret = toLower _list;
		}else{
			//its a side just return it
			_ret = _list;
		};
	};
}else{
	//just return nil
	_ret = nil;
};

//return results
_ret
