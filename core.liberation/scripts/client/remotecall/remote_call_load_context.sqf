if ( isDedicated ) exitWith {};

params [ "_context" ];
if (count _context == 0 ) exitWith {};
systemChat "-------- Loading Squad Backup --------";

private _grp = group player;
private _pos = getPosATL player;
[player, _context select 1] call F_setLoadout;

{
    _unit = _grp createUnit [ (_x select 0), _pos, [], 5, "NONE"];
    sleep 0.1;
    _unit setPosATL (_pos vectorAdd [([] call F_getRND), ([] call F_getRND), 0.5]);
    [_unit] joinSilent _grp;
    _unit setMass 10;
    _unit setUnitRank (_x select 1);
	_unit setSkill (0.6 + (GRLIB_rank_level find (_x select 1)) * 0.05);
    _unit setVariable ["PAR_Grp_ID", format["Bros_%1",PAR_Grp_ID], true];
    _unit enableIRLasers true;
    _unit enableGunLights "Auto";
    [_unit, _x select 2] call F_setLoadout;
    sleep 0.1;
} foreach (_context select 2);

_grp selectLeader player;
