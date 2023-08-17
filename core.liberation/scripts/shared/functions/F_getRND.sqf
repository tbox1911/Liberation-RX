// Return floor random number in _range
// never return 0
// check safe value _min +/-
//  diag_log  str ([[-10,0,10], 2] call F_getRND);
//  diag_log  str ([] call F_getRND);

params [["_range", [-10,0,10]], ["_min", 0]];
private _rnd = 0;  

while {!(_rnd != 0) || !(abs _rnd > _min)} do {
	_rnd = (floor random _range);
	sleep 0.1;
};   
_rnd;
