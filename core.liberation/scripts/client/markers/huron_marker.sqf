private [ "_huronlocal" ];

while { true } do {
	_huronlocal = [] call F_spartanScan;
	if ( !( isNull _huronlocal) ) then {
		"huronmarker" setmarkerposlocal (getPosATL _huronlocal);
	} else {
		"huronmarker" setmarkerposlocal markers_reset;
	};
	sleep 4.9;
};
