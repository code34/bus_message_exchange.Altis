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

	BME_fnc_publicvariable = {
		private ["_variablename", "_variablevalue", "_type", "_playerid"];

		_variablename = _this select 0;
		_variablevalue =  call compile format["%1", _variablename];
		_type = _this select 1;
		_playerid = _this select 2;

		bme_addqueue = [_variablename, _variablevalue, _type];

		// fix by A2 AO
		//if(isserver and local player) then {
		//	bme_queue = bme_queue + [bme_addqueue];
		//};

		switch (_type) do {
			case "server": {
				publicvariableserver "bme_addqueue";
			};

			case "client": {
				if(!isnil "_playerid") then {
					_playerid publicvariableclient "bme_addqueue";
				} else {
					publicvariable "bme_addqueue";
				};
			};

			default {
				publicvariable "bme_addqueue";
			};
		};
	};

	"bme_addqueue" addPublicVariableEventHandler {
		// insert message in the queue if its for server or everybody
		if(isserver) then {
			if( ((bme_addqueue select 2) == "server") or ((bme_addqueue select 2) == "all") ) then {
				bme_queue = bme_queue + [bme_addqueue];
			};
		};

		// insert message in the queue if its for client or everybody
		if(local player) then {
			if( ((bme_addqueue select 2) == "client") or ((bme_addqueue select 2) == "all") ) then {
				bme_queue = bme_queue + [bme_addqueue];
			};
		};
	};
