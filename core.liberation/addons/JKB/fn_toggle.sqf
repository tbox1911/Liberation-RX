disableSerialization;

_array = _this select 0;
_ctrl_id = ctrlIDC (_array select 0);
_ctrl_chkd = (_array select 2 == 1);

if (_ctrl_chkd) then {
    if (_ctrl_id == 233 ) then { JKB_auto_play = true };
    if (_ctrl_id == 234 ) then { JKB_random = true };
} else {
    if (_ctrl_id == 233 ) then { JKB_auto_play = false };
    if (_ctrl_id == 234 ) then { JKB_random = false };    
};
