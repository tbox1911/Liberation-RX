hs_MPhint = { hint _this };
/* USE:
_hs_hint = format['_crate: %1', typeOf _crate];
[_hs_hint, 'hs_MPhint'] call BIS_fnc_mp;
*/


lose_resources = compileFinal "
	_price_s = 25;
	_price_a = 25;
	_price_f = 25;
	
	_nearfob = [] call KPLIB_fnc_getNearestFob;
	
	if ((_nearfob select 0) > 0) then {
		_storage_areas = (_nearfob nearobjects 100000) select {(_x getVariable ['KP_liberation_storage_type',-1]) == 0};
		
		{
			private _storage_positions = [];
			private _storedCrates = (attachedObjects _x);
			reverse _storedCrates;

			{
				_crateValue = _x getVariable ['KP_liberation_crate_value',0];

				switch ((typeOf _x)) do {
					case KP_liberation_supply_crate: {
						if (_price_s > 0) then {
							if (_crateValue > _price_s) then {
								_crateValue = _crateValue - _price_s;
								_x setVariable ['KP_liberation_crate_value', _crateValue, true];
								_price_s = 0;
							} else {
								detach _x;
								deleteVehicle _x;
								_price_s = _price_s - _crateValue;
							};
						};
					};
					case KP_liberation_ammo_crate: {
						if (_price_a > 0) then {
							if (_crateValue > _price_a) then {
								_crateValue = _crateValue - _price_a;
								_x setVariable ['KP_liberation_crate_value', _crateValue, true];
								_price_a = 0;
							} else {
								detach _x;
								deleteVehicle _x;
								_price_a = _price_a - _crateValue;
							};
						};
					};
					case KP_liberation_fuel_crate: {
						if (_price_f > 0) then {
							if (_crateValue > _price_f) then {
								_crateValue = _crateValue - _price_f;
								_x setVariable ['KP_liberation_crate_value', _crateValue, true];
								_price_f = 0;
							} else {
								detach _x;
								deleteVehicle _x;
								_price_f = _price_f - _crateValue;
							};
						};
					};
					default {[format ['Invalid object (%1) at storage area', (typeOf _x)], 'ERROR'] call KPLIB_fnc_log;};
				};
			} forEach _storedCrates;

			([_x] call KPLIB_fnc_getStoragePositions) params ['_storage_positions'];

			private _area = _x;
			_i = 0;
			{
				_height = [typeOf _x] call KPLIB_fnc_getCrateHeight;
				detach _x;
				_x attachTo [_area, [(_storage_positions select _i) select 0, (_storage_positions select _i) select 1, ((_storage_positions select _i) select 2) + _height]];
				_i = _i + 1;
			} forEach attachedObjects (_x);

			if ((_price_s == 0) && (_price_a == 0) && (_price_f == 0)) exitWith {};

		} forEach _storage_areas;

		please_recalculate = true;
	};
";


