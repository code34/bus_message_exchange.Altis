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

	private ["_variable", "_variablename", "_type"];

	while { true } do {
		waituntil {(count bme_queue) > 0};
		_variablename = (bme_queue select 0) select 0;
		_variable = (bme_queue select 0) select 1;
		_type = (bme_queue select 0) select 2;
		if((_type == "server") or (_type == "all")) then {
			call compile format["wcgarbage = [_variable] spawn BME_netcode_server_%1;", _variablename];
		};
		if((_type == "client") or (_type == "all")) then {
			call compile format["wcgarbage = [_variable] spawn BME_netcode_%1;", _variablename];
		};
		bme_queue set [0,-1]; 
		bme_queue = bme_queue - [-1];
		sleep 0.1;
	};

