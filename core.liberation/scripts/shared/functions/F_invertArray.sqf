/*
   File:            fn_invertArray.sqf
   Author:            Heeeere's Johnny!    <<< Please do not edit or remove this line. Thanks. >>>
   Description:    Inverts an array from e.g.
                   [[string, Number, Boolean], [string, Number, Boolean], [string, Number, Boolean], ...]]
                   to
                   [[string, String, String, ...], [Number, Number, Number, ...], [boolean, Boolean, Boolean, ...]]
   Parameters:
       0 ARRAY        thisArray        array to invert
       1 INTEGER    xLength            (optional) number of elements of each subarray in thisArray
       2 ANYTHING    defaultValue    (optional) value to be inserted for nil fields    //TODO defaultValue array for multiple nil fields in subarray
   Return:
       ARRAY        invertedArray    the inverted array
*/

_thisArray = _this select 0;
if(count _thisArray isEqualTo 0) exitWith {diag_log "fnc_invertArray: given array has no elements.";};
_xLength = ([_this, 1, 0, [0]] call BIS_fnc_param) - 1;
_defaultValue = [_this, 2, false] call BIS_fnc_param;

_invertedArray = [];

if(_xLength isEqualTo 0) exitWith {}; //nothing to invert here

if(_xLength isEqualTo -1) then
{
   {
       _xLengthNew = count _x;
       if(_xLengthNew > _xLength) then {_xLength = _xLengthNew;};
   } count _thisArray;
};

for "_i" from 0 to _xLength do
{
   _invertedArray pushBack [];
};

{
   for "_i" from 0 to _xLength do
   {
       _tmpArray = _invertedArray select _i;
       _tmpArray pushBack ([_x, _i, _defaultValue] call BIS_fnc_param);
       _invertedArray set [_i, _tmpArray];
   };
} count _thisArray;

_invertedArray