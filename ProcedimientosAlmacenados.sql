-- Verificar Usuario
CREATE PROCEDURE verificarUsuario (@Cedula int, @Contrasenna varchar(10), @tipo_Usuario numeric(2))
AS
BEGIN
	select top (1) cedula from usuario where cedula=@Cedula and contrasenna=@Contrasenna and ID_Nivel=@tipo_Usuario
END
GO


-- Registrar usuario nuevo
CREATE PROCEDURE registrarUsuario (@Cedula int, @Contrasenna varchar(10), @Foto varbinary(max), @Nombre varchar(20), @Apellido1 varchar(20), @Apellido2 varchar(20), @Celular int, @Telefono int, @ID_Nivel int, @ID_Sucursal int)
AS
BEGIN
	declare @existe int
	set @existe=null
	select @existe=cedula from usuario where cedula=@Cedula

	if (Len(@existe)<1) or (@existe is null)
	begin
		declare @id_nombre int
		set @id_nombre=NULL
		select @id_nombre=id from Nombre where NOMBRE=@Nombre and Apellido1=@Apellido1 and APELLIDO2=@Apellido2

		declare @id_telefono int
		set @id_telefono=NULL
		select @id_telefono=id from TELEFONO where TELEFONO=@Telefono and CELULAR=@Celular
	
		if (@id_nombre is NULL) or (Len(@id_nombre)<1)
		begin
			insert into nombre values(@Cedula,@Nombre,@Apellido1,@Apellido2)
			set @id_nombre=@Cedula
		end
	
		if (@id_telefono is NULL) or (Len(@id_telefono)<1)
		begin
			insert into TELEFONO values (@Cedula,@Celular,@Telefono)
			set @id_telefono=@cedula
		end

		Insert into Usuario values(@cedula, @id_nombre, @id_telefono, @id_nivel,@ID_Sucursal,@Contrasenna,@Foto)
		select 1
	end
	else 
	begin
		select 0
	end
END
GO


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
---------------------------------------------- ADMINISTRADOR ---------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
-- Seleccionar precio de producto por nombre y/o id
CREATE PROCEDURE consultarPrecio (@nombre varchar(20), @id int)
AS
BEGIN
	if (Len(@nombre)<1) or (@nombre is null) and (Len(@id)<1) or (@id is null)
	begin
		select -1
	end
	else
	begin
		select precio from Catalogo where nombre=isnull(@nombre,nombre) and id=isnull(@id,id)
	end
END
GO

-- Actualizar precio producto
CREATE PROCEDURE actualizarPrecio (@id int, @precio money)
AS
BEGIN
	declare @existe int
	set @existe=null
	select @existe=count(id) from catalogo where id=@id

	if(Len(@existe)<1) or (@existe is null)
	begin
	  select 0
	end
	else
	begin
		update Catalogo set precio=@precio where id=@id
		select 1
	end
END
GO

-- Registrar nuevo producto
CREATE PROCEDURE insertarProducto (@id_annejado int, @ID_procedencia int, @nombre varchar(20), @anno_cosecha numeric(4), @precio money, @foto varbinary(max))
AS
BEGIN
	insert into catalogo values (@id_annejado, @ID_procedencia, @nombre, @anno_cosecha, @precio, @foto)
END
GO




-- Ventas por sucursal, licores y/o fechas
CREATE PROCEDURE ventasX_Sucursal_Licor_Fecha (@ID_sucursal int, @Nombre_sucursal varchar(20), @ID_Licor int, @Nombre_Licor varchar(20), @Fecha_ini datetime, @Fecha_Fin datetime)
AS
BEGIN
	select V.ID, V.Cant_licores, V.total_items, V.Impuesto_venta, V.Fecha_compra, V.Monto_Total, CV.Cantidad, CV.Subtotal   
	from Venta V join Catalogo_Venta CV on V.ID=CV.ID_Venta
		join Catalogo C on CV.ID_Catalogo=C.ID
		join Sucursal S on V.ID_Sucursal=S.ID
	where C.ID=isnull(@ID_Licor,C.ID) and C.Nombre like '%'+isnull(@Nombre_Licor,C.Nombre)+'%' and S.ID=isnull(@ID_sucursal, S.ID) and S.Nombre like '%'+isnull(@Nombre_sucursal, S.Nombre)+'%' and V.Fecha_Compra between isnull(@Fecha_ini,V.Fecha_Compra) and isnull(@Fecha_Fin,V.Fecha_Compra)
	group by V.ID, V.Cant_licores, V.total_items, V.Impuesto_venta, V.Fecha_compra, V.Monto_Total,CV.Cantidad,CV.Subtotal   
END 
GO

