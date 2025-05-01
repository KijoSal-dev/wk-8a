-- QUESTION 1

-- create database clinicdb;
--use clinicdb;

-- create table patients 
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- ceate table doctors
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- create table specializations
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    specialization_name VARCHAR(100) NOT NULL UNIQUE
);

-- create doctors specializations table
CREATE TABLE Doctor_Specializations (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- create appointments table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- sample data for patients
INSERT INTO Patients (name, email, phone, date_of_birth) VALUES 
('Hoppadiah Sprit', 'hpsprit@yahoo.com', '34569026410', '1970-11-01'),
('Lucy Anne', 'luce@gmail.com', '2579084213580', '2000-05-15');

-- sample data for doctors
INSERT INTO Doctors (name, email, phone) VALUES 
('Dr. Strange', 'dstrange@outlook.com', '109876543'),
('Dr. Who', 'who@hotmail.com', '4567890123');

-- sample data for specializations
INSERT INTO Specializations (specialization_name) VALUES 
('Cardiology'), ('Neurologist'), ('Optician');

-- sample data for doctor specializations
INSERT INTO Doctor_Specializations (doctor_id, specialization_id) VALUES 
(1, 1), (2, 2);

-- sample data for appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, reason) VALUES
(1, 1, '2023-10-01 10:00:00', 'Routine checkup'),
(2, 2, '2025-02-15 14:30:00', 'Nerological evaluation'),
(1, 2, '1999-12-25 20:50:00', 'Eye Check-up' );

-- QUESTION 2
-- Create users in task manager
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- create tasks in task manager
CREATE TABLE Tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status ENUM('pending', 'completed') DEFAULT 'pending',
    due_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);