private _camera = "camera" camCreate [0, 0, 0]; 
 
_camera camPrepareTarget player; 
_camera camCommitPrepared 0; // needed for relative position 
_camera camPrepareRelPos [0, -15, 20]; 
_camera cameraEffect ["internal", "back"]; 
_camera camCommitPrepared 0; 
waitUntil { camCommitted _camera }; 
 
//_camera camPrepareRelPos [90, 25, 8]; 
//_camera camCommitPrepared 5; 
//waitUntil { camCommitted _camera }; 
 
//_camera camPrepareRelPos [-90, -5, 5]; 
//_camera camCommitPrepared 3; 
//waitUntil { camCommitted _camera }; 
 
sleep 3; 
_camera cameraEffect ["terminate", "back"]; 
camDestroy _camera; 