/*
    Killah Potatoes Cratefiller v1.2.0 dialog

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Provides the cratefiller dialog.
*/

class KP_cratefiller {
    idd = KP_CRATEFILLER_IDC_DIALOG;
    movingEnable = 0;

    class controlsBackground {

        class KPCF_DialogTitle: KPGUI_PRE_DialogTitleS {
            text = "$STR_KP_CRATEFILLER_TITLE";
        };

        class KPCF_DialogArea: KPGUI_PRE_DialogBackgroundS {};

        // Tools controlsGroup

        class KPCF_GroupTools: KPGUI_PRE_ControlsGroupNoScrollbars {
            idc = KP_CRATEFILLER_IDC_GROUPOVERVIEW;
            x = safezoneX;
            y = safezoneY;
            w = safezoneW;
            h = safezoneH;

            class controls {

                class KPCF_DialogTitleTools: KPGUI_PRE_DialogTitleSR {
                    text = "$STR_KP_CRATEFILLER_TITLEOVERVIEW";
                    x = KP_GETX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
                    y = safeZoneY + safeZoneH * KP_Y_VAL_SR - safezoneY;
                };

                class KPCF_DialogAreaTools: KPGUI_PRE_DialogBackgroundSR {
                    x = KP_GETX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
                    y = KP_GETY_AREA(KP_Y_VAL_SR) - safezoneY;
                };

                class KPCF_ComboGroups: KPGUI_PRE_Combo {
                    idc = KP_CRATEFILLER_IDC_COMBOGROUPS;
                    x = KP_GETCX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
                    y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,0,48) - safezoneY;
                    w = KP_GETW(KP_WIDTH_VAL_SR,1);
                    h = KP_GETH(KP_HEIGHT_VAL_SR,24);
                    tooltip = "$STR_KP_CRATEFILLER_GROUPS_TT";
                    onLBSelChanged = "[] call KP_fnc_cratefiller_getPlayers";
                };

                class KPCF_ComboPlayers: KPCF_ComboGroups {
                    idc = KP_CRATEFILLER_IDC_COMBOPLAYERS;
                    y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,2,48) - safezoneY;
                    tooltip = "$STR_KP_CRATEFILLER_PLAYERS_TT";
                    onLBSelChanged = "[] call KP_fnc_cratefiller_getPlayerInventory";
                };

                class KPCF_MainWeapon: KPGUI_PRE_PictureRatio {
                    idc = KP_CRATEFILLER_IDC_MAINWEAPON;
                    text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa";
                    x = KP_GETCX(KP_X_VAL_SR,KP_WIDTH_VAL_SR,0,1) - safezoneX;
                    y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,6,48) - safezoneY;
                    w = KP_GETW(KP_WIDTH_VAL_SR,1);
                    h = KP_GETH(KP_HEIGHT_VAL_SR,4);
                };

