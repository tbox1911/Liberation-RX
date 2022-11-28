// Community Base Addons
force force cba_disposable_dropUsedLauncher = 0;
force force cba_disposable_replaceDisposableLauncher = false;

// ACE "Medical"
force force ace_medical_AIDamageThreshold = 0.2; // Decreased AI damage threshold so AI dies in single headshot and few torso taps depending on vest
force force ace_medical_playerDamageThreshold = 3.5; // Increased damage threshold for players, high caliber weapons should still be fatal
force force ace_medical_bleedingCoefficient = 0.25;
force force ace_medical_fatalDamageSource = 1; // Sum of Trauma death condition
force force ace_medical_fractures = 0; // Disabled Fractures
force force ace_medical_limping = 0; // Disabled Limping
force force ace_medical_treatment_advancedBandages = 0; // Disabled advanced bandages
force force ace_medical_treatment_advancedDiagnose = 0; // Disabled advanced diagnose
force force ace_medical_treatment_advancedMedication = false; // Disabled advanced medication

// Injuries can be fatal
force force ace_medical_statemachine_fatalInjuriesPlayer = 0; // fatalInjuries Player: Always
force force ace_medical_statemachine_fatalInjuriesAI = 0; // fatalInjuries AI: Always

// Injuries can NOT be fatal
//force force ace_medical_statemachine_fatalInjuriesPlayer = 2; // fatalInjuries Player: Never
//force force ace_medical_statemachine_fatalInjuriesAI = 2; // fatalInjuries AI: Never

// ACE Logistique
force force ace_cargo_loadTimeCoefficient = 1;
force force ace_cargo_paradropTimeCoefficent = 1;
