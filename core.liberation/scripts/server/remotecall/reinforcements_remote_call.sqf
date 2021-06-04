if (!isServer && hasInterface) exitWith {};

params [ "_targetsector" ];
[ _targetsector ] spawn reinforcements_manager;
