if ( isServer ) then {

	waitUntil { time > 1 };

	params [ "_littlebird" ];
	_littlebird allowdamage false;
	_littlebird setdamage 0;
};