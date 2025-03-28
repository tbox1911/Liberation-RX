/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/*
	LRX revision v0.2 - pSiKO - 2025
	full client side
	- fix ACE / hide static AA
	- cleanup / refacto
	- rewrite actions and check
*/

AR_SUPPORTED_VEHICLES = [
	"Helicopter",
	"VTOL_Base_F"
];

AP_RAPPEL_POINTS = [];

AR_RAPPEL_POINT_CLASS_HEIGHT_OFFSET = [
	["All", [-0.05, -0.05, -0.05, -0.05, -0.05, -0.05]]
];

AR_Rappel_All_Cargo = {
	params ["_vehicle",["_rappelHeight",25],["_positionASL",[]]];
	if (isPlayer (driver _vehicle)) exitWith {};
	_this spawn {
		params ["_vehicle",["_rappelHeight",25],["_positionASL",[]]];

		private _heliGroup = group driver _vehicle;
		_vehicle setVariable ["AR_Units_Rappelling",true];

		_heliGroupOriginalBehaviour = behaviour leader _heliGroup;
		_heliGroupOriginalCombatMode = combatMode leader _heliGroup;
		_heliGroupOriginalFormation = formation _heliGroup;

		if (count _positionASL == 0) then {
			_positionASL = AGLtoASL [(getPos _vehicle) select 0, (getPos _vehicle) select 1, 0];
		};
		_positionASL = _positionASL vectorAdd [0, 0, _rappelHeight];

		_gameLogicLeader = _heliGroup createUnit ["LOGIC", ASLToAGL _positionASL, [], 0, ""];
		_heliGroup selectLeader _gameLogicLeader;

		_heliGroup setBehaviourStrong "CARELESS";
		_heliGroup setCombatMode "Blue";
		_heliGroup setFormation "File";

		// Wait for heli to slow down
		waitUntil { sleep 1; (vectorMagnitude (velocity _vehicle)) < 10 && _vehicle distance2d _gameLogicLeader < 50 };

		// Force heli to specific position
		[_vehicle, _positionASL] spawn {
			params ["_vehicle","_positionASL"];

			while { _vehicle getVariable ["AR_Units_Rappelling",false] && alive driver _vehicle} do {
				private _velocityMagatude = 5;
				private _distanceToPosition = ((getPosASL _vehicle) distance _positionASL);
				if ( _distanceToPosition <= 10 ) then {
					_velocityMagatude = (_distanceToPosition / 10) * _velocityMagatude;
				};

				_currentVelocity = velocity _vehicle;
				_currentVelocity = _currentVelocity vectorAdd (( (getPosASL _vehicle) vectorFromTo _positionASL ) vectorMultiply _velocityMagatude);
				_currentVelocity = (vectorNormalized _currentVelocity) vectorMultiply ( (vectorMagnitude _currentVelocity) min _velocityMagatude );
				_vehicle setVelocity _currentVelocity;

				sleep 0.05;
			};
		};

		// Find all units that will be rappelling
		private _rappelUnits = [];
		private _rappelledGroups = [];
		{
			if ( group _x != _heliGroup && alive _x ) then {
				_rappelUnits pushBack _x;
				_rappelledGroups = _rappelledGroups + [group _x];
			};
		} forEach crew _vehicle;

		// Rappel all units
		private _unitsOutsideVehicle = [];
		while { count _unitsOutsideVehicle != count _rappelUnits } do {
			_distanceToPosition = ((getPosASL _vehicle) distance _positionASL);
			if (_distanceToPosition < 3) then {
				{
					[_x, _vehicle] call AR_Rappel_From_Heli;
					sleep 1;
				} forEach (_rappelUnits-_unitsOutsideVehicle);
				{
					if !(_x in _vehicle) then {
						_unitsOutsideVehicle pushBack _x;
					};
				} forEach (_rappelUnits-_unitsOutsideVehicle);
			};
			sleep 2;
		};

		// Wait for all units to reach ground
		private _unitsRappelling = true;
		while { _unitsRappelling } do {
			_unitsRappelling = false;
			{
				if ( _x getVariable ["AR_Is_Rappelling",false] ) then {
					_unitsRappelling = true;
				};
			} forEach _rappelUnits;
			sleep 3;
		};

		deleteVehicle _gameLogicLeader;

		_heliGroup setBehaviourStrong _heliGroupOriginalBehaviour;
		_heliGroup setCombatMode _heliGroupOriginalCombatMode;
		_heliGroup setFormation _heliGroupOriginalFormation;

		_vehicle setVariable ["AR_Units_Rappelling",nil];
	};
};

