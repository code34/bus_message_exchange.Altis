	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2013 Nicolas BOITEUX

	Bus Message Exchange (BME)
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
	*/

	BME_fnc_queue		= compilefinal preprocessFile "BME\BME_queue.sqf";
	BME_fnc_eventhandler	= compilefinal preprocessFile "BME\BME_eventhandler.sqf";
	BME_fnc_serverhandler	= compilefinal preprocessFile "BME\BME_serverhandler.sqf";
	BME_fnc_clienthandler	= compilefinal preprocessFile "BME\BME_clienthandler.sqf";
	BME_fnc_publishmission	= compilefinal preprocessFile "BME\BME_publishmission.sqf";

	if(isserver) then {
		bme_clients = [];
		bme_queue = [];
		_garbage = [] spawn BME_fnc_queue;
		_garbage = [] call BME_fnc_eventhandler;
		_garbage = [] call BME_fnc_serverhandler;
	};
	
	if(local player) then {
		bme_queue = [];
		_garbage = [] spawn BME_fnc_queue;
		_garbage = [] call BME_fnc_eventhandler;
		_garbage = [] call BME_fnc_clienthandler;

		bme_newclient = name player;
		["bme_newclient", "server"] call BME_fnc_publicvariable;
	};


	if(isserver) then {
		//bme_message = "hello what s up!";
		//["bme_message", "client"] call BME_fnc_publicvariable;
		while { true } do {
			hint format["%1", bme_clients];
			sleep 1;
		};
	};