gain_resources = compileFinal "

	params ['_boxes_of_each'];
	
	_box_s = _boxes_of_each;
	_box_a = _boxes_of_each;
	_box_f = _boxes_of_each;
	
	_nearfob = [] call KPLIB_fnc_getNearestFob; sleep 1;
	
	if ((_nearfob select 0) > 0) then {
		_storage_areas = (_nearfob nearobjects 100000) select {(_x getVariable ['KP_liberation_storage_type',-1]) == 0};
		
		{
			private _storage_positions = [];
			([_x] call KPLIB_fnc_getStoragePositions) params ['_storage_positions']; sleep 1;
			_max_storage = count _storage_positions;
			
			private _storedCrates = (attachedObjects _x);
			reverse _storedCrates;
			_count_crates = count _storedCrates;
			
			private _pos = getPos _x;
			
			
			while { _box_s > 0 && _count_crates < _max_storage } do {
				private _crate = KP_liberation_supply_crate createVehicle _pos;
				_crate setMass 500;
				_crate setVariable ['KP_liberation_crate_value', 100, true];
				if (KP_liberation_ace) then {[_crate, true, [0, 1.5, 0], 0] remoteExec ['ace_dragging_fnc_setCarryable'];};
				[_crate] call KPLIB_fnc_addObjectInit; sleep 1;
				 _crate attachTo [_x, [0, 1.5, 0]];
				_box_s = _box_s - 1;
				sleep 1;
			};

			while { _box_a > 0 && _count_crates < _max_storage } do {
				_crate = KP_liberation_ammo_crate createVehicle _pos;
				_crate setMass 500;
				_crate setVariable ['KP_liberation_crate_value', 100, true];
				if (KP_liberation_ace) then {[_crate, true, [0, 1.5, 0], 0] remoteExec ['ace_dragging_fnc_setCarryable'];};
				[_crate] call KPLIB_fnc_addObjectInit; sleep 1;
				 _crate attachTo [_x, [0, 1.5, 0]];
				_box_a = _box_a - 1;
				sleep 1;
			};

			while { _box_f > 0 && _count_crates < _max_storage } do {
				_crate = KP_liberation_fuel_crate createVehicle _pos;
				_crate setMass 500;
				_crate setVariable ['KP_liberation_crate_value', 100, true];
				if (KP_liberation_ace) then {[_crate, true, [0, 1.5, 0], 0] remoteExec ['ace_dragging_fnc_setCarryable'];};
				[_crate] call KPLIB_fnc_addObjectInit; sleep 1;
				 _crate attachTo [_x, [0, 1.5, 0]];
				_box_f = _box_f - 1;
				sleep 1;
			};

			
			private _area = _x;
			_i = 0;
			{
				_height = [typeOf _x] call KPLIB_fnc_getCrateHeight; sleep 0.1;
				detach _x;
				_x attachTo [_area, [(_storage_positions select _i) select 0, (_storage_positions select _i) select 1, ((_storage_positions select _i) select 2) + _height]];
				_i = _i + 1;
			} forEach attachedObjects (_x);

			if ((_box_s == 0) && (_box_a == 0) && (_box_f == 0)) exitWith {};

		} forEach _storage_areas;

		please_recalculate = true;
	};
";


liberate_sector = compileFinal "
	
	params ['_liberated_sector'];
	
	if (isServer) then {
		_score = 20;
		switch (true) do {
			case (_liberated_sector in sectors_bigtown): { _score = 50; };
			case (_liberated_sector in sectors_capture): { _score = 30; };
			case (_liberated_sector in sectors_military): { _score = 30; };
			case (_liberated_sector in sectors_factory): { _score = 30; };
			case (_liberated_sector in sectors_tower): { _score = 20; };
		};
		
		_headlessClients = entities 'HeadlessClient_F';
		_humanPlayers = allPlayers - _headlessClients;
		
		{
			_uid = getPlayerUID _x;
			[_uid,_score] spawn KPR_fnc_addScore
		} foreach _humanPlayers;
		
	};
";


KP_liberation_supplies_global = 1;
KP_liberation_ammo_global = 1;
KP_liberation_fuel_global = 1;

addMissionEventHandler ['EntityKilled',{
	_unit = _this select 0;
	if (isPlayer _unit) then {
		_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
		if (_hs_unconscious == true) then { _unit spawn lose_resources; };
	}; 
}];

addMissionEventHandler ['HandleDisconnect',{
	_unit = _this select 0;
	_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
	if (_hs_unconscious == true) then { _unit spawn lose_resources; };
}];