                class KPCF_Handgun: KPCF_MainWeapon {
                    idc = KP_CRATEFILLER_IDC_HANDGUN;
                    text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Handgun_ca.paa";
                    y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,21,48) - safezoneY;
                };

                class KPCF_SecondaryWeapon: KPCF_MainWeapon {
                    idc = KP_CRATEFILLER_IDC_SECONDARYWEAPON;
                    text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\SecondaryWeapon_ca.paa";
                    y = KP_GETCY(KP_Y_VAL_SR,KP_HEIGHT_VAL_SR,36,48) - safezoneY;
                };

            };

        };

        // Tools controlsGroup end

    };

    class controls {

        class KPCF_Help: KPGUI_PRE_DialogCrossS {
            text = "KP\KPGUI\res\icon_help.paa";
            x = safeZoneX + safeZoneW * (KP_X_VAL_S + KP_WIDTH_VAL_S - 0.04);
            y = KP_GETY_CROSS(KP_Y_VAL_S);
            tooltip = "$STR_KP_CRATEFILLER_HELP_TT";
            action = "";
        };

        class KPCF_ButtonTools: KPGUI_PRE_DialogCrossS {
            idc = KP_CRATEFILLER_IDC_BUTTONOVERVIEW;
            text = "KP\KPGUI\res\icon_tools.paa";
            x = safeZoneX + safeZoneW * (KP_X_VAL_S + KP_WIDTH_VAL_S - 0.08);
            tooltip = "$STR_KP_CRATEFILLER_ACTIVATEOVERVIEW_TT";
            action = "[] call KP_fnc_cratefiller_showOverview";
        };

        // Crates

        class KPCF_TransportTitle: KPGUI_PRE_InlineTitle {
            text = "$STR_KP_CRATEFILLER_TITLETRANSPORT";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,0,48);
            w = KP_GETW(KP_WIDTH_VAL_S,1);
            h = KP_GETH(KP_HEIGHT_VAL_S,16);
        };

        class KPCF_ComboCrate: KPGUI_PRE_Combo {
            idc = KP_CRATEFILLER_IDC_COMBOCRATE;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,3,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_CRATE_TT";
        };

        class KPCF_ComboStorage: KPCF_ComboCrate {
            idc = KP_CRATEFILLER_IDC_COMBOSTORAGE;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
            w = KP_GETW(KP_WIDTH_VAL_S,(24/11));
            tooltip = "$STR_KP_CRATEFILLER_INVENTORY_TT";
            onLBSelChanged = "[] call KP_fnc_cratefiller_showInventory";
        };

        class KPCF_RefreshCargo: KPGUI_PRE_CloseCross {
            text = "KP\KPGUI\res\icon_refresh.paa";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,23,24);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,3,48);
            w = KP_GETW(KP_WIDTH_VAL_S,24);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_REFRESH_TT";
            action = "[] call KP_fnc_cratefiller_getNearStorages";
        };

        class KPCF_ButtonSpawnCrate: KPGUI_PRE_InlineButton {
            idc = KP_CRATEFILLER_IDC_BUTTONSPAWNCRATE;
            text = "$STR_KP_CRATEFILLER_SPAWNCRATE";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,5,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            onButtonClick = "[] call KP_fnc_cratefiller_spawnCrate";
        };

        class KPCF_ButtonDeleteCrate: KPCF_ButtonSpawnCrate {
            idc = KP_CRATEFILLER_IDC_BUTTONDELETECRATE;
            text = "$STR_KP_CRATEFILLER_DELETECRATE";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,5,48);
            onButtonClick = "[] call KP_fnc_cratefiller_deleteCrate";
        };

        // Equipment

        class KPCF_EquipmentTitle: KPCF_TransportTitle {
            text = "$STR_KP_CRATEFILLER_TITLEEQUIPMENT";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,7,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
        };

        class KPCF_ComboEquipment: KPGUI_PRE_Combo {
            idc = KP_CRATEFILLER_IDC_COMBOEQUIPMENT;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_CATEGORY_TT";
            onLBSelChanged = "[] call KP_fnc_cratefiller_createEquipmentList";
        };

        class KPCF_ComboWeapons: KPCF_ComboEquipment {
            idc = KP_CRATEFILLER_IDC_COMBOWEAPONS;
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
            w = KP_GETW(KP_WIDTH_VAL_S,3);
            tooltip = "$STR_KP_CRATEFILLER_WEAPONSELECTION_TT";
            onLBSelChanged = "[] call KP_fnc_cratefiller_createSubList";
        };

        class KPCF_SearchBar: KPGUI_PRE_EditBox {
            idc = KP_CRATEFILLER_IDC_SEARCHBAR;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,3);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
            w = KP_GETW(KP_WIDTH_VAL_S,6);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_SEARCH_TT";
            onKeyUp = "[] call KP_fnc_cratefiller_search";
        };

        class KPCF_LeftEquipmentListButton: KPGUI_PRE_BUTTON {
            idc = KP_CRATEFILLER_IDC_BUTTONLEFTEQUIPMENT;
            text = "-";
            onButtonClick = "[687416] call KP_fnc_cratefiller_removeEquipment";
        };

        class KPCF_RightEquipmentListButton: KPGUI_PRE_BUTTON {
            idc = KP_CRATEFILLER_IDC_BUTTONRIGHTEQUIPMENT;
            text = "+";
            onButtonClick = "[687416] call KP_fnc_cratefiller_addEquipment";
        };

        class KPCF_EquipmentList: KPGUI_PRE_ListNBox {
            idc = KP_CRATEFILLER_IDC_EQUIPMENTLIST;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,14,48);
            w = KP_GETW(KP_WIDTH_VAL_S,(2));
            h = KP_GETH(KP_HEIGHT_VAL_S,(48/32));

            columns[] = {0.05, 0.2};

            idcLeft = KP_CRATEFILLER_IDC_BUTTONLEFTEQUIPMENT;
            idcRight = KP_CRATEFILLER_IDC_BUTTONRIGHTEQUIPMENT;
        };

        // Inventory

        class KPCF_InventoryTitle: KPCF_TransportTitle {
            text = "$STR_KP_CRATEFILLER_TITLEINVENTORY";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,7,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
        };

        class KPCF_ExportName: KPGUI_PRE_EditBox {
            idc = KP_CRATEFILLER_IDC_EXPORTNAME;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,2,4);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
            w = KP_GETW(KP_WIDTH_VAL_S,4);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_EXPORT_TT";
        };

        class KPCF_ImportName: KPGUI_PRE_Combo {
            idc = KP_CRATEFILLER_IDC_IMPORTNAME;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,3,4);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
            w = KP_GETW(KP_WIDTH_VAL_S,4);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_IMPORT_TT";
        };

        class KPCF_ButtonExport: KPGUI_PRE_InlineButton {
            text = "$STR_KP_CRATEFILLER_EXPORT";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,2,4);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
            w = KP_GETW(KP_WIDTH_VAL_S,4);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            onButtonClick = "[] call KP_fnc_cratefiller_export";
        };

        class KPCF_ButtonImport: KPCF_ButtonExport {
            text = "$STR_KP_CRATEFILLER_IMPORT";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,3,4);
            w = KP_GETW(KP_WIDTH_VAL_S,(24/5));
            onButtonClick = "[] call KP_fnc_cratefiller_import";
        };

        class KPCF_DeletePreset: KPGUI_PRE_CloseCross {
            text = "KP\KPGUI\res\icon_recyclebin.paa";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,23,24);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
            w = KP_GETW(KP_WIDTH_VAL_S,24);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_DELETE_TT";
            action = "[] call KP_fnc_cratefiller_deletePreset";
        };

        class KPCF_LeftInventoryListButton: KPGUI_PRE_BUTTON {
            idc = KP_CRATEFILLER_IDC_BUTTONLEFTINVENTORY;
            text = "-";
            onButtonClick = "[687421] call KP_fnc_cratefiller_removeEquipment";
        };

        class KPCF_RightInventoryListButton: KPGUI_PRE_BUTTON {
            idc = KP_CRATEFILLER_IDC_BUTTONRIGHTINVENTORY;
            text = "+";
            onButtonClick = "[687421] call KP_fnc_cratefiller_addEquipment";
        };

        class KPCF_InventoryList: KPGUI_PRE_ListNBox {
            idc = KP_CRATEFILLER_IDC_INVENTORYLIST;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,8,16);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,14,48);
            w = KP_GETW(KP_WIDTH_VAL_S,(16/7));
            h = KP_GETH(KP_HEIGHT_VAL_S,(48/32));

            columns[] = {0.05, 0.2, 0.3};

            idcLeft = KP_CRATEFILLER_IDC_BUTTONLEFTINVENTORY;
            idcRight = KP_CRATEFILLER_IDC_BUTTONRIGHTINVENTORY;
        };

        class KPCF_ClearInventory: KPGUI_PRE_InlineButton {
            idc = KP_CRATEFILLER_IDC_BUTTONCLEARINVENTORY;
            text = "$STR_KP_CRATEFILLER_CLEARINVENTORY";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,8,16);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,44,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            onbuttonClick = "[] call KP_fnc_cratefiller_setInventory";
        };

        class KPCF_ProgressBar : KPGUI_PRE_ProgressBar {
            idc = KP_CRATEFILLER_IDC_PROGRESSBAR;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,46,48);
            w = KP_GETW(KP_WIDTH_VAL_S,1);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KP_CRATEFILLER_FILLLEVEL_TT";
        };

            class KPCF_DialogCross: KPGUI_PRE_DialogCrossS {};

    };
};
