-- Carga de datos

-- Horario
insert into Horario values(PARSE('7:00:00' AS time USING 'en-US'),PARSE('5:00:00' AS time USING 'en-US'),'L-V')

-- Sucursal
insert into Sucursal values (1,'Heredia','POINT (10 5)'),
							(1,'San Jose','POINT (2 2)'),
							(1,'Cartago','POINT (8 -10)'),
							(1,'Limon','POINT (23 4)')

-- Tipos Usuario
insert into Nivel values (1,'Administrador','Administra los datos de la aplicación puede insertar'),
							(2,'Consulta','Puede realizar ciertas consulta de los datos, pero no puede modificar nada'),
							(3,'Facturador','Se encarga de realizar las ventas y registrar las facturas')

-- Usuarios
Execute registrarUsuario @Cedula=111, @Contrasenna='111', @Foto=null,@Nombre='AdminPrueba',@Apellido1='Admin',@Apellido2='apellido2', @Celular=8888888,@Telefono=22222222,@ID_Nivel=1,@ID_Sucursal=1
Exec registrarUsuario @Cedula=222, @contrasenna='222', @Foto=null,@nombre='ConsultaPrueba',@apellido1='Consulta',@apellido2='apellido2', @celular=8888888,@telefono=22222222,@id_nivel=2,@id_sucursal=1
Exec registrarUsuario @Cedula=333, @contrasenna='333', @Foto=null,@nombre='FacturaPrueba',@apellido1='Factura',@apellido2='apellido2', @celular=8888888,@telefono=22222222,@id_nivel=3,@id_sucursal=1

-- Lugares
Insert into Lugar_Procedencia values ('Italia'),
										('España'),
										('Alemania'),
										('Francia'),
										('Chile'),
										('Argentina'),
										('Estados Unidos')

-- Tipo Añejado
Insert into tipo_annejado values ('Joven','Llamado vin primeur en francés, es un vino con un máximo de seis meses de añejamiento en barrica. Está destinado a ser consumido en espacio de como máximo seis meses'),
									('Guarda','Son vinos con un mínimo de dos años de añejamiento, de los cuales al menos seis meses en barrica. Son aptos para ser conservados numerosos años.'),
									('Reserva','Son vinos con tres años de añejamiento, de los cuales al menos uno en madera.'),
									('Gran Reserva','Son vinos con al menos cinco años de añejamiento, de los cuales al menos dos en madera.'),
									('Ninguno','No posee ningún tipo de añejamiento')

-- Catalogo
Insert into Catalogo values (5,1,'Merlot', 2018, 7000, null),
							(1,3,'Cabernet Sauvignon', 2015, 16000, null),
							(6,4,'Malbec', 2012, 24000, null),
							(7,1,'Chardonnay', 2017, 5000, null),
							(4,1,'Sauvignon Blanc', 2018, 5500, null),
							(2,2,'Riesling', 2016, 6200, null)


-- Inventario
insert into inventario values (3,2,20),
								(3,4,25),
								(3,1,10),
								(3,6,30),
								(4,3,23),
								(4,5,18),
								(1,1,34),
								(1,3,6),
								(1,2,14),
								(4,6,29),
								(4,4,41)

-- Metodo de pago
insert into Metodo_Pago values ('Tarjeta'),
								('Efectivo')

-- Descuento
insert into Descuento values (0.05,20000,1),
								(0.10,60000,1),
								(0.15,120000,1),
								(0.20,200000,1),
								(0.30,260000,1),
								(0.45,550000,1)