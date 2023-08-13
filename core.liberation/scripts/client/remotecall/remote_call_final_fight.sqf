private _msg = format ["%1, the <t color='#800000'>ARMAGEDDON</t> has begun...<br/><br/>Be ready for the <t color='#000080'>Final FIGHT</t> !<br/>", name player];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

sleep 3;

[0] spawn BIS_fnc_earthquake;

waitUntil { sleep 1; !isNil "opfor_target"};
waitUntil { sleep 1; sector_timer > 0};

// GUI
private _final_progressBar = findDisplay 46 ctrlCreate ["GREUH_Progress", -1]; 
private _position = [ 0.4, 0.1 + safeZoneY, 0.4, 0.05]; 
_final_progressBar ctrlSetPosition _position; 
_final_progressBar progressSetPosition 0; 
_final_progressBar ctrlCommit 0; 
 
private _final_text = findDisplay 46 ctrlCreate ["RscStructuredText", -1]; 
_final_text ctrlSetPosition _position;
_final_text ctrlSetStructuredText parseText format["<t size='1' align='center'>Enemy Damage: %1%2</t>", 0, "%"];
_final_text ctrlCommit 0;

private _progress = damage opfor_target;
while {sector_timer > 0 && _progress < 1} do {
	// GUI
	_progress = damage opfor_target;
	_final_progressBar progressSetPosition _progress;
	_final_text ctrlSetStructuredText parseText format["<t size='1' align='center'>Enemy Damage: %1%2</t>", round(100*_progress), "%"];
	sleep 2;
};

sector_timer = 0;
ctrlDelete _final_progressBar;
ctrlDelete _final_text;
