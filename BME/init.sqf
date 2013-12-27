	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2013 Nicolas BOITEUX

	Exchange bus message
	
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

	BME_eventhandler	= compilefinal preprocessFile "BME\BME_eventhandler.sqf";
	BME_serverhandler	= compilefinal preprocessFile "BME\BME_serverhandler.sqf";
	BME_clienthandler	= compilefinal preprocessFile "BME\BME_clienthandler.sqf";
	BME_publishmission	= compilefinal preprocessFile "BME\BME_publishmission.sqf";

	if(isserver) then {
		bme_clients = [];
		_garbage = [] spawn WC_fnc_eventhandler;
		_garbage = [] spawn WC_fnc_serverhandler;
	};
	
	if(local player) then {
		_garbage = [] spawn WC_fnc_eventhandler;
		_garbage = [] spawn WC_fnc_clienthandler;

		bme_newclient = name player;
		["bme_newclient", "server"] call BME_publicvariable;
	};


