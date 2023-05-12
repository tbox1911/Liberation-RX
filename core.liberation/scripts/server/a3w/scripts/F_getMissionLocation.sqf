params ["_list"];

(selectRandom (blufor_sectors select {_x in _list && !(_x in A3W_sectors_in_use)}));