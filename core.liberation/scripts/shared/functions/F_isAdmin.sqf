//serverCommandAvailable "#kick";     // Available to any admin (voted in / logged in) or server host
if (isServer && hasInterface) then {
    serverCommandAvailable "#lock";     // Available to logged in admin or server host
} else {
    serverCommandAvailable "#exec";     // Available to logged in admin
};