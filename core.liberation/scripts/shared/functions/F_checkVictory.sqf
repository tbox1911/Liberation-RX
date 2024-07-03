private _ret = false;

switch (GRLIB_victory_condition) do {
	// All Sectors captured
	case 0: { _ret = (count opfor_sectors == 0) };

	// 80% Sectors captured
	case 1: {
		_ret = ((count blufor_sectors / count sectors_allSectors) >= 0.8)
	};

	// All Radio Towers captured
	case 2: {
		_ret = ({ _x in opfor_sectors} count sectors_tower == 0)
	};

	// All Military Sectors captured
	case 3: {
		_ret = ({ _x in opfor_sectors} count sectors_military == 0)
	};

	// All Big Cities captured
	case 4: {
		_ret = ({ _x in opfor_sectors} count sectors_bigtown == 0)
	};

	// 2500 Intel points
	case 5: { _ret = (resources_intel >= 2500) };

	//case 6: { _ret = false };
};

_ret;
