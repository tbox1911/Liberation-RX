// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: getMissionState.sqf
//	@file Author: pSiKO

if (!isServer) exitWith {};

private ["_mArray", "_mType", "_mState"];

_mArray = param [0, [], [[]]];
_mType = param [1, "", [""]];

{
	if (_x select 0 == _mType) exitWith	{ _mState = _x select 2 };
} forEach _mArray;

_mState
