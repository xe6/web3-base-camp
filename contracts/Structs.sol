// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

error BadCarIndex(uint _index);

contract GarageManager {
    mapping(address => Car[]) public garage;

    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    function addCar(
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint _numberOfDoors
    ) external {
        Car memory createdCar = Car(_make, _model, _color, _numberOfDoors);
        garage[msg.sender].push(createdCar);
    }

    function getMyCars() external view returns (Car[] memory) {
        // myCars = new Car[](garage[msg.sender].length);
        return garage[msg.sender];
    }

    function getUserCars(
        address _addr
    ) external view returns (Car[] memory) {
        return garage[_addr];
    }

    function updateCar(
        uint _carIndex,
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint _numberOfDoors
    ) external {
        if (_carIndex < 0 || _carIndex > garage[msg.sender].length) {
            revert BadCarIndex(_carIndex);
        }
        garage[msg.sender][_carIndex].make = _make;
        garage[msg.sender][_carIndex].model = _model;
        garage[msg.sender][_carIndex].color = _color;
        garage[msg.sender][_carIndex].numberOfDoors = _numberOfDoors;
    }

    function resetMyGarage() external {
        delete garage[msg.sender];
    }
}
