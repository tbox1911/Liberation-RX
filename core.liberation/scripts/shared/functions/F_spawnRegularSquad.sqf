diag_log format [ "Spawning regular squad at %1", time ];

params [ "_sector", "_squadies_to_spawn" ];
private [ "_sectorpos", "_spawnpos", "_grp", "_unitidx", "_corrected_amount" ];

_corrected_amount = round ( (count _squadies_to_spawn) * ([] call F_adaptiveOpforFactor) );
_grp = createGroup [GRLIB_side_enemy, true];
{
	if ( ( count units _grp ) < _corrected_amount) then {
		_spawnpos = zeropos;
		_max_try = 10;

		while { (_spawnpos isEqualTo zeropos) && _max_try > 0 } do {
			_safepos = [getMarkerPos _sector, 5, 200, 1, 0, 0, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
			_spawnpos = _safepos findEmptyPosition [1, 20, "B_Heli_Light_01_F"];
			if ( count _spawnpos == 0 ) then { _spawnpos = zeropos } else {
				if ( surfaceIsWater _spawnpos ) then { _spawnpos = zeropos };
			};
			_max_try = _max_try - 1;
		};
		if (!(_spawnpos isEqualTo zeropos)) then {
			_x createUnit [([_spawnpos, floor(random 300), random 360] call BIS_fnc_relPos), _grp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]'];
		};
	};
	sleep 0.1;
} foreach _squadies_to_spawn;

if ( _sector in sectors_capture ) then {
	_unitidx = 0;
	{
		[ _x ] spawn ( militia_standard_squad select _unitidx );
		if ( floor(random 100) < 40 ) then {
			_x addPrimaryWeaponItem "acc_flashlight";
		};
		_unitidx = _unitidx + 1;
		if ( _unitidx > 9 ) then { _unitidx = 0 };
	} foreach (units _grp);
};

diag_log format [ "Done Spawning regular squad (%1) at %2", count (units _grp), time ];

_grp;
