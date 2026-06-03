USE gimnasio;

-- Salas
INSERT INTO salas VALUES
(NULL, 'Sala Fitness', 'Zona de entrenamiento con pesas y máquinas', 40),
(NULL, 'Sala Spinnging', 'Sala equipada con bicicletas estáticas', 25),
(NULL, 'Sala Yoga', 'Espacio para clases de yoga y pilates', 20);

-- Entrenadores
INSERT INTO entrenadores VALUES
(NULL, 'Carlos', 'Martínez López', 'carlos_gym@gmail.com', '600123456', 'Musculación'),
(NULL, 'Laura', 'Gómez Ruiz', 'laura_gym@gmail.com', '600234567', 'Yoga'),
(NULL, 'David', 'Sánchez Pérez', 'david_gym@gmail.com', '615239468', 'Spinning');

-- Socios
INSERT INTO socios VALUES
(NULL, 'Ana', 'López García', '63957482P', 'ana@gmail.com', '612458965', 'mensual', TRUE),
(NULL, 'Javier', 'Ruiz Torres', '96452136L', 'javier@gmail.com', '659326112', 'trimestral', TRUE),
(NULL, 'Marta', 'Sanchez Díaz', '63259996D', 'marta@gmail.com', '648552369', 'anual', TRUE),
(NULL, 'Luis', 'Fernández Romero', '23584695M', 'luis@gmail.com', '645775321', 'mensual', TRUE),
(NULL, 'Elena', 'Morales Pérez', '45698551H', 'elena@gmail.com', '633524995', 'mensual', TRUE);

-- Clases
INSERT INTO clases VALUES
(NULL, 'Spinning Avanzado', 'Lunes 18:00', 25, 3, 2),
(NULL, 'Yoga Relajante', 'Martes 17:00', 20, 2, 3),
(NULL, 'Entrenamiento Funcional', 'Miercoles 19:00', 30, 1, 1),
(NULL, 'Spinning Básico', '', 20, 3, 2);

-- Máquinas
INSERT INTO maquinas VALUES
(NULL, 'Cinta de correr', 'Entrenamiento cardiovascular', 1),
(NULL, 'Prensa de piernas', 'Trabajo de tren inferior', 1),
(NULL, 'Bicicleta estática', 'Cardio de bajo impacto', 1),
(NULL, 'Esterillas', 'Material para yoga y estiramientos', 3);

-- Inscripciones
INSERT INTO inscripciones VALUES
(NULL, '2025-09-01', NULL, 'Alta mensual', 1),
(NULL, '2025-09-01', NULL, 'Alta trimestral', 2),
(NULL, '2025-09-01', NULL, 'Alta anual', 3),
(NULL, '2025-09-01', '2025-12-01', 'Baja voluntaria', 4),
(NULL, '2025-09-10', NULL, 'Nueva inscripción mensual', 5);

-- Pagos
INSERT INTO pagos VALUES
(NULL, '2025-09-01', 35.00, 'tarjeta', 'pagado', 1),
(NULL, '2025-09-01', 35.00, 'transferencia', 'pagado', 2),
(NULL, '2025-09-01', 35.00, 'tarjeta', 'pagado', 3),
(NULL, '2025-10-01', 35.00, 'efectivo', 'pendiente', 1),
(NULL, '2025-09-01', 35.00, 'tarjeta', 'pagado', 5);

-- Socios_clases
INSERT INTO socios_clases VALUES
(1, 1, '2025-09-05', 'asistio', NULL, TRUE),
(2, 2, '2025-09-06', 'asistio', NULL, TRUE),
(3, 1, '2025-09-07', 'no_asistio', NULL, TRUE),
(1, 3, '2025-09-08', 'asistio', NULL, TRUE),
(5, 2, '2025-09-12', NULL, NULL, TRUE);