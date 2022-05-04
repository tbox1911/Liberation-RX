params [ "_position", "_distance", "_side" ];
private [ "_infantrycount", "_countedvehicles", "_vehiclecrewcount" ];

_infantrycount = { alive _x && _x distance2D _position <= _distance && !(captive _x) && isNull objectparent _x && (getPosATL _x) select 2 < 200 } count units _side;
_infantrycount = _infantrycount + { alive _x && _x distance2D _position <= _distance && _x getVariable ["PAR_Grp_ID", ""] != "" } count units GRLIB_side_civilian;
_countedvehicles =  [ ( _position nearEntities [ ["Car", "Tank", "Air", "Ship"], _distance] ), { (getPosATL _x) select 2 < 200 && speed _x <= 100 && count (crew _x) > 0 } ] call BIS_fnc_conditionalSelect;
_vehiclecrewcount = 0;
{ _vehiclecrewcount = _vehiclecrewcount + (_side countSide (crew _x)) } foreach _countedvehicles;

(_infantrycount + _vehiclecrewcount)
