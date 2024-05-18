CREATE TABLE user (
    id_user INT NOT NULL AUTO_INCREMENT, 
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    PRIMARY KEY (id_user)
);

INSERT INTO user (username, email, password) VALUES 
    ('faiz', 'faiz.am@gmail.com', password('Faiz12345@')),
    ('man', 'man@gmail.com', password('Man123!@#')),
    ('Yunus', 'Yu@gmail.com', password('Yunus123#$')),
    ('Yunusdawda', 'Yuaa@gmail.com', password('yUnu123Ss@')),
    ('faizdawda', 'faidadaz@gmail.com', password('Faiz123#$%$'));


CREATE TABLE services (
    id_service INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    car VARCHAR(255),
    plate VARCHAR(255),
    date DATETIME,
    PRIMARY KEY (id_service),
    FOREIGN KEY (id_user) REFERENCES user(id_user)
);


INSERT INTO services(id_user, name, email, phone, car, plate, date) VALUES
  (1, 'faiz', 'faiz.am@gmail.com', '0123213121', 'axia', 'KWX1231', '2024-05-18'),  
  (10, 'ali', 'ali.b@hotmail.com', '0187654321', 'myvi', 'ABC1234', '2024-05-10'),  
  (11, 'siti', 'sitikh@yahoo.com', '0179876543', 'proton', 'DEF5678', '2024-04-25'),  
  (12, 'amin', 'aminuddin@outlook.com', '0102345678', 'perodua', 'GHI9012', '2024-03-14');  

CREATE TABLE booking (
    id_booking INT NOT NULL AUTO_INCREMENT,
    id_service INT NOT NULL,
    id_user INT NOT NULL,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    car VARCHAR(255),
    plate VARCHAR(255),
    date VARCHAR(255),
    PRIMARY KEY (id_booking),
    FOREIGN KEY (id_service) REFERENCES services(id_service),
    FOREIGN KEY (id_user) REFERENCES user(id_user)
);


ALTER TABLE booking MODIFY COLUMN date VARCHAR(255);

