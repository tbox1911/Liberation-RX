params ["_vehicle"];

if (!GRLIB_ACE_enabled) exitWith {};
if (isNull _vehicle) exitWith {};

private _vehicle_class = typeOf _vehicle;

// Check Blacklist
if (_vehicle_class in GRLIB_ACE_blacklist) exitWith {};

// Set object movable with ACE.
if ([_vehicle_class, GRLIB_ACE_movable] call F_itemIsInClass) then {
    [_vehicle, true, [0, 3, 1], 0] call ace_dragging_fnc_setCarryable;
    // _vehicle setVariable ["ace_dragging_ignoreWeightCarry", true, true];
};

//Set the cargo size of objects.
if ([_vehicle_class, (GRLIB_ACE_cargoSize select 0)] call F_itemIsInClass) then {
    [_vehicle, true, [0, 3, 1], 0] call ace_dragging_fnc_setCarryable;
    _vehicle setVariable ["ace_dragging_ignoreWeightCarry", true, true];
    [_vehicle, ([_vehicle, GRLIB_ACE_cargoSize] call ACE_getSize)] call ace_cargo_fnc_setSize;
};
_vehicle setVariable ["ace_cargo_noRename", true, true];

//Set the cargo space of vehicles.
if ([_vehicle_class, (GRLIB_ACE_cargoSpace select 0)] call F_itemIsInClass) then {
    // [_vehicle, ([_vehicle, GRLIB_ACE_cargoSpace] call ACE_getSize)] call ace_cargo_fnc_setSpace;
    _vehicle setVariable ["ace_cargo_hasCargo", true, true];
    _vehicle setVariable ["ace_cargo_space", ([_vehicle, GRLIB_ACE_cargoSpace] call ACE_getSize), true];
};

// Set ACE Medical Facility
if ([_vehicle_class, ai_healing_sources] call F_itemIsInClass) then {
    _vehicle setVariable ["ace_medical_isMedicalFacility", true, true];
};

// Clean ACE Cargo
{ [_x, _vehicle] call ace_cargo_fnc_removeCargoItem } forEach (_vehicle getVariable ["ace_cargo_loaded", []]);
