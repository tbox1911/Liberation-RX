params ["_unit"];

private _color = "#808080";
private _text = "Neutral";
private _reputation = [player] call F_getReput;
if ( _reputation <= -25 ) then { _color = "#808000"; _text = "Unfriendly" };
if ( _reputation <= -50 ) then { _color = "#806000"; _text = "Bad" };
if ( _reputation <= -75 ) then { _color = "#804000"; _text = "Very Bad" };
if ( _reputation <= -100 ) then { _color = "#800000"; _text = "Terrible" };
if ( _reputation >= 25 ) then { _color = "#004000"; _text = "Friendly" };
if ( _reputation >= 50 ) then { _color = "#006000"; _text = "Good" };
if ( _reputation >= 75 ) then { _color = "#008000"; _text = "Very Good" };
if ( _reputation >= 100 ) then { _color = "#008060"; _text = "Great" };

[_color, _text];