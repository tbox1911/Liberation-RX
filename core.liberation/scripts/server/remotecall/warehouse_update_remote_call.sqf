params ["_owner"];
private _warehouse = _owner getVariable ["GRLIB_Warehouse", ObjNull];
systemchat format ["update:%1 %2", _owner, _warehouse];

// hide object
// hideObjectGlobal myObject;
// {
// } foreach GRLIB_warehouse;	