hs_spawn = compileFinal "
	_headlessClients = entities 'HeadlessClient_F';
	_humanPlayers = allPlayers - _headlessClients;
	_count_players = count _humanPlayers;
	
	if(_count_players > 0) then {
		
        _spawnChance = 4;
		
        if(_count_players < 5) then {_spawnChance = 9;};
        if(_count_players >= 5 && _count_players < 15) then {_spawnChance = 6;};
        if(_count_players >= 15) then {_spawnChance = 3;};
           
		_hs_randomizer = floor(random _spawnchance);
		
		if( (_hs_randomizer < 2) && ((opfor countSide allGroups) < 140) ) then {
			_player = selectRandom _humanPlayers;
			_too_close = false;
			
			_spawn_position = [ [ [getPos _player, 750] ], ['water'] ] call BIS_fnc_randomPos;

			{
				if (_spawn_position distance _x < 500) then {
					_too_close = true;
				};
			} forEach allPlayers;
			
			_allBases = GRLIB_all_fobs;
			
			{
				if ((getPos _player) distance _x < 500) then {
					_too_close = true;
				};
			} foreach _allBases;
			
			if (_too_close == false) then {
				_group_spawn = createGroup opfor;
				
				'LOP_US_Infantry_TL' createUnit [_spawn_position, _group_spawn, '', 0.2, 'private']; sleep 1;
				'LOP_US_Infantry_MG_3' createUnit [_spawn_position, _group_spawn, '', 0.2, 'private']; sleep 1;
				'LOP_US_Infantry_AT' createUnit [_spawn_position, _group_spawn, '', 0.2, 'private']; sleep 1;
				'LOP_US_Infantry_AA' createUnit [_spawn_position, _group_spawn, '', 0.2, 'private']; sleep 1;

				_wp1_spawn = _group_spawn addWaypoint [getPos _player, 100];
				_wp1_spawn setwaypointtype 'MOVE';
				_wp1_spawn setWaypointBehaviour 'AWARE';
				_wp1_spawn setWaypointSpeed 'FULL';

				_wp2_spawn = _group_spawn addWaypoint [getPos _player, 400];
				_wp3_spawn = _group_spawn addWaypoint [getPos _player, 400];
				_wp4_spawn = _group_spawn addWaypoint [getPos _player, 400];
				_wp4_spawn setWaypointStatements ['true', '{deleteVehicle _x} forEach thisList;'];
			};
		};
	};
";


