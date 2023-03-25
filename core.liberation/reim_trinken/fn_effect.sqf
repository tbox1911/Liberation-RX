/*
	author = Reimchen
	description = n.a.
*/
missionNamespace setVariable ["Reim_effect",false];
while {true} do {
	waitUntil {missionNamespace getVariable "Reim_effect" == false};
	//leicht
	if (Reim_Var_Trinken < 3) then {
	resetCamShake;
	};
	
	if (Reim_Var_Trinken >= 3 && Reim_Var_Trinken <= 5) then {
		resetCamShake;
		missionNamespace setVariable ["Reim_effect",true];
		["ChromAberration", 5, [0.01, 0.01, true]] spawn { 
			params ["_name", "_priority", "_effect", "_handle"];
			while { 
				_handle = ppEffectCreate [_name, _priority]; 
				_handle < 0 
			} do { 
				_priority = _priority + 1; 
			}; 
			_handle ppEffectEnable true; 
			_handle ppEffectAdjust _effect;
			_handle ppEffectCommit 5;
			waitUntil {ppEffectCommitted _handle};
			_handle ppEffectAdjust [0,0, true]; 
			_handle ppEffectCommit 5;
			waitUntil {ppEffectCommitted _handle};
			missionNamespace setVariable ["Reim_effect",false];
			_handle ppEffectEnable false; 
			ppEffectDestroy _handle;
		};
	};

	//mittel
	if (Reim_Var_Trinken >= 6 && Reim_Var_Trinken <= 9) then {
		missionNamespace setVariable ["Reim_effect",true];
		addCamShake [5, 100, 0.5]; 
		["ChromAberration", 10, [0.03, 0.03, true]] spawn { 
			params ["_name", "_priority", "_effect", "_handle"]; 
			while { 
				_handle = ppEffectCreate [_name, _priority]; 
				_handle < 0 
			} do { 
				_priority = _priority + 1; 
			}; 
			_handle ppEffectEnable true; 
			_handle ppEffectAdjust _effect;
			_handle ppEffectCommit 5;
			waitUntil {ppEffectCommitted _handle};
			_handle ppEffectAdjust [0,0, true]; 
			_handle ppEffectCommit 5;
			waitUntil {ppEffectCommitted _handle};
			missionNamespace setVariable ["Reim_effect",false];
			_handle ppEffectEnable false; 
			ppEffectDestroy _handle;
		};
	};

	//stark
	if (Reim_Var_Trinken >= 10 && Reim_Var_Trinken <= 19) then {
		missionNamespace setVariable ["Reim_effect",true];
		addCamShake [10, 100, 0.5]; 
		["ChromAberration", 15, [0.05, 0.05, true]] spawn { 
			params ["_name", "_priority", "_effect", "_handle"]; 
			while { 
				_handle = ppEffectCreate [_name, _priority]; 
				_handle < 0 
			} do { 
				_priority = _priority + 1; 
			}; 
			_handle ppEffectEnable true; 
			_handle ppEffectAdjust _effect;
			_handle ppEffectCommit 4;
			waitUntil {ppEffectCommitted _handle};
			uiSleep 3;
			_handle ppEffectAdjust [0,0, true]; 
			_handle ppEffectCommit 8;
			waitUntil {ppEffectCommitted _handle};
			missionNamespace setVariable ["Reim_effect",false];
			_handle ppEffectEnable false; 
			ppEffectDestroy _handle;
		};
	};

	//sehr stark
	if (Reim_Var_Trinken >= 20) then {
		missionNamespace setVariable ["Reim_effect",true];
		addCamShake [15, 100, 0.5];
		["ChromAberration", 20, [0.1, 0.1, true]] spawn { 
			params ["_name", "_priority", "_effect", "_handle"]; 
			while { 
				_handle = ppEffectCreate [_name, _priority]; 
				_handle < 0
			} do {
				_priority = _priority + 1;
			};
			_handle ppEffectEnable true;
			_handle ppEffectAdjust _effect;
			_handle ppEffectCommit 3;
			waitUntil {ppEffectCommitted _handle};
			uiSleep 5;
			_handle ppEffectAdjust [0,0, true];
			_handle ppEffectCommit 10;
			waitUntil {ppEffectCommitted _handle};
			missionNamespace setVariable ["Reim_effect",false];
			_handle ppEffectEnable false;
			ppEffectDestroy _handle;
		};
	};
};
