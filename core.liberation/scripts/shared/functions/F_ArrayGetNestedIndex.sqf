
   // This file is part of Zenophon's ArmA 3 Co-op Mission Framework
   // This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
   // See Legal.txt

   /**
   F_ArrayGetNestedIndex

   Gets the index of the first nested array in (1) that contains (2) at index (3).  Also matches
   nested nested arrays.  Use -1 as an index wildcard, and the function will search every
   value of the nested array.
   Usage : Call
   Params: 1: Array, the array to search for nested arrays in
           2: Any, value to search for
           3: Scalar, the element of the nested array that the value matches
   Return: Scalar, -1 if there is no match
   */

   private ["_givenSearchValue", "_givenSearchArray", "_desiredIndex", "_index", "_nestedArray", "_currentIndex"];

   _givenSearchArray = _this select 0;
   _givenSearchValue = _this select 1;
   _desiredIndex = _this select 2;

   scopeName "main";
   _index = -1;

   {
       _currentIndex = _forEachIndex;
       if (_desiredIndex != -1) then {
           if ((_x select _desiredIndex) isEqualTo _givenSearchValue) exitWith {
               _index = _currentIndex;
           };
       } else {
           _nestedArray = _x;
           {
               if (_x isEqualTo _givenSearchValue) then {
                   _index = _currentIndex;
                   breakTo "main";
               };
           } forEach _nestedArray;
       };
   } forEach _givenSearchArray;

   (_index)
