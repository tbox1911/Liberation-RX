waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "huron_typename"};

private _vehicleClassnames = [huron_typename] + all_friendly_classnames;
private _objects_to_mark = [];
{ _objects_to_mark pushBackUnique (_x select 0) } forEach (buildings + support_vehicles);
private _zeusunits = [];
private _units_to_remove = [];

while {true} do {

	waitUntil { sleep 1; count allCurators > 0 };

	// BLU / RED units
	_zeusunits = [];
	{
		if ((_x distance2D lhd > 500) && alive _x) then {
			_zeusunits pushback _x;
		};
	} foreach (units GRLIB_side_friendly) + (units GRLIB_side_enemy);

	{
		if ((typeof _x in _vehicleClassnames ) && (typeof _x != ammobox_o_typename) && (( _x distance2D lhd > 500 ) || (typeof _x == huron_typename)) && alive _x ) then {
			_zeusunits pushback _x;
		};
	} foreach vehicles;

	//all building around fob
	private _buildings = [];
	{
		_buildings = (nearestObjects [_x, _objects_to_mark, GRLIB_fob_range]);
		_zeusunits = _zeusunits + _buildings;
	} forEach GRLIB_all_fobs;

	_zeusunits = _zeusunits + switchableUnits;
	_zeusunits = _zeusunits + playableUnits;
	_zeusunits = _zeusunits - (curatorEditableObjects (allCurators select 0));

	_units_to_remove = [];
	{
		if ( !(alive _x) ) then {
			_units_to_remove pushback _x;
		};
	} foreach (curatorEditableObjects (allCurators select 0));

	{
		_zgm = _x;
		_zgm addCuratorEditableObjects [_zeusunits, true];
		_zgm removeCuratorEditableObjects [_units_to_remove, true];
		_zgm setCuratorCoef ["edit", 0];
		_zgm setCuratorCoef ["place", 0];
		_zgm setCuratorCoef ["synchronize", 0];
		_zgm setCuratorCoef ["delete", 0];
		_zgm setCuratorCoef ["destroy", 0];
	} foreach allCurators;


	if (!isNil "GRLIB_active_commander") then {
		if !(GRLIB_active_commander in (call BIS_fnc_listCuratorPlayers)) then {
			GRLIB_active_commander assignCurator (allCurators select 0);
		};
	};

	sleep 20;
};