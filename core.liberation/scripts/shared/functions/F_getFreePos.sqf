private _cnt = 1;
private _pos = [([[-300,0,300]] call F_getRND), ([[-300,0,300]] call F_getRND), (10000 + random 20000)];

while { !isNull (nearestObject _pos) && _cnt < 25 } do {
	_pos = [([[-300,0,300]] call F_getRND), ([[-300,0,300]] call F_getRND), (10000 + random 20000)];
	_cnt = _cnt + 1;
};

_pos;
