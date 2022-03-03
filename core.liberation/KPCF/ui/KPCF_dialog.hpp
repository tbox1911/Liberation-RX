/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Provides the cratefiller dialog.
*/

class KPCF_dialog {
    idd = 758067;
    movingEnable = 0;

    class controlsBackground {

        class KP_DialogTitle: KPGUI_PRE_DialogTitleS {
            text = "$STR_KPCF_TITLE";
        };

        class KP_DialogArea: KPGUI_PRE_DialogBackgroundS {};

        // Crates

        class KP_TransportTitle: KPGUI_PRE_InlineTitle {
            text = "$STR_KPCF_TITLETRANSPORT";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,0,48);
            w = KP_GETW(KP_WIDTH_VAL_S,1);
            h = KP_GETH(KP_HEIGHT_VAL_S,16);
        };

        // Equipment

        class KP_EquipmentTitle: KP_TransportTitle {
            text = "$STR_KPCF_TITLEEQUIPMENT";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,7,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
        };

        // Inventory

        class KP_InventoryTitle: KP_TransportTitle {
            text = "$STR_KPCF_TITLEINVENTORY";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,7,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
        };

    };

    class controls {

        class KP_Help: KPGUI_PRE_DialogCrossS {
            text = "KPCF\img\icon_help.paa";
            x = safeZoneX + safeZoneW * (KP_X_VAL_S + KP_WIDTH_VAL_S - 0.04)
            y = KP_GETY_CROSS(KP_Y_VAL_S);
            tooltip = "$STR_KPCF_TOOLTIPHELP";
            action = "";
        };

        // Crates

        class KP_ComboCrate: KPGUI_PRE_Combo {
            idc = 75801;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,3,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KPCF_TOOLTIPCRATE";
        };

        class KP_ComboCargo: KP_ComboCrate {
            idc = 75802;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
            w = KP_GETW(KP_WIDTH_VAL_S,(24/11));
            tooltip = "$STR_KPCF_TOOLTIPINVENTORY";
            onLBSelChanged = "[] call KPCF_fnc_setActiveStorage";
        };

        class KP_RefreshCargo: KPGUI_PRE_CloseCross {
            text = "KPCF\img\icon_refresh.paa";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,23,24);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,3,48);
            w = KP_GETW(KP_WIDTH_VAL_S,24);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KPCF_TOOLTIPREFRESH";
            action = "[] call KPCF_fnc_getNearStorages";
        };

        class KP_ButtonSpawnCrate: KPGUI_PRE_InlineButton {
            idc = 75803;
            text = "$STR_KPCF_SPAWNCRATE";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,5,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            onButtonClick = "[] call KPCF_fnc_spawnCrate";
        };

        class KP_ButtonDeleteCrate: KP_ButtonSpawnCrate {
            idc = 75804;
            text = "$STR_KPCF_DELETECRATE";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,1,2);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,5,48);
            onButtonClick = "[] call KPCF_fnc_deleteCrate";
        };

        // Equipment

        class KP_ComboEquipment: KPGUI_PRE_Combo {
            idc = 75810;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
            w = KP_GETW(KP_WIDTH_VAL_S,2);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KPCF_TOOLTIPCATEGORY";
            onLBSelChanged = "[] call KPCF_fnc_createEquipmentList";
        };

        class KP_ComboWeapons: KP_ComboEquipment {
            idc = 75811;
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
            tooltip = "$STR_KPCF_TOOLTIPWEAPONSELECTION";
            onLBSelChanged = "[] call KPCF_fnc_createSubList";
        };

        class KP_EquipmentList: KPGUI_PRE_ListBox {
            idc = 75812;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,14,48);
            w = KP_GETW(KP_WIDTH_VAL_S,(16/7));
            h = KP_GETH(KP_HEIGHT_VAL_S,(48/32));
        };

        class KP_ButtonAddEquipment: KPGUI_PRE_InlineButton {
            text = "+ 1";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,7,16);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,14,48);
            w = KP_GETW(KP_WIDTH_VAL_S,16);
            h = KP_GETH(KP_HEIGHT_VAL_S,(48/8));
            onButtonClick = "[1] call KPCF_fnc_addEquipment";
        };

        class KP_ButtonAddEquipment5: KP_ButtonAddEquipment {
            text = "+ 5";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,22,48);
            onButtonClick = "[5] call KPCF_fnc_addEquipment";
        };

        class KP_ButtonAddEquipment10: KP_ButtonAddEquipment {
            text = "+ 10";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,30,48);
            onButtonClick = "[10] call KPCF_fnc_addEquipment";
        };

        class KP_ButtonAddEquipment20: KP_ButtonAddEquipment {
            text = "+ 20";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,38,48);
            onButtonClick = "[20] call KPCF_fnc_addEquipment";
        };

        // Inventory

        class KP_ExportName: KPGUI_PRE_EditBox {
            idc = 75820;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,2,4);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
            w = KP_GETW(KP_WIDTH_VAL_S,4);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KPCF_TOOLTIPEXPORT";
        };

        class KP_ImportName: KPGUI_PRE_Combo {
            idc = 75821;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,3,4);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,10,48);
            w = KP_GETW(KP_WIDTH_VAL_S,4);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KPCF_TOOLTIPIMPORT";
        };

        class KP_ButtonExport: KPGUI_PRE_InlineButton {
            text = "$STR_KPCF_EXPORT";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,2,4);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
            w = KP_GETW(KP_WIDTH_VAL_S,4);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            onButtonClick = "[] call KPCF_fnc_export";
        };

        class KP_ButtonImport: KP_ButtonExport {
            text = "$STR_KPCF_IMPORT";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,3,4);
            w = KP_GETW(KP_WIDTH_VAL_S,(24/5));
            onButtonClick = "[] call KPCF_fnc_import";
        };

        class KP_DeletePreset: KPGUI_PRE_CloseCross {
            text = "KPCF\img\icon_recyclebin.paa";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,23,24);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,12,48);
            w = KP_GETW(KP_WIDTH_VAL_S,24);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KPCF_TOOLTIPDELETE";
            action = "[] call KPCF_fnc_deletePreset";
        };

        class KP_InventoryList: KPGUI_PRE_ListBox {
            idc = 75822;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,8,16);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,14,48);
            w = KP_GETW(KP_WIDTH_VAL_S,(16/7));
            h = KP_GETH(KP_HEIGHT_VAL_S,(48/32));
        };

        class KP_ButtonRemoveEquipment: KPGUI_PRE_InlineButton {
            text = "- 1";
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,15,16);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,14,48);
            w = KP_GETW(KP_WIDTH_VAL_S,16);
            h = KP_GETH(KP_HEIGHT_VAL_S,(48/8));
            onButtonClick = "[1] call KPCF_fnc_removeEquipment";
        };

        class KP_ButtonRemoveEquipment5: KP_ButtonRemoveEquipment {
            text = "- 5";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,22,48);
            onButtonClick = "[5] call KPCF_fnc_removeEquipment";
        };

        class KP_ButtonRemoveEquipment10: KP_ButtonRemoveEquipment {
            text = "- 10";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,30,48);
            onButtonClick = "[10] call KPCF_fnc_removeEquipment";
        };

        class KP_ButtonRemoveEquipmentClear: KP_ButtonRemoveEquipment {
            text = "Clear";
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,38,48);
            onButtonClick = "[0] call KPCF_fnc_removeEquipment";
        };

        class KP_ProgressBar : KPGUI_PRE_ProgressBar {
            idc = 75823;
            x = KP_GETCX(KP_X_VAL_S,KP_WIDTH_VAL_S,0,1);
            y = KP_GETCY(KP_Y_VAL_S,KP_HEIGHT_VAL_S,46,48);
            w = KP_GETW(KP_WIDTH_VAL_S,1);
            h = KP_GETH(KP_HEIGHT_VAL_S,24);
            tooltip = "$STR_KPCF_TOOLTIPFILLLEVEL"
        };

            class KP_DialogCross: KPGUI_PRE_DialogCrossS {};

    };
};
