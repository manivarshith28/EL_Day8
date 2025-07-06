use day8;

DELIMITER $$

DROP PROCEDURE IF EXISTS GetEmployeeDetails;

CREATE PROCEDURE GetEmployeeDetails(IN empID_param INT)
BEGIN
    SELECT * 
    FROM employees  
    WHERE empID = empID_param;  -- Now column and parameter are clearly different
END $$

DELIMITER ;

CALL GetEmployeeDetails(3);  -- This will fetch the employee with empID = 3

DELIMITER $$

CREATE FUNCTION GetEmployeeSalary(empID_param INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE empSalary DECIMAL(10,2);

    SELECT salary INTO empSalary
    FROM employees
    WHERE empID = empID_param;

    -- Return the salary (if found, else NULL)
    RETURN empSalary;
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION GetSalaryGrade(empID_param INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE empSalary DECIMAL(10,2);
    DECLARE grade VARCHAR(20);

    -- Get the salary of the employee
    SELECT salary INTO empSalary
    FROM employees
    WHERE empID = empID_param;

    -- Apply conditional logic
    IF empSalary IS NULL THEN
        SET grade = 'Not Found';
    ELSEIF empSalary < 60000 THEN
        SET grade = 'Junior';
    ELSEIF empSalary <= 70000 THEN
        SET grade = 'Mid-level';
    ELSE
        SET grade = 'Senior';
    END IF;

    RETURN grade;
END $$

DELIMITER ;

SELECT GetSalaryGrade(3) AS Grade;