roadblocks = compileFinal "
	if (count activeRoadblock != 0) then {
		_posRoadblock = activeRoadblock select 0;
		_grpV1 = activeRoadblock select 1;
		_grpV2 = activeRoadblock select 2;
		_grpInf1 = activeRoadblock select 3;
		_grpInf2 = activeRoadblock select 4;
		
		if ({alive _x} count units _grpV1 < 1 && {alive _x} count units _grpV2 < 1 && {alive _x} count units _grpInf1 < 1 && {alive _x} count units _grpInf2 < 1) then {
			activeRoadblock = [];
		};
	};


	if (count activeRoadblock >= 1) exitWith {};

	possibleLocations = [];   
	allMarkers = allMapMarkers;    
	testarray = [];

	{
		_typeOfMarker = markerType _x;
		if(_typeOfMarker != 'loc_Fuelstation' && _typeOfMarker != 'o_support' && _typeOfMarker != 'n_art' && _typeOfMarker != 'n_service' ) then { 
			testarray pushback _x; 
		}; 
	} foreach allMarkers; 

	newMarkers =  allMarkers - testarray; 
	newMarkers = newMarkers - blufor_sectors;

	{   
		_refPos = _x;   
		_referencePos = getMarkerPos _refPos;    

		_closestMarker = [newMarkers, [], { _referencePos distance getMarkerPos _x }, 'ASCEND'] call BIS_fnc_sortBy;   

		_helper1 = createVehicle ['Land_HelipadEmpty_F', _referencePos, [], 0, 'CAN_COLLIDE'];  
		_helper2 = createVehicle ['Land_HelipadEmpty_F', (getMarkerPos (_closestMarker select 0)), [], 0, 'CAN_COLLIDE']; 
		_distance = _helper1 distance _helper2; 

		if ((_closestMarker select 0) in blufor_sectors OR _distance > 1300) then {    
			} else {
			if(_distance > 300) then {
				_distanceHalf = _distance / 2;
				_relativeDirection = _helper1 getRelDir (getMarkerPos (_closestMarker select 0));   
				_center = _helper1 getRelPos [_distanceHalf,_relativeDirection];  

				possibleLocations append [[_center,(_closestMarker select 0)]];   
			};
		};
		
		deleteVehicle _helper1;       
		deleteVehicle _helper2;
		sleep 0.5;   
	} foreach blufor_sectors;

	_randomElement = selectRandom possibleLocations;
	_helper1 = createVehicle ['Land_HelipadEmpty_F', (_randomElement select 0), [], 0, 'CAN_COLLIDE'];
	_helper2 = createVehicle ['Land_HelipadEmpty_F', getMarkerPos (_randomElement select 1), [], 0, 'CAN_COLLIDE'];
	{   
		_x addCuratorEditableObjects [[_helper1], true];
		_x addCuratorEditableObjects [[_helper2], true];
	} foreach allCurators; 

	_nearestRoadCenter = _helper1 nearRoads 300;
	_nearestRoadOpforPoint = _helper2 nearRoads 500;
	_forbiddenRoads = _helper2 nearRoads 100;
	_nearestRoadOpforPoint = _nearestRoadOpforPoint - _forbiddenRoads;


	_intersect = _nearestRoadCenter arrayIntersect _nearestRoadOpforPoint;
	if (count _intersect != 0) then {
		_randomStreetElement = selectRandom _intersect;
		_pos = getPos _randomStreetElement;
		
		_helper3 = createVehicle ['Land_HelipadEmpty_F', _pos, [], 0, 'CAN_COLLIDE'];
		_marker = [blufor_sectors, _pos] call BIS_fnc_nearestPosition; 
		_nearestBluforSectorDistance = _helper3 distance (getMarkerPos _marker);
		
		_nearEntities = _helper3 nearEntities ['Man', 500];
		playerIsNear = 0;
		{
			if(isPlayer _x) then {
				playerIsNear = 1;
			};
		} foreach _nearEntities;
		
		
		if(_nearestBluforSectorDistance > 250) then {
			if(playerIsNear == 0) then {
				
				_roadBlockVehicle1 = selectRandom opfor_vehicles_low_intensity;
				_roadBlockVehicle2 = selectRandom opfor_vehicles_low_intensity;
				if(combat_readiness >= 80) then {
					_roadBlockVehicle1 = selectRandom opfor_vehicles;
					_roadBlockVehicle2 = selectRandom opfor_vehicles;
				} else {
					_roadBlockVehicle1 = selectRandom opfor_vehicles_low_intensity;
					_roadBlockVehicle2 = selectRandom opfor_vehicles_low_intensity;
				};
				
				_connectedRoads = roadsConnectedTo _randomStreetElement;
				_posVehicle1 = getPos (_connectedRoads select 0);
				_info1 = getRoadInfo (_connectedRoads select 0);
				_roadDir1 = (_info1 select 6) getDir (_info1 select 7);
				_dirVehicle1 = _roadDir1 + 210;
				_posVehicle2 = getPos (_connectedRoads select 1);
				_info2 = getRoadInfo (_connectedRoads select 1);
				_roadDir2 = (_info2 select 6) getDir (_info2 select 7);
				_dirVehicle2 = _roadDir2 + 30;

				_vehicle1 = createVehicle [_roadBlockVehicle1, _posVehicle1, [], 0, 'NONE'];
				_vehicle2 = createVehicle [_roadBlockVehicle2, _posVehicle2, [], 0, 'NONE'];

				_vehicle1 setDir _dirVehicle1;
				_vehicle2 setDir _dirVehicle2;
				
				_grpVehicle1 = createGroup east;
				_spawnGunner1 = _grpVehicle1 createUnit [opfor_rifleman, [0,0,0], [], 0, 'NONE'];
				_spawnGunner1 moveInGunner _vehicle1;
				
				_grpVehicle2 = createGroup east;
				_spawnGunner2 = _grpVehicle2 createUnit [opfor_rifleman, [0,0,0], [], 0, 'NONE'];
				_spawnGunner2 moveInGunner _vehicle2;
				
				_rbPos1 = _vehicle1 getRelPos [6,-30];
				_rbPos2 = _vehicle2 getRelPos [6,-30];
				
				_grpInfantry1 = createGroup east;
				_spawnInf1 = _grpInfantry1 createUnit [opfor_rifleman, _rbPos1, [], 0, 'NONE'];
				_spawnInf2 = _grpInfantry1 createUnit [opfor_rpg, _rbPos1, [], 0, 'NONE'];
				_grpInfantry2 = createGroup east;
				_spawnInf3 = _grpInfantry2 createUnit [opfor_rifleman, _rbPos2, [], 0, 'NONE'];
				_spawnInf4 = _grpInfantry2 createUnit [opfor_aa, _rbPos2, [], 0, 'NONE'];
				
				_rbSandbagPos1 = _vehicle1 getRelPos [7.5,-30];
				_rbSandbagPos2 = _vehicle2 getRelPos [7.5,-30];
				_rbSandbagDir1 = _roadDir1;
				_rbSandbagDir2 = _roadDir2;
				
				_sandbag1 = createVehicle ['Land_BagFence_01_long_green_F', _rbSandbagPos1, [], 0, 'CAN_COLLIDE'];
				_sandbag1 setDir _rbSandbagDir1;
				
				_sandbag2 = createVehicle ['Land_BagFence_01_long_green_F', _rbSandbagPos2, [], 0, 'CAN_COLLIDE'];
				_sandbag2 setDir _rbSandbagDir2;
				
				_rbSandbagPos3 = _sandbag1 getRelPos [2.5,-90];
				_rbSandbagPos4 = _sandbag2 getRelPos [2.5,-90];
				
				_sandbag3 = createVehicle ['Land_BagFence_01_long_green_F', _rbSandbagPos3, [], 0, 'CAN_COLLIDE'];
				_sandbag3 setDir _rbSandbagDir1;
				
				_sandbag4 = createVehicle ['Land_BagFence_01_long_green_F', _rbSandbagPos4, [], 0, 'CAN_COLLIDE'];
				_sandbag4 setDir _rbSandbagDir2;
				
				_rbSandbagPos5 = _sandbag1 getRelPos [-2.5,-90];
				_rbSandbagPos6 = _sandbag2 getRelPos [-2.5,-90];
				
				_sandbag5 = createVehicle ['Land_BagFence_01_long_green_F', _rbSandbagPos5, [], 0, 'CAN_COLLIDE'];
				_sandbag5 setDir _rbSandbagDir1;
				
				_sandbag6 = createVehicle ['Land_BagFence_01_long_green_F', _rbSandbagPos6, [], 0, 'CAN_COLLIDE'];
				_sandbag6 setDir _rbSandbagDir2;
							
				{   
					_x addCuratorEditableObjects [[_helper3], true];
					_x addCuratorEditableObjects [[_sandbag1], true];
					_x addCuratorEditableObjects [[_sandbag2], true];
					_x addCuratorEditableObjects [[_sandbag3], true];
					_x addCuratorEditableObjects [[_sandbag4], true];
					_x addCuratorEditableObjects [[_sandbag5], true];
					_x addCuratorEditableObjects [[_sandbag6], true];
				} foreach allCurators; 
				
				activeRoadblock = [(getPos _helper3),_grpVehicle1,_grpVehicle2,_grpInfantry1,_grpInfantry2];
				
			} else {
				systemChat 'player is near!';
				deleteVehicle _helper3;
			};
		} else {
			systemChat 'blufor sector is near!';
			deleteVehicle _helper3; 
		};
	};

	sleep 2;
	deleteVehicle _helper1;       
	deleteVehicle _helper2;
