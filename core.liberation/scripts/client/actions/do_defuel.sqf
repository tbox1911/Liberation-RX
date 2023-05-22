params ["_vehicle"];
if (isNil "_vehicle") exitWith {};
private ["_fuel", "_can", "_result"];

_fuel = fuel _vehicle;
if (_fuel >= 0.25) then {
	_result = [format [localize "STR_DO_DEFUEL", typeOf _vehicle], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
	if (_result) then {
		buildtype = 9;
		build_unit = [canister_fuel_typename,[],1,[],[],[]];
		dobuild = 1;

		waitUntil { sleep 0.5; dobuild == 0 };
		if (build_confirmed == 0) then {
			[_vehicle, _fuel - 0.25] remoteExec ["setFuel", 0];
			hintSilent localize "STR_FUEL_READY";
		};
	};
};