AR_Get_Heli_Rappel_Points = {
	params ["_vehicle"];

	// Check for pre-defined rappel points

	private ["_preDefinedRappelPoints","_className","_rappelPoints","_preDefinedRappelPointsConverted"];
	_preDefinedRappelPoints = [];
	{
		_className = _x select 0;
		_rappelPoints = _x select 1;
		if ( _vehicle isKindOf _className ) then {
			_preDefinedRappelPoints = _rappelPoints;
		};
	} forEach AP_RAPPEL_POINTS;
	if (count _preDefinedRappelPoints > 0) exitWith {
		_preDefinedRappelPointsConverted = [];
		{
			if (typeName _x == "STRING") then {
				_modelPosition = _vehicle selectionPosition _x;
				if ( [0,0,0] distance _modelPosition > 0 ) then {
					_preDefinedRappelPointsConverted pushBack _modelPosition;
				};
			} else {
				_preDefinedRappelPointsConverted pushBack _x;
			};
		} forEach _preDefinedRappelPoints;
		_preDefinedRappelPointsConverted;
	};

	// Calculate dynamic rappel points

	private ["_rappelPointsArray","_cornerPoints","_frontLeftPoint","_frontRightPoint","_rearLeftPoint","_rearRightPoint","_rearLeftPointFinal"];
	private ["_rearRightPointFinal","_frontLeftPointFinal","_frontRightPointFinal","_middleLeftPointFinal","_middleRightPointFinal","_vehicleUnitVectorUp"];
	private ["_rappelPoints","_modelPoint","_modelPointASL","_surfaceIntersectStartASL","_surfaceIntersectEndASL","_surfaces","_intersectionASL","_intersectionObject"];
	private ["_la","_lb","_n","_p0","_l","_d","_validRappelPoints"];

	_rappelPointsArray = [];
	_cornerPoints = [_vehicle] call AR_Get_Corner_Points;

	_frontLeftPoint = (((_cornerPoints select 2) vectorDiff (_cornerPoints select 3)) vectorMultiply 0.2) vectorAdd (_cornerPoints select 3);
	_frontRightPoint = (((_cornerPoints select 2) vectorDiff (_cornerPoints select 3)) vectorMultiply 0.8) vectorAdd (_cornerPoints select 3);
	_rearLeftPoint = (((_cornerPoints select 0) vectorDiff (_cornerPoints select 1)) vectorMultiply 0.2) vectorAdd (_cornerPoints select 1);
	_rearRightPoint = (((_cornerPoints select 0) vectorDiff (_cornerPoints select 1)) vectorMultiply 0.8) vectorAdd (_cornerPoints select 1);

	_rearLeftPointFinal = ((_frontLeftPoint vectorDiff _rearLeftPoint) vectorMultiply 0.2) vectorAdd _rearLeftPoint;
	_rearRightPointFinal = ((_frontRightPoint vectorDiff _rearRightPoint) vectorMultiply 0.2) vectorAdd _rearRightPoint;
	_frontLeftPointFinal = ((_rearLeftPoint vectorDiff _frontLeftPoint) vectorMultiply 0.2) vectorAdd _frontLeftPoint;
	_frontRightPointFinal = ((_rearRightPoint vectorDiff _frontRightPoint) vectorMultiply 0.2) vectorAdd _frontRightPoint;
	_middleLeftPointFinal = ((_frontLeftPointFinal vectorDiff _rearLeftPointFinal) vectorMultiply 0.5) vectorAdd _rearLeftPointFinal;
	_middleRightPointFinal = ((_frontRightPointFinal vectorDiff _rearRightPointFinal) vectorMultiply 0.5) vectorAdd _rearRightPointFinal;

	_vehicleUnitVectorUp = vectorNormalized (vectorUp _vehicle);

	_rappelPointHeightOffset = 0;
	{
		if (_vehicle isKindOf (_x select 0)) then {
			_rappelPointHeightOffset = (_x select 1);
		};
	} forEach AR_RAPPEL_POINT_CLASS_HEIGHT_OFFSET;

	_rappelPoints = [];
	{
		_modelPoint = _x;
		_modelPointASL = AGLToASL (_vehicle modelToWorldVisual _modelPoint);
		_surfaceIntersectStartASL = _modelPointASL vectorAdd ( _vehicleUnitVectorUp vectorMultiply -5 );
		_surfaceIntersectEndASL = _modelPointASL vectorAdd ( _vehicleUnitVectorUp vectorMultiply 5 );

		// Determine if the surface intersection line crosses below ground level
		// If if does, move surfaceIntersectStartASL above ground level (lineIntersectsSurfaces
		// doesn't work if starting below ground level for some reason
		// See: https://en.wikipedia.org/wiki/Line%E2%80%93plane_intersection

		_la = ASLToAGL _surfaceIntersectStartASL;
		_lb = ASLToAGL _surfaceIntersectEndASL;

		if (_la select 2 < 0 && _lb select 2 > 0) then {
			_n = [0,0,1];
			_p0 = [0,0,0.1];
			_l = (_la vectorFromTo _lb);
			if ((_l vectorDotProduct _n) != 0) then {
				_d = ( ( _p0 vectorAdd ( _la vectorMultiply -1 ) ) vectorDotProduct _n ) / (_l vectorDotProduct _n);
				_surfaceIntersectStartASL = AGLToASL ((_l vectorMultiply _d) vectorAdd _la);
			};
		};

		_surfaces = lineIntersectsSurfaces [_surfaceIntersectStartASL, _surfaceIntersectEndASL, objNull, objNull, true, 100];
		_intersectionASL = [];
		{
			_intersectionObject = _x select 2;
			if (_intersectionObject == _vehicle) exitWith {
				_intersectionASL = _x select 0;
			};
		} forEach _surfaces;
		if (count _intersectionASL > 0) then {
			_intersectionASL = _intersectionASL vectorAdd (( _surfaceIntersectStartASL vectorFromTo _surfaceIntersectEndASL ) vectorMultiply (_rappelPointHeightOffset select (count _rappelPoints)));
			_rappelPoints pushBack (_vehicle worldToModelVisual (ASLToAGL _intersectionASL));
		} else {
			_rappelPoints pushBack [];
		};
	} forEach [_middleLeftPointFinal, _middleRightPointFinal, _frontLeftPointFinal, _frontRightPointFinal, _rearLeftPointFinal, _rearRightPointFinal];

	_validRappelPoints = [];
	{
		if (count _x > 0) then {
			_validRappelPoints pushBack _x;
		};
	} forEach _rappelPoints;

	_validRappelPoints;
};

