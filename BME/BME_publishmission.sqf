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

	if (!isServer) exitWith {};

	private [
		"_count",
		"_ok",
		"_name",
		"_playerid",
		"_variables"
	];
	
	_name = _this select 1;

	_ok = true;
	_count = 0;
	// WAIT THAT JIP CLIENT IS INITIALIZED
	while {_ok} do {
		if(_name in bme_clients) then {
			_ok = false;
		};
		if(_count > 500) then {
			_ok = false;
		};
		_count = _count + 1;
		sleep 1;
	};

	{
		if(name _x == _name) then {
			_playerid = owner _x;
		};
		sleep 0.01;
	}foreach playableunits;

	//_variables = [
	//	"wcobjective",
	//];

	//{
	//	[_x, "client", _playerid] call WC_fnc_publicvariable;
	//	sleep 0.2;
	//}foreach _variables; 

	diag_log format["BME: PLAYER %1 CONNECTED", _name];
