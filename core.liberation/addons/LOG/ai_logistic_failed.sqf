params ["_driver", "_cmd"];

if (_cmd == "collect") then {
    gamelogic globalChat "Transport cannot reach his destination, your manual intervention is required!";
};

if (_cmd == "unload") then {
    gamelogic globalChat "Transport cannot unload his cargo, your manual intervention is required!";
};

deleteVehicle _driver;
