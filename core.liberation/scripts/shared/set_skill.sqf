params [ "_unit"];

private _side = side _unit;
private _wounded = false;
(group _unit) allowFleeing 0;
if ( damage _unit > 0.25 ) then { _wounded = true; };

private _skillmodifier = sqrt ai_skill;
private _inVehicle = false;
if ( vehicle _unit != _unit ) then {
	_inVehicle = true;
};

if ( !(GRLIB_autodanger) && (_side == GRLIB_side_friendly)) then {
	_unit disableAI "AUTOCOMBAT";
};

if ( _wounded ) then {
		_unit setSkill ["general", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingaccuracy", [ 0.2 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingspeed", [ 0.8 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingshake", [ 0.8 * _skillmodifier ] call limit_skill];
		_unit setSkill ["commanding", 0.9];
		_unit setSkill ["spotdistance", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["spottime", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["reloadSpeed", 0.9];
} else { // if ( _inVehicle ) then {};
	if ( _side == GRLIB_side_friendly || _side == GRLIB_side_enemy ) then {
		_unit setSkill ["general", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingaccuracy", [ 0.2 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingspeed", [ 0.8 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingshake", [ 0.8 * _skillmodifier ] call limit_skill];
		_unit setSkill ["commanding", 0.9];
		_unit setSkill ["spotdistance", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["spottime", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["reloadSpeed", 0.9];
	} else {
		_unit setSkill ["general", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingaccuracy", [ 0.2 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingspeed", [ 0.8 * _skillmodifier ] call limit_skill];
		_unit setSkill ["aimingshake", [ 0.8 * _skillmodifier ] call limit_skill];
		_unit setSkill ["commanding", 0.9];
		_unit setSkill ["spotdistance", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["spottime", [ 0.9 * _skillmodifier ] call limit_skill];
		_unit setSkill ["reloadSpeed", 0.9];
	};
	
	if (isNil 'AI_leader_radio') then {
		AI_leader_radio = false;
	};

	if ((AI_leader_radio) && (isFormationLeader _unit) && (side _unit == east)) then {
		if !(backpack _x == "B_RadioBag_01_ghex_F") then {
			_x addBackpack "B_RadioBag_01_ghex_F"
		};
		if !("Binocular" in assignedItems _x) then {
			_x linkItem "Binocular"
		};
	};
};
