CREATE TABLE CLIENTE (
  dni VARCHAR(9) PRIMARY KEY,
  nombre VARCHAR(50)
);

SELECT * FROM CLIENTE;

CREATE TABLE EMPLEADO (
  id_empleado SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  fecha_ingreso DATE,
  ventas_tajinaste_plus INTEGER
);

CREATE TABLE VIVERO (
  id_vivero SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  direccion VARCHAR(50),
  localizacion VARCHAR(50)
);

CREATE TABLE ZONA (
  id_zona SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  localizacion VARCHAR(50),
  id_vivero SERIAL,
  FOREIGN KEY (id_vivero) REFERENCES Vivero(id_vivero)
);

CREATE TABLE PRODUCTO (
  id_producto SERIAL PRIMARY KEY,
  id_zona SERIAL,
  stock INTEGER,
  nombre VARCHAR(50),
  precio DOUBLE PRECISION,
  descripcion VARCHAR(100),
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona)
);


CREATE TABLE MIEMBRO_TAJINASTE (
  fecha_ingreso DATE,
  bonificacion VARCHAR(50)[], 
  dni VARCHAR(9),
  FOREIGN KEY (dni) REFERENCES CLIENTE(dni)
);

CREATE TABLE COMPRA (
    id_pedido SERIAL PRIMARY KEY,
    dni_cliente VARCHAR(9),
    id_empleado SERIAL,
    monto_total DOUBLE PRECISION CHECK (monto_total > 0),
    FOREIGN KEY (dni_cliente) REFERENCES CLIENTE(dni),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE LISTA_PRODUCTOS (
    id_pedido SERIAL,
    id_producto SERIAL,
    cantidad INTEGER CHECK (cantidad > 0),
    FOREIGN KEY (id_pedido) REFERENCES compra(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);



CREATE TABLE TAREA (
  id_tarea SERIAL PRIMARY KEY,
  descripcion VARCHAR(100),
  fecha_inicio DATE,
  fecha_fin DATE CHECK (fecha_fin > fecha_inicio),
  id_empleado SERIAL,
  id_zona SERIAL,
  FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado),
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona)
);


/* ----------------------------- INSERCIONES ----------------------------- */

INSERT INTO cliente (dni, nombre) VALUES
  ('12345678R', 'Juan Pérez'),
  ('98765432K', 'María López'),
  ('55555555M', 'Pedro Rodríguez'),
  ('11111111N', 'Ana Martínez'),
  ('66696969P', 'Carlos Gómez'),
  ('22222222A', 'Lucía García'),
  ('33333333B', 'Javier Fernández'),
  ('44444444C', 'Sara Gutiérrez'),
  ('77777777D', 'Manuel Sánchez'),
  ('88888888E', 'Carmen Pérez');


SELECT * FROM cliente;

INSERT INTO empleado (nombre, fecha_ingreso, ventas_tajinaste_plus) 
VALUES 
  ('Laura Sánchez', '2021-12-10', 11),
  ('Sergio González', '2022-01-20', 7),
  ('Isabel Pantoja', '2021-11-25', 13),
  ('Carlos Baute', '2022-02-15', 14),
  ('Elena de Troya', '2022-01-05', 10);

SELECT * FROM EMPLEADO;

INSERT INTO VIVERO (nombre, direccion, localizacion) 
VALUES 
  ('Flores de Madrid', 'Calle Gran Vía 123', 'Madrid'),
  ('Plantas de Barcelona', 'Rambla de Catalunya 456', 'Barcelona'),
  ('Jardín del Paraíso', 'Calle del Arco Iris 789', 'Edén'),
  ('El Vivero de las Maravillas', 'Camino de las Maravillas 321', 'Maravillaville'),
  ('Plantas Risueñas', 'Calle de la Alegría 654', 'Ciudad Feliz');

SELECT * FROM vivero;

INSERT INTO zona (nombre, localizacion, id_vivero) 
VALUES 
  ('Zona Rosas', 'Sector A', 1),       
  ('Zona Suculentas', 'Sector B', 1),  
  ('Zona Arbustos', 'Sector C', 1),    
  ('Zona Orquídeas', 'Sector D', 1),   
  ('Zona Palmeras', 'Sector E', 1),    
  ('Zona Cactáceas', 'Sector A', 2),   
  ('Zona Plantas de Interior', 'Sector B', 2), 
  ('Zona Árboles Frutales', 'Sector C', 2),   
  ('Zona Plantas Tropicales', 'Sector D', 2),
  ('Zona Flores Silvestres', 'Sector E', 2),
  ('Zona de Fantasía', 'Sector A', 3),
  ('Zona de Ensueño', 'Sector B', 3), 
  ('Zona de Magia', 'Sector C', 3),
  ('Zona de Maravillas', 'Sector D', 3),
  ('Zona de Misterios', 'Sector E', 3),
  ('Zona de las Maravillas', 'Sector A', 4),
  ('Zona de los Secretos', 'Sector B', 4),
  ('Zona de los Sueños', 'Sector C', 4),
  ('Zona de los Tesoros', 'Sector D', 4),
  ('Zona de las Sorpresas', 'Sector E', 4),
  ('Zona de la Risa', 'Sector A', 5),
  ('Zona del Buen Humor', 'Sector B', 5),
  ('Zona de las Sonrisas', 'Sector C', 5),
  ('Zona de las Carcajadas', 'Sector D', 5),
  ('Zona de la Alegría', 'Sector E', 5);

