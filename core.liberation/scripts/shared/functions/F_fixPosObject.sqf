// Fix object position on floor
// by pSiKO (corrected)

params ["_object", "_pos"];

private _bbr = boundingBoxReal _object;
private _bbr_zMin = (_bbr select 0) select 2;
private _zOffset = (abs _bbr_zMin) + 0.03;

_object setPos [_pos select 0, _pos select 1, (_pos select 2) + _zOffset];
