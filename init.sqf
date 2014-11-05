	call compilefinal preprocessFileLineNumbers "BME\init.sqf";

	if(local player) then {
		bme_log = "hello server, message send from client";
		["bme_log", "server"] call BME_fnc_publicvariable;
	};

	if(isserver) then {
		while {true} do {
			bme_message = "hello client, message send from server";
			["bme_message", "client"] call BME_fnc_publicvariable;
			sleep 2;
		};
	};