SELECT * FROM zona;


INSERT INTO miembro_tajinaste (fecha_ingreso, bonificacion, dni) 
VALUES 
  ('2022-01-15', ARRAY['Descuento 10%', 'Envío gratis'], '12345678R'),
  ('2022-02-20', ARRAY['Descuento 15%'], '98765432K'),
  ('2021-12-05', ARRAY['Regalo sorpresa'], '55555555M'),
  ('2022-03-10', ARRAY['Descuento 20%'], '11111111N'),
  ('2022-02-01', ARRAY['Envío gratis'], '66696969P');


INSERT INTO producto (id_zona, stock, nombre, precio, descripcion) 
VALUES 
  (1, 50, 'Rosa Roja', 10.5, 'Una hermosa rosa roja'),
  (1, 30, 'Cactus de Aloe', 8.2, 'Un cactus de aloe vera resistente'),
  (1, 20, 'Arbusto de Boj', 15.7, 'Un arbusto decorativo'),
  (1, 40, 'Orquídea Blanca', 12.0, 'Una orquídea de color blanco puro'),
  (1, 60, 'Palmera Datilera', 25.3, 'Una palmera con dátiles deliciosos'),
  (2, 45, 'Cactus de Espinas', 7.8, 'Un cactus con espinas afiladas'),
  (2, 25, 'Ficus de Hoja Grande', 18.9, 'Un ficus con hojas grandes y verdes'),
  (2, 35, 'Manzano', 14.2, 'Un árbol de manzanas jugosas'),
  (2, 50, 'Hibisco Tropical', 11.5, 'Una planta de hibisco exótica'),
  (2, 30, 'Margarita Silvestre', 9.0, 'Una margarita de campo'),
  (3, 55, 'Rosa Encantada', 13.6, 'Una rosa con encanto mágico'),
  (3, 28, 'Cala de Ensueño', 8.7, 'Una cala blanca y elegante'),
  (3, 22, 'Magnolia de Ensueño', 16.5, 'Una magnolia con flores fragantes'),
  (3, 38, 'Lirio de Maravillas', 11.8, 'Un lirio de colores vibrantes'),
  (3, 60, 'Bonsai de Misterios', 21.0, 'Un bonsai con aura misteriosa'),
  (4, 42, 'Rosa de los Secretos', 12.9, 'Una rosa llena de secretos'),
  (4, 20, 'Ficus Encantado', 19.3, 'Un ficus con un encanto especial'),
  (4, 32, 'Manzano de Tesoros', 14.8, 'Un manzano lleno de tesoros'),
  (4, 48, 'Hibisco de Sorpresas', 11.2, 'Un hibisco lleno de sorpresas'),
  (4, 26, 'Margarita de Risa', 9.5, 'Una margarita que te hará reír'),
  (5, 58, 'Rosa Risueña', 13.0, 'Una rosa llena de buen humor'),
  (5, 33, 'Cala del Buen Humor', 8.9, 'Una cala que alegra el día'),
  (5, 27, 'Magnolia Sonriente', 17.2, 'Una magnolia que te hace sonreír'),
  (5, 36, 'Lirio de las Carcajadas', 11.3, 'Un lirio que provoca carcajadas'),
  (5, 62, 'Bonsai de Alegría', 20.1, 'Un bonsai que trae alegría');

SELECT * FROM producto;

INSERT INTO compra (dni_cliente, id_empleado, monto_total) 
VALUES 
  ('12345678R', 2, 50.0),
  ('98765432K', 2, 40.0),
  ('55555555M', 3, 60.0),
  ('11111111N', 4, 70.0),
  ('66696969P', 5, 55.0);

SELECT * FROM compra;

INSERT INTO lista_productos (id_pedido, id_producto, cantidad) 
VALUES 
  (1, 1, 3),
  (1, 2, 5),
  (2, 3, 2),
  (2, 4, 1),
  (2, 5, 4),
  (3, 6, 2),
  (3, 7, 3),
  (3, 8, 2),
  (4, 9, 4),
  (4, 10, 1),
  (5, 11, 3),
  (5, 12, 2),
  (5, 13, 1),
  (5, 14, 5),
  (5, 15, 2),
  (5, 16, 3),
  (5, 17, 2),
  (5, 18, 4),
  (5, 19, 1),
  (5, 20, 3);

INSERT INTO tarea (descripcion, fecha_inicio, fecha_fin, id_empleado, id_zona) 
VALUES 
  ('Replantar cactus', '2023-11-02', '2023-11-04', 2, 2),
  ('Cuidar arbustos', '2023-11-03', '2023-11-05', 3, 3),
  ('Fertilizar orquídeas', '2023-11-04', '2023-11-06', 4, 4),
  ('Podar palmeras', '2023-11-05', '2023-11-07', 5, 5),
  ('Regar cactus', '2023-11-06', '2023-11-08', 2, 2),
  ('Abonar arbustos', '2023-11-07', '2023-11-09', 3, 3);

