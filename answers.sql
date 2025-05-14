-- ================================================
-- Clinic Booking System Database (MySQL)
-- ================================================

-- ========================
-- DROP TABLES IF EXISTS (FOR RESETTING)
-- ========================
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Service;

-- ========================
-- DEPARTMENT TABLE
-- ========================
CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100)
);

-- ========================
-- DOCTOR TABLE
-- ========================
CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100),
    Phone VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- ========================
-- PATIENT TABLE
-- ========================
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Phone VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE
);

-- ========================
-- SERVICE TABLE
-- ========================
CREATE TABLE Service (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    Cost DECIMAL(10,2) NOT NULL
);

-- ========================
-- BOOKING TABLE (APPOINTMENTS)
-- ========================
CREATE TABLE Booking (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    BookingDate DATE NOT NULL,
    BookingTime TIME NOT NULL,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    ServiceID INT NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID),
    CONSTRAINT UC_Booking UNIQUE (BookingDate, BookingTime, DoctorID) -- Avoid double-booking
);

-- ================================================
-- SAMPLE DATA (OPTIONAL - FOR TESTING)
-- ================================================
INSERT INTO Department (Name, Location) VALUES 
('Cardiology', 'Block A'),
('Pediatrics', 'Block B'),
('Orthopedics', 'Block C');

INSERT INTO Doctor (Name, Specialty, Phone, Email, DepartmentID) VALUES 
('Dr. John Smith', 'Cardiologist', '0712345678', 'john.smith@clinic.com', 1),
('Dr. Jane Doe', 'Pediatrician', '0723456789', 'jane.doe@clinic.com', 2);

INSERT INTO Patient (Name, DOB, Gender, Phone, Email) VALUES 
('Alice Brown', '1990-05-10', 'Female', '0700123456', 'alice.brown@example.com'),
('Bob White', '1985-08-20', 'Male', '0700765432', 'bob.white@example.com');

INSERT INTO Service (Name, Description, Cost) VALUES 
('General Consultation', 'Standard health checkup', 2000.00),
('ECG Test', 'Electrocardiogram for heart health', 5000.00);

INSERT INTO Booking (BookingDate, BookingTime, PatientID, DoctorID, ServiceID) VALUES 
('2025-05-15', '10:00:00', 1, 1, 2),
('2025-05-16', '14:30:00', 2, 2, 1);