-- Ventas por Tipo de pago, sucursal y fechas
CREATE PROCEDURE ventasX_TipoPago_Sucursal_Fechas (@ID_Pago int, @Nombre varchar(15), @ID_sucursal int, @Nombre_sucursal varchar(20),@Fecha_ini datetime, @Fecha_Fin datetime)
AS
BEGIN
	select V.ID, V.Cant_licores, V.total_items, V.Impuesto_venta, V.Fecha_compra, V.Monto_Total, MP.Nombre
	from Venta V join Metodo_Pago MP on V.ID_Metodo_Pago=MP.ID
		join Sucursal S on V.ID_Sucursal=S.ID
	where MP.ID=ISNULL(@ID_Pago,MP.ID) and MP.Nombre like '%'+isnull(@Nombre,MP.Nombre)+'%' and S.ID=isnull(@ID_sucursal, S.ID) and S.Nombre like '%'+isnull(@Nombre_sucursal, S.Nombre)+'%' and V.Fecha_Compra between isnull(@Fecha_ini,V.Fecha_Compra) and isnull(@Fecha_Fin,V.Fecha_Compra)
END
GO


-- Productos mas vendidos
CREATE PROCEDURE productos_mas_vendidos (@ID_sucursal int, @Nombre_sucursal varchar(20))
AS
BEGIN
	Select top (15) C.ID, C.Nombre, C.Precio, CV.Cantidad
	from Catalogo_Venta CV join Catalogo C on CV.ID_Catalogo=C.ID
		 join Venta V on CV.ID_Venta=V.ID
		 join Sucursal S on V.ID_Sucursal=S.ID
	where S.ID=isnull(@ID_sucursal,S.ID) and S.Nombre like '%'+isnull(@Nombre_sucursal,S.Nombre)+'%'
	order by CV.Cantidad desc
END
GO


-- Productos no vendidos
CREATE PROCEDURE productos_no_vendidos (@ID_sucursal int, @Nombre_sucursal varchar(20))
AS
BEGIN
	Select C.ID, C.Nombre, C.Precio
	from Catalogo C join Inventario I on C.ID=I.ID_Catalogo
		 join Sucursal S on I.ID_Sucursal=S.ID		 
	where S.ID=isnull(@ID_sucursal,S.ID) and S.Nombre like '%'+isnull(@Nombre_sucursal,S.Nombre)+'%'
		  and not exists (select C1.ID, C1.Nombre, C1.Precio
							from Catalogo C1 join Catalogo_Ventas CV on C1.ID=CV.ID_Catalogo
								 join Venta V on CV.ID_Venta = V.ID
								 join Sucursal S1 on V.ID_Sucursal=S1.ID
								 where S1.ID=S.ID)
END
GO

/*
-------------------------------------------------------------------
-------------------------------------------------------------------
--Consultar producto por sucursal
CREATE PROCEDURE productosSucursal (@ID_sucursal int)
AS
BEGIN
	select  C.ID, C.Nombre, C.AnnoCosecha, C.Precio, C.Foto
	from inventario I join catalogo C on I.ID_Catalogo=C.ID
	where I.ID_Sucursal=isnull(@ID_sucursal, I.ID_Sucursal)
END
GO


--Consultar ventas por sucursal
CREATE PROCEDURE ventasSucursal (@ID_sucursal int, @Nombre_sucursal varchar(20),)
AS
BEGIN
	select ID, Cant_licores, total_items, Impuesto_venta, Fecha_compra, Monto_Total   
	from Venta V join Sucursal S on V.ID_Sucursal=S.ID
	where ID_Sucursal=isnull(@ID_sucursal, ID_Sucursal) and S.Nombre like '%'+isnull(@Nombre_sucursal, S.Nombre)+'%'
END
GO

-- Consultas por licores
CREATE PROCEDURE ventasLicores (@ID_Licor int, @Nombre_Licor varchar(20))
AS
BEGIN
	select V.ID, V.Cant_licores, V.total_items, V.Impuesto_venta, V.Fecha_compra, V.Monto_Total, CV.Cantidad, CV.Subtotal   
	from Venta V join Catalogo_Venta CV on V.ID=CV.ID_Venta
		join Catalogo C on CV.ID_Catalogo=C.ID
	where C.ID=isnull(@ID_Licor,C.ID) and C.Nombre like '%'+isnull(@Nombre_Licor,C.Nombre)+'%'
	group by V.ID, V.Cant_licores, V.total_items, V.Impuesto_venta, V.Fecha_compra, V.Monto_Total,CV.Cantidad,CV.Subtotal   
END 
GO

--Consultar ventas por fecha
CREATE PROCEDURE ventasFecha (@Fecha_ini datetime, @Fecha_Fin datetime)
AS
BEGIN
	select ID, Cant_licores, total_items, Impuesto_venta, Fecha_compra, Monto_Total   
	from Venta
	where and V.Fecha_Compra between isnull(@Fecha_ini,V.Fecha_Compra) and isnull(@Fecha_Fin,V.Fecha_Compra)
END
GO

--Consultar ventas por tipo de pago
CREATE PROCEDURE ventasTipoPago (@ID_Pago int, @Nombre varchar(15))
AS
BEGIN
	select V.ID, V.Cant_licores, V.total_items, V.Impuesto_venta, V.Fecha_compra, V.Monto_Total, MP.Nombre
	from Venta V join Metodo_Pago MP on V.ID_Metodo_Pago=MP.ID
	where MP.ID=ISNULL(@ID_Pago,MP.ID) and MP.Nombre like '%'+isnull(@Nombre,MP.Nombre)+'%'
END
GO
-------------------------------------------------------------------
-------------------------------------------------------------------
*/


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
---------------------------------------------- Usuario Consulta ------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

