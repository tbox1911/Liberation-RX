// LRX Warehouse
// by pSiKO

params ["_owner", "_caller", "_actionId", "_arguments"];

//createDialog "Warehouse";
//waitUntil { dialog };


private _display = findDisplay 2305;


//gamelogic globalChat localize "STR_SELL_WELCOME";
gamelogic globalChat "Welcome to the WareHouse";


[_owner] remoteExec ["warehouse_update_remote_call", 2]