params ["_target", "_caller", "_actionId", "_arguments"];

// check if storage aera exist ?

// select transport
private _transport = [] call open_ai_logistic;
if (isNull _transport) exitWith {};

gamelogic globalChat "--- Work in progress !! ---";

if !(isNull (driver _transport)) exitWith { gamelogic globalChat "Transport driver seat must be empty !" };

// select destination

GRLIB_AI_logistic_in_use = true;

// when near dest collect all ressource in radius (upto transport capa)

// if truck is full go back to fob

// wait for another destination

// when back to fob, unload ressource to storage

// wait timer, if timeout delete

sleep 10;
GRLIB_AI_logistic_in_use = false;
