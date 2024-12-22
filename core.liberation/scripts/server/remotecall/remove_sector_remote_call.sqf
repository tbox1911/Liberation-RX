if (!isServer && hasInterface) exitWith {};
params ["_sector"];

if (isNil "_sector") exitWith {};
if (_sector == "") exitWith {};

sectors_allSectors = sectors_allSectors - [_sector];
publicVariable "sectors_allSectors";
blufor_sectors = blufor_sectors - [_sector];
publicVariable "blufor_sectors";
sectors_military = sectors_military - [_sector];
publicVariable "sectors_military";
deleteMarker _sector;
