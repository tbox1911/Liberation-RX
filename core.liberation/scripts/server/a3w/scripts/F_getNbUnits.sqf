#define AI_GROUP_SMALL 8
#define AI_GROUP_MEDIUM 12
#define AI_GROUP_LARGE 16

private _ret = AI_GROUP_SMALL;
private _nb_player = count (AllPlayers - (entities "HeadlessClient_F"));

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
if (_nb_player > 2) then { _ret = AI_GROUP_MEDIUM };
if (_nb_player > 5) then { _ret = AI_GROUP_LARGE };
=======
if ( _nb_player > 2) then { _ret = AI_GROUP_MEDIUM };
if ( _nb_player > 5) then { _ret = AI_GROUP_LARGE };
>>>>>>> 5dbad492 (rewrite)
=======
if (_nb_player > 2) then { _ret = AI_GROUP_MEDIUM };
if (_nb_player > 5) then { _ret = AI_GROUP_LARGE };
>>>>>>> 76489ad4 (1)
=======
if (_nb_player > 2) then { _ret = AI_GROUP_MEDIUM };
if (_nb_player > 5) then { _ret = AI_GROUP_LARGE };
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04

//_ret = _ret + floor(random (_ret/2));
_ret;
