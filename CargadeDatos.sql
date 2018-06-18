-- Carga de datos

-- Horario
insert into Horario values(PARSE('7:00:00' AS time USING 'en-US'),PARSE('5:00:00' AS time USING 'en-US'),'L-V')

-- Sucursal
insert into Sucursal values (1,'SucursalPrueba','POINT (1 1)')

-- Tipos Usuario
insert into Nivel values (1,'Administrador','Administra los datos de la aplicación puede insertar'),
							(2,'Consulta','Puede realizar ciertas consulta de los datos, pero no puede modificar nada'),
							(3,'Facturador','Se encarga de realizar las ventas y registrar las facturas')

-- Usuarios
Execute registrarUsuario @Cedula=111, @Contrasenna='111', @Foto=null,@Nombre='Prueba',@Apellido1='Admin',@Apellido2='apellido2', @Celular=8888888,@Telefono=22222222,@ID_Nivel=1,@ID_Sucursal=1
Exec registrarUsuario @Cedula=222, @contrasenna='222', @Foto=null,@nombre='Prueba',@apellido1='Consulta',@apellido2='apellido2', @celular=8888888,@telefono=22222222,@id_nivel=2,@id_sucursal=1
Exec registrarUsuario @Cedula=333, @contrasenna='333', @Foto=null,@nombre='Prueba',@apellido1='Factura',@apellido2='apellido2', @celular=8888888,@telefono=22222222,@id_nivel=3,@id_sucursal=1

--Insert into Lugar_Procedencia values ()
