// Initialize ACE

R3F_LOG_CFG_can_tow = [];
R3F_LOG_CFG_can_be_towed = [];
R3F_LOG_CFG_can_lift = [];
R3F_LOG_CFG_can_be_lifted = [];
R3F_LOG_CFG_can_transport_cargo = [];
R3F_LOG_CFG_can_be_transported_cargo = [];
R3F_LOG_CFG_can_be_moved_by_player = [];

call compileFinal preprocessFileLineNUmbers format ["R3F_LOG\addons_config\Liberation.sqf"];
call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_r3f.sqf", GRLIB_mod_west];
call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_r3f.sqf", GRLIB_mod_east];

// return cargo space or cargo size
ACE_getSize = {
    params ["_object", "_list"];
	private _ret = 0;
    private _class = (typeOf _object);
	{
	  if (_class isKindOf _x) then { _ret = (_list select 1) select _forEachIndex };
	} foreach (_list select 0);
	_ret;
};

GRLIB_cargoSpace = [];
GRLIB_cargoSize = [];

// Vehicles & Objects cargo space
GRLIB_cargoSpace = [R3F_LOG_CFG_can_transport_cargo, 2] call F_invertArray;
// Objects that can be transported with its size
GRLIB_cargoSize = [R3F_LOG_CFG_can_be_transported_cargo, 2] call F_invertArray;
// Objects that can be moved
GRLIB_movableObjects = [] + boats_names + R3F_LOG_CFG_can_be_moved_by_player;
// Adding each buildings to movableObjects
{GRLIB_movableObjects pushback (_x select 0);} foreach buildings;

// Set object movable with ACE.
{
    [_x, "init", { [(_this select 0), true, [0, 3, 1], 0] call ace_dragging_fnc_setDraggable }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach GRLIB_movableObjects;

// Set object carryable with ACE.
{
    [_x, "init", { [(_this select 0), true, [0, 3, 1], 0] call ace_dragging_fnc_setCarryable }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach (GRLIB_cargoSize select 0);

//Set the cargo space of vehicles.
{
    [_x, "init", { [(_this select 0), ([(_this select 0), GRLIB_cargoSpace] call ACE_getSize)] call ace_cargo_fnc_setSpace }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach (GRLIB_cargoSpace select 0);

//Set the cargo size of objects.
{
    [_x, "init", { [(_this select 0), ([(_this select 0), GRLIB_cargoSize] call ACE_getSize)] call ace_cargo_fnc_setSize }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach (GRLIB_cargoSize select 0);

// Set ACE Medical Facility
{ 
    [_x, "init", { (_this select 0) setVariable ["ace_medical_isMedicalFacility",true, true] }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach ai_healing_sources;

// R3F functions
call compile preprocessFile "R3F_LOG\fonctions_generales\lib_geometrie_3D.sqf";
R3F_LOG_FNCT_objet_deplacer = compile preprocessFile "R3F_LOG\objet_deplacable\deplacer.sqf";

// Force Arsenal Filter Strict mode 3
//if (GRLIB_filter_arsenal == 2) then {GRLIB_filter_arsenal = 3};

// Add missing objects
support_vehicles append [["ACE_Wheel",0,0,1,0]];
support_vehicles append [["ACE_Track",0,0,1,0]];
