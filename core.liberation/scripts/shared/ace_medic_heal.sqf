// by Lord_Kamephis
params ["_medic"];

private _injured = objNull;
private _deads = [];
private _units = units _medic;

while {alive _medic} do {
	sleep 5;
	// waaiting for wounded
	while {(isNull _injured) && (alive _medic)} do {
		if (_medic getvariable ["ACE_isUnconscious", false]) then {
			//hintSilent "AI medic[ACE]: I am injured...wait a sec!";
			_injured = _medic;
		} else {
			{
				if (!alive _x or isNull _x) then {
					_deads pushBack _x;
				};
				if ((isNull _injured) && (_x getvariable ["ACE_isUnconscious", false]) && (alive _x) && (!isNull _x)) then {			
					_injured = _x;
				};
			} foreach _units;
			_units = _units - _deads;
		};
		sleep 5;
	};

	if (_medic != _injured) then {
		//medic go for him
		//hintSilent "AI medic[ACE]: moving towards wounded...";
		if ([_medic, 80] call BIS_fnc_enemyDetected) then {_medic setUnitPos "MIDDLE"};
		while {(_medic distance _injured > 2) && (alive _injured) && (alive _medic) && (!isNull _injured)} do {		
			sleep 2;
			_medic moveTo getPosATL _injured;
			_medic doMove (position _injured);
		};
	};
	
	if ((alive _injured) && (!isNull _injured) && (alive _medic)) then {
		_medic allowDamage false;
		//hintSilent "AI medic[ACE]: Healing...";
		_medic playMove "AinvPknlMstpSnonWnonDnon_medic_1";
		sleep 5;
		[_injured] call ace_medical_treatment_fnc_fullHealLocal;
		[_injured, false] call ace_medical_fnc_setUnconscious;
		_medic allowDamage true;
		//hintSilent "AI medic[ACE]: Done !";
	};
	_injured = objNull;
	_medic setUnitPos "AUTO";
	_medic doFollow (leader group _medic);
};
