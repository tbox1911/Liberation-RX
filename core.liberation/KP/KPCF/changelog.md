# Changelog

## [1.2.0] - TBA
### Added
- Squad and Player overview
- CBA settings integration
- Search function for the weapon selection

### Changed
- General code overhaul

### Fixed
- Missing blacklisting for magazines and attachments
- Unuseable storage selection if garbage is around the cf object

### Removed
- KPCF config file

## [1.1.0] - 2018-11-05
### Added
- Alphabetical sorting for item lists
- New categories "weapon attachments" and "backpacks"
- Polish localization
- Export and import function for inventories
- Item pictures on the left of some dialog controls
- Help symbol with version info as tooltip
- Item blacklist
- ACE 3 detection

### Changed
- File header now contains the version
- Near storages can now be searched with the refresh button
- Actions will now be added with an event handler instead of a loop
- Spawn and delete functionalities can now be deactivated
- The base object can now be used without a spawn object

## [1.0.2] - 2018-10-19

### Fixed
- The dialog closes if it's opened with "Enter"
- Inventory list won't refresh in SP

## [1.0.1] - 2018-10-19
### Added
- New variable in the config file to define the distance for the base object search radius
- Tooltip for the progress bar

### Changed
- Comments in the config file for a better understanding
- Some stringtable adjustments
- Moved whole module to the clients, no more server executions

### Fixed
- Hide unused dialog controls
- Syntax changes to the storage capacity check
- Sync problem of the inventory listboxes
- Base objects are no longer detected as valid storage
- Inventory list will now clear if the selected storage will be removed

### Removed
- Old debug testing outputs

[1.0.1]: https://github.com/KillahPotatoes/dubjunks-scripts/pull/11
[1.0.2]: https://github.com/KillahPotatoes/dubjunks-scripts/pull/20
[1.1.0]: https://github.com/KillahPotatoes/dubjunks-scripts/pull/23
[1.2.0]: https://github.com/KillahPotatoes/dubjunks-scripts/pull/ 