";


ieds = compileFinal "
	_allIED = allMines;
	_allJunk = allMissionObjects 'Land_Garbage_square5_F';

	{
		_playerActive = 0;
		_list = _x nearEntities 2000;
		
		{
			if(side _x == west) then {
				_playerActive = 1;
			}
		} foreach _list;
		
		if(_playerActive == 0) then {
			deleteVehicle _x;
		}
	} foreach _allIED;

	{
		_playerActive = 0;
		_list = _x nearEntities 2000;
		
		{
			if(side _x == west) then {
				_playerActive = 1;
			}
		} foreach _list;
		
		if(_playerActive == 0) then {
			deleteVehicle _x;
		}
	} foreach _allJunk;

	_headlessClients = entities 'HeadlessClient_F';
	_humanPlayers = allPlayers - _headlessClients;
	_humanPlayers call BIS_fnc_arrayShuffle;

	{
		_junkClassname = 'Land_Garbage_square5_F';
		_allJunk = allMissionObjects _junkClassname;
		_countJunk = count _allJunk;
			
		_junkNearPlayer = 0;
		_player = _x;
		{
			if(isTouchingGround _player) then {
				_distance = _x distance _player;
				if(_distance < 2000) then {
				_junkNearPlayer = _junkNearPlayer + 1;
				};
			};
		} foreach _allJunk;
		
		if(_countJunk < 20 && _junkNearPlayer < 4) then {
			for '_i' from 1 to 2 do {
			_nearPlayer = _x nearRoads 2000;
			_count = count _nearPlayer;
			_rand = random _count;
			_rand = round _rand;
			_streetObject = _nearPlayer select _rand;
			_pos = getPos _streetObject;
			
			_checkPlayers = _streetObject nearEntities 500;
			_playerNear = 0;
			{
				if(side _x == west) then {
					_playerNear = 1;
				}
			} foreach _checkPlayers;
			
			if(_playerNear == 0) then {
				_randSpawnPos = _pos getPos [6 * sqrt random 1, random 360];
				
				_spawnJunk = createVehicle [_junkClassname, _randSpawnPos, [], 0, 'CAN_COLLIDE'];
					{
						_x addCuratorEditableObjects [[_spawnJunk], true];
					} foreach allCurators;
				};
			};
		};
	} foreach _humanPlayers;


	_civRep = KP_liberation_civ_rep;
	if (_civRep > -25) exitWith {};

	maxMines = 3;
	{
		_allIED = allMines;
		_countMines = count _allIED;
		_mineClassnames = ['ACE_IEDLandBig_Range','ACE_IEDUrbanBig_Range','ACE_IEDLandSmall_Range','ACE_IEDUrbanSmall_Range'];
		
		_minesNearPlayer = 0;
		_player = _x;
		{
			if(isTouchingGround _player) then {
				_distance = _x distance _player;
				if(_distance < 2000) then {
				_minesNearPlayer = _minesNearPlayer + 1;
				};
			};
		} foreach allMines;

		
		if(_countMines < maxMines && isTouchingGround _x && _minesNearPlayer < 2) then {
			
			_nearestRoad = leader _x nearRoads 2000;
			_closeRoads = leader _x nearRoads 1000;
			_allowedRoads = _nearestRoad - _closeRoads;
				
			_count = count _allowedRoads;
			
			_rand = random _count;
			_rand = round _rand;
			
			_streetObject = _allowedRoads select _rand;
			_pos = getPos _streetObject;
			
			_roadInfo = getRoadInfo _streetObject;
			_roadWidth = _roadInfo select 1;
			
			_checkPlayers = _streetObject nearEntities 500;
			_playerNear = 0;
			{
				if(side _x == west) then {
					_playerNear = 1;
				}
			} foreach _checkPlayers;
			
			if(_playerNear == 0) then {
				_spawnRadius = (_roadWidth / 2) + 1;
				_randSpawnPos = _pos getPos [_spawnRadius * sqrt random 1, random 360];
				_usedMine = selectRandom _mineClassnames;
				_mine = createMine [_usedMine, _randSpawnPos, [], 0];
				
				_randJunk = [1,2] call BIS_fnc_randomInt;
				if(_randJunk == 1) then {
					_spawnJunk = createVehicle ['Land_Garbage_square5_F', _randSpawnPos, [], 0, 'CAN_COLLIDE'];
				};
			};
		};
	} foreach _humanPlayers;

