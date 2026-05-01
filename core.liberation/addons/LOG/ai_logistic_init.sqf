// LRX AI Logistics System - init

GRLIB_AI_logistic_in_use = false;
GRLIB_AI_logistic_continue = false;

ai_logistic_end = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_end.sqf";
ai_logistic_open = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_open.sqf";
ai_logistic_dest = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_dest.sqf";
ai_logistic_return = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_return.sqf";
ai_logistic_failed = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_failed.sqf";
ai_logistic_unload = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_unload.sqf";
ai_logistic_collect = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_collect.sqf";
ai_logistic_pickdest = compileFinal preprocessFileLineNumbers "addons\LOG\ai_logistic_pickdest.sqf";

GRLIB_AI_logistic_ressources = [
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
    waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	basic_weapon_typename
];

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- AI Logistics System Initialized --------";