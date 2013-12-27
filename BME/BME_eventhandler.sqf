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

		_variablename 	= _this select 0;
		_variablevalue 	=  call compile format["%1", _variablename];
		_type		= _this select 1;
		_playerid 	= _this select 2;

		if(isnil "_type") exitwith {hint "BME: missing destination parameter"};
		if!(typename _variablename == "STRING") exitwith {hint "BME: wrong type variablename parameter, should be STRING"};
		if!(typename _type == "STRING") exitwith {hint "BME: wrong type destination parameter, should be STRING"};
		if!(tolower(_type) in ["client", "server", "all"]) exitwith {hint "BME: wrong destination parameter should be client|server|all"};

		bme_addqueue = [_variablename, _variablevalue, _type];

		switch (tolower(_type)) do {
			case "server": {
				publicvariableserver "bme_addqueue";
			};

			case "client": {
				if(!isnil "_playerid") then {
					_playerid publicvariableclient "bme_addqueue";
				} else {
					if((local player) and (isserver)) then {
						(owner player) publicvariableclient "bme_addqueue";
					};
					publicvariable "bme_addqueue";
				};
			};

			default {
				if((local player) and (isserver)) then {
					(owner player) publicvariableclient "bme_addqueue";
				};
				publicvariable "bme_addqueue";
			};
		};
	};

	"bme_addqueue" addPublicVariableEventHandler {
		// insert message in the queue if its for server or everybody
		if((isserver) and (((bme_addqueue select 2) == "server") or ((bme_addqueue select 2) == "all"))) then {
			bme_queue = bme_queue + [bme_addqueue];
		};

		// insert message in the queue if its for client or everybody
		if((local player) and (((bme_addqueue select 2) == "client") or ((bme_addqueue select 2) == "all"))) then {
				bme_queue = bme_queue + [bme_addqueue];
		};
	};
