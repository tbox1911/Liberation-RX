params ["_unit"];
(_unit == GRLIB_active_commander || (_unit getvariable ["GRLIB_is_Commander", false]));