// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

abstract contract Employee {
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public virtual returns (uint);
}

contract Salaried is Employee {
    uint public annualSalary;

    function getAnnualCost() public view override returns (uint) {
        return annualSalary;
    }

    constructor(
        uint _idNumber,
        uint _managerId,
        uint _annualSalary
    ) Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }
}

contract Hourly is Employee {
    uint public hourlyRate;

    constructor(
        uint _idNumber,
        uint _managerId,
        uint _hourlyRate
    ) Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    function getAnnualCost() public view override returns (uint) {
        return hourlyRate * 2080;
    }
}

contract Manager {
    uint[] public employeeIds;

    function addReport(uint _idNumber) public {
        employeeIds.push(_idNumber);
    }

    function resetReports() public {
        delete employeeIds;
    }
}

contract SalesPerson is Hourly {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint _hourlyRate
    ) Hourly(_idNumber, _managerId, _hourlyRate) {}
}

contract EngineeringManager is Salaried, Manager {
    constructor(
        uint _idNumber,
        uint _managerId,
        uint _annualSalary
    ) Salaried(_idNumber, _managerId, _annualSalary) {}
}

contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
