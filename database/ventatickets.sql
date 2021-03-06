CREATE Table role(
  id_role INT(11) PRIMARY KEY NOT NULL,
  descripcion VARCHAR(50) NOT NULL
);
CREATE Table usuario(
  id_usuario INT(11) PRIMARY KEY NOT NULL,
  id_role INT(11) NOT NULL,
  email VARCHAR(30) NOT NULL,
  password VARCHAR(30) NOT NULL,
  FOREIGN KEY (id_role) REFERENCES role(id_role)
);
CREATE Table factura(
  id_factura INT(11) PRIMARY KEY NOT NULL,
  id_usuario INT(11) NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);
CREATE Table ticket(
  id_ticket INT(11) PRIMARY KEY NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  sala VARCHAR(50) NOT NULL,
  sitios INT(2) NOT NULL,
  precio DECIMAL(5, 2) NOT NULL
);
CREATE Table detalle(
  id_detalle INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  id_factura INT(11) NOT NULL,
  id_ticket INT(11) NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  cantidad INT(2) NOT NULL,
  total DECIMAL(5, 2),
  FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
  FOREIGN KEY (id_ticket) REFERENCES ticket(id_ticket)
);
-- Roles:
INSERT INTO
  role
VALUES
  (1, 'jefe'),(2, 'cliente');
-- Usuario:
INSERT INTO
  usuario
VALUES
  (1, 1, 'eric@test.com', 'eric123'),
  (2, 2, 'nico@test.com', 'nico123'),
  (3, 2, 'po@test.com', 'po123');
-- Factura:
INSERT INTO
  factura
VALUES
  (1, 2, null),(2, 3, null);
-- Ticket:
INSERT INTO
  ticket
VALUES
  (
    1,
    'ticket 1',
    '2021-10-22',
    '16:30:00',
    'sala 1',
    5,
    4.50
  ),
  (
    2,
    'ticket 2',
    '2021-10-25',
    '13:45:00',
    'sala 2',
    10,
    5.50
  ),
  (
    3,
    'ticket 3',
    '2021-10-23',
    '10:15:00',
    'sala 3',
    5,
    6.50
  );
-- Detalle:
INSERT INTO
  detalle
VALUES
  (null, 1, 3, null, 3, 0),(null, 2, 1, null, 2, 0);
--Consultas:
  --Consultar el usuario, nombre del ticket y el total que pago
SELECT
  u.email,
  t.nombre,
  d.total
FROM
  usuario as u,
  factura as f,
  detalle as d,
  ticket as t
WHERE
  u.id_usuario = f.id_usuario
  AND f.id_factura = d.id_factura
  AND d.id_ticket = t.id_ticket;
--Consultar el total de gastos por usuario
SELECT
  u.email,
  SUM(d.total)
FROM
  usuario as u,
  factura as f,
  detalle as d
WHERE
  f.id_usuario = u.id_usuario
  AND d.id_factura = f.id_factura
group by
  u.email;
-- Trigger:
  -- Hacer un trigger que al hacer una compra de un ticket reste los sitios del tiicket y calcule el total en detalle.
  -- Trigger para retar los sitios:
  -- DELIMITER $$
  -- CREATE OR REPLACE TRIGGER sitios_menos AFTER INSERT ON detalle
  -- FOR EACH ROW
  -- BEGIN
  -- UPDATE ticket SET sitios= sitios - NEW.cantidad WHERE id_ticket = NEW.id_ticket;
  -- END$$
  -- Trigger para calcular el total (precio*cantidad):
  -- DELIMITER $$
  -- CREATE OR REPLACE TRIGGER total_v BEFORE INSERT ON detalle
  -- FOR EACH ROW
  -- BEGIN
  --  SET NEW.total = (SELECT (t.precio*NEW.cantidad) FROM ticket as t WHERE t.id_ticket = NEW.id_ticket);
  -- END$$