AR_Rappel_AI_From_Heli = {
	params ["_player","_heli"];
	{
		if (!isNull objectParent _x && assignedVehicleRole _x select 0 == "cargo") then {
			sleep 1;
			[_x, vehicle _x] call AR_Rappel_From_Heli;
		};
	} forEach (units player - [player]);
};

AR_Rappel_From_Heli = {
	params ["_player","_heli"];
	if !(_player in _heli) exitWith {};
	if (_player getVariable ["AR_Is_Rappelling", false]) exitWith {};

	// Find next available rappel anchor
	private _rappelPoints = [_heli] call AR_Get_Heli_Rappel_Points;
	_rappelPointIndex = 0;
	{
		_rappellingPlayer = _heli getVariable ["AR_Rappelling_Player_" + str _rappelPointIndex,objNull];
		if (isNull _rappellingPlayer) exitWith {};
		_rappelPointIndex = _rappelPointIndex + 1;
	} forEach _rappelPoints;

	// All rappel anchors are taken by other players. Hint player to try again.
	if (count _rappelPoints == _rappelPointIndex) exitWith {
		hintSilent localize "STR_RPL_ANCHORS_IN_USE";
	};

	_heli setVariable ["AR_Rappelling_Player_" + str _rappelPointIndex,_player];

	_player setVariable ["AR_Is_Rappelling",true,true];

	// Start rappelling (client side)
	[_player,_heli,_rappelPoints select _rappelPointIndex] spawn AR_Client_Rappel_From_Heli;

	// Wait for player to finish rappeling before freeing up anchor
	[_player, _heli, _rappelPointIndex] spawn {
		params ["_player","_heli", "_rappelPointIndex"];
		while {true} do {
			if (!alive _player) exitWith {};
			if !(_player getVariable ["AR_Is_Rappelling", false]) exitWith {};
			sleep 2;
		};
		_heli setVariable ["AR_Rappelling_Player_" + str _rappelPointIndex, nil];
	};
};

