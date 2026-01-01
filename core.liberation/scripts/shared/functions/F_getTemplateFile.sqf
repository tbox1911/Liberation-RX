params ["_path", ["_args", objNull], ["_message", true]];
if (isNil "_path") exitWith {};

private _ret = true;
private _template_name = _path splitString "\" select 1;
private _file_name = _path splitString "\" select 2;

if (_template_name in LRX_mod_list) then {
	_ret = [_path, _args] call LRX_Template_fnc_readfile;
} else {
	if (fileExists _path) then {
		[_args] call compileFinal preprocessFile _path;
	} else {
		_ret = false;
	};
};

if (!_ret && _message) then {
	private _msg = format ["--- LRX Error: File %1 not found.", _path];
	diag_log _msg;
	systemchat _msg;
	abort_loading_msg = format [
		"********************************\n
		FATAL! - Critical File not Found !!\n\n
		Template: %1\n
		File: %2\n\n
		Loading Aborted to protect data integrity.\n
		Correct or Change template selection.\n
		*********************************", _template_name, _file_name];	
	};
_ret;
