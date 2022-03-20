/*
    Killah Potatoes Cratefiller v1.2.0 function library

    File: functions.hpp
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-05-09
    Last Update: 2020-10-20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Fetches all functions from this modules.
*/

class cratefiller {
    file = "KP\KPCF\fnc";

    // Module post initialization
    class cratefiller_postInit {
        postInit = 1;
    };

    // Module pre initialization
    class cratefiller_preInit {
        preInit = 1;
    };

    // Adds one of the selected item to the inventory
    class cratefiller_addEquipment {};

    // Changes the shown equipment category
    class cratefiller_createEquipmentList {};

    // Creates a list with valueable magazines or attachments
    class cratefiller_createSubList {};

    // Deletes the nearest crate
    class cratefiller_deleteCrate {};

    // Deletes the selected preset
    class cratefiller_deletePreset {};

    // Exports the active inventory
    class cratefiller_export {};

    // Gets the config path for the given classname
    class cratefiller_getConfigPath {};

    // Gets all player groups and adds them to the listbox
    class cratefiller_getGroups {};

    // Gets all inventory items of the active crate
    class cratefiller_getInventory {};

    // Scans the spawn area for possible storages
    class cratefiller_getNearStorages {};

	// Gets all weapons of the selected player
	class cratefiller_getPlayerInventory {};

    // Gets all players from the selected group and adds them to the listbox
    class cratefiller_getPlayers {};

    // Returns the active storage
    class cratefiller_getStorage {};

    // Imports the selected preset
    class cratefiller_import {};

    // Manages the actions
    class cratefiller_manageActions {};

    // Manages the ACE actions
    class cratefiller_manageAceActions {};

    // Open the dialog
    class cratefiller_openDialog {};

    // Creates the item presets
    class cratefiller_presets {};

    // Removes the given amount of the selected item in the crate.
    class cratefiller_removeEquipment {};

	// Search for a weapon with the name entered in the search bar
	class cratefiller_search {};

    // Adds the items to the active crate
    class cratefiller_setInventory {};

    // CBA settings
    class cratefiller_settings {};

    // Displays the items of the active crate
    class cratefiller_showInventory {};

    // Shows or hides the cratefiller overview display
    class cratefiller_showOverview {};

    // Reads all saved presets and lists them.
    class cratefiller_showPresets {};

    // Sorts the displaynames of the given item array.
    class cratefiller_sortList {};

    // Spawns the selected crate
    class cratefiller_spawnCrate {};
};