AR_Client_Rappel_From_Heli = {
	params ["_player","_heli","_rappelPoint"];

	[_player] orderGetIn false;
	moveOut _player;
	waitUntil { isNull objectParent vehicle _player };
	_playerStartPosition = AGLtoASL (_heli modelToWorldVisual _rappelPoint);
	_playerStartPosition set [2,(_playerStartPosition select 2) - 1];
	_playerStartPosition set [1,(_playerStartPosition select 1) - ((((random 100)-50))/25)];
	_playerStartPosition set [0,(_playerStartPosition select 0) - ((((random 100)-50))/25)];
	_player setPosWorld _playerStartPosition;

	private _anchor = "Land_Can_V2_F" createVehicle position _player;
	_anchor allowDamage false;
	[_anchor, true] remoteExec ["hideObjectGlobal", 2];
	_anchor attachTo [_heli,_rappelPoint];

	private _rappelDevice = "B_static_AA_F" createVehicle position _player;
	_rappelDevice setPosWorld _playerStartPosition;
	_rappelDevice allowDamage false;
	[_rappelDevice, true] remoteExec ["hideObjectGlobal", 2];

	private _bottomRopeLength = 60;
	private _bottomRope = ropeCreate [_rappelDevice, [-0.15,0,0], _bottomRopeLength];
	private _topRopeLength = 3;
	private _topRope = ropeCreate [_rappelDevice, [0,0.15,0], _anchor, [0, 0, 0], _topRopeLength];
	_bottomRope allowDamage false;
	_topRope allowDamage false;

	[_player] spawn AR_Enable_Rappelling_Animation_Client;

	private _gravityAccelerationVec = [0,0,-9.8];
	private _velocityVec = [0,0,0];
	private _lastTime = diag_tickTime;
	private _lastPosition = AGLtoASL (_rappelDevice modelToWorldVisual [0,0,0]);
	private _lookDirFreedom = 50;
	private _dir = (random 360) + (_lookDirFreedom / 2);
	private _dirSpinFactor = (((random 10) - 5) / 5) max 0.1;

	private _ropeKeyDownHandler = -1;
	private _ropeKeyUpHandler = -1;
	if (_player == player) then {
		_player setVariable ["AR_DECEND_PRESSED",false];
		_player setVariable ["AR_FAST_DECEND_PRESSED",false];
		_player setVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT",0];

		_ropeKeyDownHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", {
			if (_this select 1 in (actionKeys "MoveBack")) then {
				player setVariable ["AR_DECEND_PRESSED",true];
			};
			if (_this select 1 in (actionKeys "Turbo")) then {
				player setVariable ["AR_FAST_DECEND_PRESSED",true];
			};
		}];

		_ropeKeyUpHandler = (findDisplay 46) displayAddEventHandler ["KeyUp", {
			if (_this select 1 in (actionKeys "MoveBack")) then {
				player setVariable ["AR_DECEND_PRESSED",false];
			};
			if (_this select 1 in (actionKeys "Turbo")) then {
				player setVariable ["AR_FAST_DECEND_PRESSED",false];
			};
		}];

	} else {
		_player setVariable ["AR_DECEND_PRESSED",false];
		_player setVariable ["AR_FAST_DECEND_PRESSED",false];
		_player setVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT",(random 2) - 1];

		[_player] spawn {
			params ["_player"];
			sleep 2;
			_player setVariable ["AR_DECEND_PRESSED",true];
		};

	};

	// Cause player to fall from rope if heli is moving too fast
	_this spawn {
		params ["_player","_heli"];
		while {_player getVariable ["AR_Is_Rappelling", false]} do {
			if (speed vehicle _heli > 150) then {
				if (isPlayer _player) then {
					hintSilent localize "STR_RPL_TOO_FAST_LOST_GRIP";
				};
				[_player] call AR_Rappel_Detach_Action;
			};
			sleep 2;
		};
	};

	while {true} do {
		_currentTime = diag_tickTime;
		_timeSinceLastUpdate = _currentTime - _lastTime;
		_lastTime = _currentTime;
		if (_timeSinceLastUpdate > 1) then {
			_timeSinceLastUpdate = 0;
		};

		_environmentWindVelocity = wind;
		_playerWindVelocity = _velocityVec vectorMultiply -1;
		_helicopterWindVelocity = (vectorUp _heli) vectorMultiply -30;
		_totalWindVelocity = _environmentWindVelocity vectorAdd _playerWindVelocity vectorAdd _helicopterWindVelocity;
		_totalWindForce = _totalWindVelocity vectorMultiply (9.8/53);

		_accelerationVec = _gravityAccelerationVec vectorAdd _totalWindForce;
		_velocityVec = _velocityVec vectorAdd ( _accelerationVec vectorMultiply _timeSinceLastUpdate );
		_newPosition = _lastPosition vectorAdd ( _velocityVec vectorMultiply _timeSinceLastUpdate );

		_heliPos = AGLtoASL (_heli modelToWorldVisual _rappelPoint);

		if (_newPosition distance _heliPos > _topRopeLength) then {
			_newPosition = (_heliPos) vectorAdd (( vectorNormalized ( (_heliPos) vectorFromTo _newPosition )) vectorMultiply _topRopeLength);
			_surfaceVector = ( vectorNormalized ( _newPosition vectorFromTo (_heliPos) ));
			_velocityVec = _velocityVec vectorAdd (( _surfaceVector vectorMultiply (_velocityVec vectorDotProduct _surfaceVector)) vectorMultiply -1);
		};

		_rappelDevice setPosWorld (_lastPosition vectorAdd ((_newPosition vectorDiff _lastPosition) vectorMultiply 6));

		_rappelDevice setVectorDir (vectorDir _player);
		_player setPosWorld [_newPosition select 0, _newPosition select 1, (_newPosition select 2)-0.6];
		_player setVelocity [0,0,0];

		// Handle rappelling down rope
		if (_player getVariable ["AR_DECEND_PRESSED",false]) then {
			_decendSpeedMetersPerSecond = 3.5;
			if (_player getVariable ["AR_FAST_DECEND_PRESSED",false]) then {
				_decendSpeedMetersPerSecond = 5;
			};
			_decendSpeedMetersPerSecond = _decendSpeedMetersPerSecond + (_player getVariable ["AR_RANDOM_DECEND_SPEED_ADJUSTMENT",0]);
			_bottomRopeLength = _bottomRopeLength - (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
			_topRopeLength = _topRopeLength + (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
			ropeUnwind [_topRope, _decendSpeedMetersPerSecond, _topRopeLength - 0.5];
			ropeUnwind [_bottomRope, _decendSpeedMetersPerSecond, _bottomRopeLength];
		};

		// Fix player direction
		_dir = _dir + ((360/1000) * _dirSpinFactor);
		if (isPlayer _player) then {
			_currentDir = getDir _player;
			_minDir = (_dir - (_lookDirFreedom/2)) mod 360;
			_maxDir = (_dir + (_lookDirFreedom/2)) mod 360;
			_minDegreesToMax = 0;
			_minDegreesToMin = 0;
			if ( _currentDir > _maxDir ) then {
				_minDegreesToMax = (_currentDir - _maxDir) min (360 - _currentDir + _maxDir);
			};
			if ( _currentDir < _maxDir ) then {
				_minDegreesToMax = (_maxDir - _currentDir) min (360 - _maxDir + _currentDir);
			};
			if ( _currentDir > _minDir ) then {
				_minDegreesToMin = (_currentDir - _minDir) min (360 - _currentDir + _minDir);
			};
			if ( _currentDir < _minDir ) then {
				_minDegreesToMin = (_minDir - _currentDir) min (360 - _minDir + _currentDir);
			};
			if ( _minDegreesToMin > _lookDirFreedom || _minDegreesToMax > _lookDirFreedom ) then {
				if ( _minDegreesToMin < _minDegreesToMax ) then {
					_player setDir _minDir;
				} else {
					_player setDir _maxDir;
				};
			} else {
				_player setDir (_currentDir + ((360/1000) * _dirSpinFactor));
			};
		} else {
			_player setDir _dir;
		};

		_lastPosition = _newPosition;

		if ((getPos _player) select 2 < 1 || !alive _player || vehicle _player != _player || _bottomRopeLength <= 1 || _player getVariable ["AR_Detach_Rope",false] ) exitWith {};

		sleep 0.01;
	};

	if (_bottomRopeLength > 1 && alive _player && vehicle _player == _player) then {

		_playerStartASLIntersect = getPosASL _player;
		_playerEndASLIntersect = [_playerStartASLIntersect select 0, _playerStartASLIntersect select 1, (_playerStartASLIntersect select 2) - 5];
		_surfaces = lineIntersectsSurfaces [_playerStartASLIntersect, _playerEndASLIntersect, _player, objNull, true, 10];
		_intersectionASL = [];
		{
			scopeName "surfaceLoop";
			_intersectionObject = _x select 2;
			_objectFileName = str _intersectionObject;
			if ((_objectFileName find " t_") == -1 && (_objectFileName find " b_") == -1) then {
				_intersectionASL = _x select 0;
				breakOut "surfaceLoop";
			};
		} forEach _surfaces;

		if (count _intersectionASL != 0) then {
			_player allowDamage false;
			_player setPosASL _intersectionASL;
		};

		if (_player getVariable ["AR_Detach_Rope",false]) then {
			// Player detached from rope. Don't prevent damage
			// if we didn't find a position on the ground
			if (count _intersectionASL == 0) then {
				_player allowDamage true;
			};
		};

		// Allow damage if you get out of a heli with no engine on
		if (!isEngineOn _heli) then {
			_player allowDamage true;
		};

	};

	ropeDestroy _topRope;
	ropeDestroy _bottomRope;
	deleteVehicle _anchor;
	deleteVehicle _rappelDevice;

	_player setVariable ["AR_Is_Rappelling",nil,true];
	_player setVariable ["AR_Rappelling_Vehicle", nil, true];
	_player setVariable ["AR_Detach_Rope",nil,true];

	if (_ropeKeyDownHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", _ropeKeyDownHandler];
	};

	if (_ropeKeyUpHandler != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyUp", _ropeKeyUpHandler];
	};

	sleep 2;

	_player allowDamage true;
};

AR_Current_Weapon_Type_Selected = {
	params ["_player"];
	if (currentWeapon _player == handgunWeapon _player) exitWith {"HANDGUN"};
	if (currentWeapon _player == primaryWeapon _player) exitWith {"PRIMARY"};
	if (currentWeapon _player == secondaryWeapon _player) exitWith {"SECONDARY"};
	"OTHER";
};

AR_Enable_Rappelling_Animation_Client = {
	params ["_player"];

	if (_player != player) then {
		_player enableSimulation false;
	};

	private _animationEventHandler = _player addEventHandler ["AnimChanged", {
		params ["_player","_animation"];
		_player switchMove "HubSittingChairC_idle1";
		_player playMoveNow "HubSittingChairC_idle1";
	}];
	[_player, "HubSittingChairC_idle1"] remoteExec ["switchMove", 0];
	[_player, "HubSittingChairC_idle1"] remoteExec ["playMoveNow", 0];

	waitUntil { sleep 1; !(_player getVariable ["AR_Is_Rappelling",false])};

	if (_animationEventHandler != -1) then {
		_player removeEventHandler ["AnimChanged", _animationEventHandler];
	};

	_player switchMove "";
	_player enableSimulation true;
};

AR_Rappel_Detach_Action = {
	params ["_player"];
	_player setVariable ["AR_Detach_Rope",true,true];
};

AR_Rappel_Detach_Action_Check = {
	params ["_player"];
	(_player getVariable ["AR_Is_Rappelling",false]);
};

AR_Rappel_From_Heli_Action_Check = {
	params ["_player","_vehicle", "_isplayer"];
	if (lifeState _player == 'INCAPACITATED') exitWith {false};
	if !([_vehicle] call AR_Is_Supported_Vehicle) exitWith {false};
	if (((getPos _vehicle) select 2) < 10 ) exitWith {false};
	if (((getPos _vehicle) select 2) > 80 ) exitWith {false};
	if (speed vehicle _vehicle > 60) exitWith {false};
	if (_isplayer && driver _vehicle == _player && isEngineOn _vehicle) exitWith {false};
	true;
};

AR_Rappel_AI_Units_From_Heli_Action_Check = {
	params ["_player","_vehicle"];
	if !([_player, _vehicle, false] call AR_Rappel_From_Heli_Action_Check) exitWith {false};
	if (leader group _player != _player) exitWith {false};
	if (count units _player <= 1) exitWith {false};
	private _canRappelOne = false;
	{
		if (!isNull objectParent _x && assignedVehicleRole _x select 0 == "cargo") exitWith {_canRappelOne = true};
	} forEach (units player - [player]);
	_canRappelOne;
};

AR_Get_Corner_Points = {
	params ["_vehicle"];
	private ["_centerOfMass","_bbr","_p1","_p2","_rearCorner","_rearCorner2","_frontCorner","_frontCorner2"];
	private ["_maxWidth","_widthOffset","_maxLength","_lengthOffset","_widthFactor","_lengthFactor","_maxHeight","_heightOffset"];

	// Correct width and length factor for air
	_widthFactor = 0.5;
	_lengthFactor = 0.5;
	if (_vehicle isKindOf "Air") then {
		_widthFactor = 0.3;
	};
	if (_vehicle isKindOf "Helicopter") then {
		_widthFactor = 0.2;
		_lengthFactor = 0.45;
	};

	_centerOfMass = getCenterOfMass _vehicle;
	_bbr = boundingBoxReal _vehicle;
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	_widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass select 0 )) * _widthFactor;
	_maxLength = abs ((_p2 select 1) - (_p1 select 1));
	_lengthOffset = ((_maxLength / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	_heightOffset = _maxHeight/6;

	_rearCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
	_rearCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
	_frontCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
	_frontCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];

	[_rearCorner,_rearCorner2,_frontCorner,_frontCorner2];
};

AR_Is_Supported_Vehicle = {
	params ["_vehicle","_isSupported"];
	_isSupported = false;
	if (not isNull _vehicle) then {
		{
			_isServer = (_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "server");
			if (_vehicle isKindOf _x && !(_isServer)) then {
				_isSupported = true;
			};
		} forEach AR_SUPPORTED_VEHICLES;
	};
	_isSupported;
};

AR_Add_Player_Actions = {
	params ["_player"];

	_player addAction ["Rappel Self", {
		[player, vehicle player] call AR_Rappel_From_Heli;
	}, nil, 0, false, true, "", "[player, vehicle player, true] call AR_Rappel_From_Heli_Action_Check"];

	_player addAction ["Rappel AI Units", {
		[player, vehicle player] call AR_Rappel_AI_From_Heli;
	}, nil, 0, false, true, "", "[player, vehicle player] call AR_Rappel_AI_Units_From_Heli_Action_Check"];

	_player addAction ["Detach Rappel Device", {
		[player] call AR_Rappel_Detach_Action;
	}, nil, 0, false, true, "", "[player] call AR_Rappel_Detach_Action_Check"];

};

diag_log "--- LRX Advanced Rappelling Initialized";
