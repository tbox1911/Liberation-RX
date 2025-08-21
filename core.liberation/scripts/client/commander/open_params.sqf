if (isDedicated || !hasInterface) exitWith {};

waitUntil {!(isNull (findDisplay 46))};
disableUserInput false;
disableUserInput true;
disableUserInput false;

if ( !([] call is_admin) && !GRLIB_ParamsInitialized) then {
	waitUntil {
		titleText [localize "STR_WAITING_FOR_LRX_CONFIG", "BLACK FADED", 100];
		uIsleep 2;
		titleText [localize "STR_PLEASE_WAIT", "BLACK FADED", 100];
		uIsleep 2;
		GRLIB_ParamsInitialized;
	};
	titleText ["", "BLACK FADED", 100];
};
if !([] call is_admin) exitWith { disableUserInput true };

waitUntil { sleep 0.5; !isNil "GRLIB_LRX_params" };
[] call GRLIB_CreateParamDialog;

waitUntil { sleep 0.1; !GRLIB_DialogOpen };
disableUserInput true;
