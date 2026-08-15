params ["_sound", "_source", "_inside", "_source_pos", "_volume", "_pitch", "_distance"];

// fix 2.22 pitch bug
[_sound, _source, _inside, _source_pos, _volume, _pitch, _distance] remoteExec ["remote_call_playsound", 0];
