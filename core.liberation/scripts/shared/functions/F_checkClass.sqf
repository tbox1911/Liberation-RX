params [ "_classtotest" ];
private _ret = isClass ( configFile / 'cfgVehicles' / _classtotest );
if (!_ret) then { diag_log format ["--- LRX Error: Check classe for %1 failed!", _classtotest]};
_ret;