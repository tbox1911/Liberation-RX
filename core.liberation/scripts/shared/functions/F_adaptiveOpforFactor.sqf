private _bluforcount = 0;
private _ratio = 1.0;

_bluforcount = 0.2 * (count (units GRLIB_side_friendly));
_bluforcount = _bluforcount + (count (AllPlayers - (entities "HeadlessClient_F")));
_ratio = 0.5 + (_bluforcount / 25.0);
if ( _ratio > 1.65 ) then { _ratio = 1.65 };

_ratio;