-- Consulta producto
CREATE PROCEDURE consultaProducto (@ID_Sucursal int, @ID_producto int, @Nombre_Producto varchar(20))
AS
BEGIN
	declare @ubicacionActual geometry
	Select @ubicacionActual=Ubicacion from Sucursal where ID=@ID_Sucursal

	select C.Nombre, C.Precio, C.Foto, S.Nombre, S.Ubicacion.STDistance(@ubicacionActual)
	from Catalogo C join Inventario I on C.ID=I.ID_Catalogo
			join Sucursal S on I.ID_Sucursal=S.ID
	where C.ID=isnull(@ID_producto,C.ID) and C.Nombre like '%'+isnull(@Nombre_Producto,C.Nombre)+'%'
END
GO

-- Consulta horario
CREATE PROCEDURE consultaHorario (@ID_Sucursal int)
AS
BEGIN
	select H.Entrada, H.Salida, H.Dias
	from Sucursal S join Horario H on S.ID_Horario=H.ID			
	where S.ID=@ID_Sucursal
END
GO

-- Consulta Empleados
CREATE PROCEDURE consultaEmpleados (@ID_Sucursal int)
AS
BEGIN
	select U.Cedula, N.Nombre, N.Apellido1, N.Apellido2, T.Celular, T.Telefono--, U.Foto
	from Usuario U join Nombre N on U.ID_Nombre=N.ID
			join Telefono T on U.ID_Telefono=T.ID
	where U.ID_Sucursal=@ID_Sucursal
END
GO


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
------------------------------------------------ Facturador ----------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

create table Temp_IDs_Catalogo_Venta(
	ID int Identity,
	ID_Catalogo_Venta int not null,
	Identificacion_Cliente int not null,
	primary key (ID))
go

-- Guarda los licores comprados previo a la creacion de la factura
CREATE PROCEDURE registrarCatalogo_Venta (@Identificacion_Cliente int, @ID_Catalogo int, @Cantidad int, @Subtotal money)
AS
BEGIN
	Insert into Catalogo_Venta (ID_Catalogo,Cantidad,Subtotal) values (@ID_Catalogo,@Cantidad,@Subtotal)
	Insert into Temp_IDs_Catalogo_Venta values (scope_identity(),@Identificacion_Cliente)
END
GO

-- Realiza la facturacion
CREATE PROCEDURE facturar (@ID_Usuario int, @ID_Sucursal int, @Cantidad_Licores int, @Total_Items int, @Monto_Total money, @Identificacion_Cliente int, @ID_Metodo_Pago int)
AS
BEGIN
	declare @acumulado int	
	select @acumulado=sum(Monto_Total) from Venta where datepart(month,Fecha_Compra)=datepart(month,getdate())

	declare @id_descuento int, @descuento float
	select @id_descuento=ID, @descuento=descuento from Descuento where monto_mensual <= @acumulado order by monto_mensual desc

	Insert into Venta (ID_Usuario,ID_Sucursal,ID_descuento,ID_Metodo_Pago,Cant_Licores,Total_Items,Impuesto_Venta,Fecha_Compra,Identificacion_Cliente,Monto_Total)
			   values (@ID_Usuario,@ID_Sucursal,@id_descuento,@ID_Metodo_Pago,@Cantidad_Licores,@Total_Items,
						case 
							when @ID_Metodo_Pago = 1 then 0.10
							else 0
						end,							
						getdate(),@Identificacion_Cliente,@Monto_Total)

	declare @ID_Venta int
	set @ID_Venta=SCOPE_IDENTITY()

	declare @salir int
	set @salir=0
	
	declare @ID_CV int

	While @salir=0
	begin
		
		select top (1) @ID_CV=ID_Catalogo_Venta from Temp_IDs_Catalogo_Venta where Identificacion_Cliente=@Identificacion_Cliente order by ID_Catalogo_Venta desc

		if (Len(@ID_CV)<1) or (@ID_CV is null)
		begin
			update Catalogo_Venta set ID_Venta=@ID_Venta where ID=@ID_CV
			delete Temp_IDs_Catalogo_Venta where ID_Catalogo_Venta=@ID_CV
		end
		else 
		begin
			set @salir=1
		end
	end
END
GO