// LRX AI Logistics System - init

GRLIB_AI_logistic_in_use = false;

open_ai_logistic = compileFinal preprocessFileLineNumbers "addons\LOG\open_ai_logistic.sqf";

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- AI Logistics System Initialized --------";