";


activeRoadblock = [];
sleep 15;
//RESTORE RULEBORD TEXTURE ON FOBs
{
	_list = [_x select 0,_x select 1] nearObjects ["Land_MapBoard_F", 15];
	_rulesGer = _list select 0;
	_rulesGer setObjectTextureGlobal [0, "MilSimUnited\rules_ger_1.jpg"];
	_rulesGer enableSimulationGlobal false;
	_rulesEng = _list select 1;
	_rulesEng setObjectTextureGlobal [0, "MilSimUnited\rules_en_1.jpg"];
	_rulesEng enableSimulationGlobal false;		
	_dirLamps = (getDir _rulesGer) - 90;
	_lampPosGer = _rulesGer modelToWorld [0,-0.15,0.95];
	_lampGer = createVehicle ["Land_TentLamp_01_suspended_F", _lampPosGer, [], 0, "CAN_COLLIDE"];
	_lampGer setDir _dirLamps;
	_lampGer allowDamage false;
	_lampPosEng = _rulesEng modelToWorld [0,-0.15,0.95];
	_lampEng = createVehicle ["Land_TentLamp_01_suspended_F", _lampPosEng, [], 0, "CAN_COLLIDE"];
	_lampEng setDir _dirLamps;
	_lampEng allowDamage false;
} foreach GRLIB_all_fobs;


if (isServer) then {
	while {true} do {
		sleep 600;
		[] spawn hs_spawn;
	};
};