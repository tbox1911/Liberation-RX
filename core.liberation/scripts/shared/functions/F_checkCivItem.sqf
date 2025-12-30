params ["_class", "_type"];

if (_class == "") exitWith { true };

switch (_type) do {

	case "uniform": {
		private _uClass = getText (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "uniformClass");
		if (_uClass == "") exitWith { true };
		(getNumber (configFile >> "CfgVehicles" >> _uClass >> "side") == 3)
	};

	case "backpack": {
		if (_class select [0,5] == "B_Civ") exitWith { true };
		private _maxLoad = getNumber (configFile >> "CfgVehicles" >> _class >> "maximumLoad");
		(_maxLoad <= 160)
	};

	case "vest": {
		private _uClass = getText (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "containerClass");
		if (_uClass == "") exitWith { true };
		private _maxLoad = getNumber (configFile >> "CfgVehicles" >> _uClass >> "maximumLoad");
		private _armor = getNumber (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Chest" >> "armor");
		(_armor == 0 && _maxLoad <= 80)
	};

	default { true };
};
