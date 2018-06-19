use Licores
go

-- Verificar Usuario
CREATE PROCEDURE verificarUsuario (@Cedula int, @Contrasenna varchar(10), @tipo_Usuario numeric(2))
AS
BEGIN
	select top (1) cedula from usuario where cedula=@Cedula and contrasenna=@Contrasenna and ID_Nivel=@tipo_Usuario
END
GO

-- Seleccionar tipos de usuario
CREATE PROCEDURE obtenerTiposUsuario 
AS
BEGIN
	select ID, nombre from Nivel
END
GO

-- Registrar usuario nuevo
CREATE PROCEDURE registrarUsuario (@Cedula int, @Contrasenna varchar(10), @Foto varbinary(max), @Nombre varchar(20), @Apellido1 varchar(20), @Apellido2 varchar(20), @Celular int, @Telefono int, @ID_Nivel int, @ID_Sucursal int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	set @existe=null
	select @existe=cedula from usuario where cedula=@Cedula

	BEGIN TRY
		BEGIN
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
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante el registro del usuario',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
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
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	set @existe=null
	select @existe=count(id) from catalogo where id=@id

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
				update Catalogo set precio=@precio where id=@id
				select 1			  
			end
			else				
			begin
				select 0
			end
		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion del catalogo',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN
	
	
END
GO

-- Registrar nuevo producto
CREATE PROCEDURE insertarProducto (@id_annejado int, @ID_procedencia int, @nombre varchar(20), @anno_cosecha numeric(4), @precio money, @foto varbinary(max))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from catalogo where id_annejado=@id_annejado and ID_procedencia=@ID_procedencia and Upper(nombre)=Upper(@nombre) and annocosecha=@anno_cosecha	

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
				insert into catalogo values (@id_annejado, @ID_procedencia, @nombre, @anno_cosecha, @precio, @foto)
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Agregar foto producto
CREATE PROCEDURE agregarFotoProducto (@ID_Producto int, @foto varbinary(max))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from catalogo where ID=@ID_Producto

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
			  update catalogo set foto=@foto
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
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
CREATE PROCEDURE ventasX_TipoPago_Sucursal_Fechas (@ID_Pago int, @ID_sucursal int, @Nombre_sucursal varchar(20),@Fecha_ini datetime, @Fecha_Fin datetime)
AS
BEGIN
	select V.ID, V.Cant_licores, V.total_items, V.Impuesto_venta, V.Fecha_compra, V.Monto_Total, MP.Nombre
	from Venta V join Metodo_Pago MP on V.ID_Metodo_Pago=MP.ID
		join Sucursal S on V.ID_Sucursal=S.ID
	where MP.ID=ISNULL(@ID_Pago,MP.ID) and S.ID=isnull(@ID_sucursal, S.ID) and S.Nombre like '%'+isnull(@Nombre_sucursal, S.Nombre)+'%' and V.Fecha_Compra between isnull(@Fecha_ini,V.Fecha_Compra) and isnull(@Fecha_Fin,V.Fecha_Compra)
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


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
---------------------------------------------- Usuario Consulta ------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------



-- Consulta producto
CREATE PROCEDURE consultaProductos (@ID_Sucursal int, @ID_producto int, @Nombre_Producto varchar(20))
AS
BEGIN
	declare @ubicacionActual geometry
	Select @ubicacionActual=Ubicacion from Sucursal where ID=@ID_Sucursal

	select C.ID, C.Nombre, C.Precio, C.Foto, S.Nombre As Sucursal, S.Ubicacion.STDistance(@ubicacionActual), I.Cantidad
	from Catalogo C join Inventario I on C.ID=I.ID_Catalogo
			join Sucursal S on I.ID_Sucursal=S.ID
	where C.ID=isnull(@ID_producto,C.ID) and C.Nombre like '%'+isnull(@Nombre_Producto,C.Nombre)+'%'
END
GO

-- Consulta horario
CREATE PROCEDURE consultaHorarioSucursal (@ID_Sucursal int)
AS
BEGIN
	select H.Entrada, H.Salida, H.Dias
	from Sucursal S join Horario H on S.ID_Horario=H.ID			
	where S.ID=@ID_Sucursal
END
GO

-- Consulta Empleados
CREATE PROCEDURE consultaEmpleadosSucursal (@ID_Sucursal int)
AS
BEGIN
	select U.Cedula, N.Nombre, N.Apellido1, N.Apellido2, T.Celular, T.Telefono--, U.Foto
	from Usuario U join Nombre N on U.ID_Nombre=N.ID
			join Telefono T on U.ID_Telefono=T.ID
	where U.ID_Sucursal=@ID_Sucursal
END
GO


-- Consultas existencias por licor y tienda
CREATE PROCEDURE consultaLicor_Tienda (@ID_Licor int, @Nombre_Licor varchar(20), @ID_Sucursal int, @Nombre_Sucursal varchar(20))
AS
BEGIN
	select C.ID,C.Nombre, LP.Pais, C.AnnoCosecha, TA.Nombre as TipoAnnejado, C.Precio, C.Foto, I.Cantidad, S.Nombre as Sucursal
	from Catalogo C join Lugar_Procedencia LP on C.ID_Procedencia=LP.ID
			join Tipo_Annejado TA on C.ID_Annejado=TA.ID
			join Inventario I on C.ID=I.ID_Catalogo
			join Sucursal S on I.ID_Sucursal=S.ID
	where C.ID=isnull(@ID_Licor,C.ID) and C.nombre like '%'+isnull(@Nombre_Licor,C.nombre)+'%' and S.ID=isnull(@ID_Sucursal,S.ID) and S.nombre like '%'+isnull(@Nombre_Sucursal,S.nombre)+'%'
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

-- Obtener tipos de pago
CREATE PROCEDURE obtenerTiposPago 
AS
BEGIN
	select ID, Nombre from Metodo_Pago
END
GO

-- Guarda los licores comprados previo a la creacion de la factura
CREATE PROCEDURE registrarCatalogo_Venta (@Identificacion_Cliente int, @ID_Catalogo int, @Cantidad int, @Subtotal money)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	BEGIN TRY
		BEGIN
			Insert into Catalogo_Venta (ID_Catalogo,Cantidad,Subtotal) values (@ID_Catalogo,@Cantidad,@Subtotal)
			Insert into Temp_IDs_Catalogo_Venta values (scope_identity(),@Identificacion_Cliente)
		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante el registro de los productos para la factura',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Realiza la facturacion
CREATE PROCEDURE facturar (@ID_Usuario int, @ID_Sucursal int, @Cantidad_Licores int, @Total_Items int, @Monto_Total money, @Identificacion_Cliente int, @ID_Metodo_Pago int)
AS
Begin
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @acumulado int	
	select @acumulado=sum(Monto_Total) from Venta where datepart(month,Fecha_Compra)=datepart(month,getdate())
	declare @id_descuento int, @descuento float
	select @id_descuento=ID, @descuento=descuento from Descuento where monto_mensual <= @acumulado order by monto_mensual desc

	BEGIN TRY
		BEGIN
		--Inserta factura
			Insert into Venta (ID_Usuario,ID_Sucursal,ID_descuento,ID_Metodo_Pago,Cant_Licores,Total_Items,Impuesto_Venta,Fecha_Compra,Identificacion_Cliente,Monto_Total)
			   values (@ID_Usuario,@ID_Sucursal,@id_descuento,@ID_Metodo_Pago,@Cantidad_Licores,@Total_Items,
						case 
							when @ID_Metodo_Pago = 1 then 0.10
							else 0
						end,							
						getdate(),@Identificacion_Cliente,@Monto_Total)

			--Recupera el id de la ultima insercion de las ventas
			declare @ID_Venta int
			set @ID_Venta=SCOPE_IDENTITY()
			declare @salir int
			set @salir=0	
			declare @ID_CV int

			--Relaciona los productos comprados en la tabla Catalogo_venta con la factura (tabla Venta) insertada
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
					--Sale cuando ya no hay mas productos que relacionar con la factura
					set @salir=1
				end
			end
		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante el registro de la factura',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH
	COMMIT TRANSACTION
	RETURN	
END
GO






--------------- CRUD Licores sucursal ---------------

-- Insertar licor en sucursal
CREATE PROCEDURE agregarLicorSucursal (@ID_Producto int, @ID_Sucursal int, @Cantidad int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Invetario where ID_Catalogo=@ID_Producto and ID_Sucursal=@ID_Sucursal

	declare @existe_ID_Catalogo int, @existe_ID_Sucursal int
	select @existe_ID_Catalogo=id from CATALOGO where ID=@ID_Producto
	select @existe_ID_Sucursal=id from SUCURSAL where ID=@ID_Sucursal

	BEGIN TRY
		BEGIN
			if((Len(@existe)<1) or (@existe is null)) and ((Len(@existe_ID_Catalogo)>0) or (@existe_ID_Catalogo is not null)) and ((Len(@existe_ID_Sucursal)>0) or (@existe_ID_Sucursal is not null))
			begin
			insert into Inventario values (@ID_Producto,@ID_Sucursal,@Cantidad)
				select 1			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion del licor en la sucursal',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar licor en sucursal
CREATE PROCEDURE actualizarLicorSucursal (@ID_Producto int, @ID_Sucursal int, @Cantidad int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Invetario where ID_Catalogo=@ID_Producto and ID_Sucursal=@ID_Sucursal

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
				update Inventario set Cantidad=@Cantidad where ID_Catalogo=@ID_Producto and ID_Sucursal=@ID_Sucursal
				select 1			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion de la cantidad del licor',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar producto
CREATE PROCEDURE eliminarLicorSucursal (@ID_Producto int, @ID_Sucursal int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Invetario where ID_Catalogo=@ID_Producto and ID_Sucursal=@ID_Sucursal

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			  delete Inventario where ID_Catalogo=@ID_Producto and ID_Sucursal=@ID_Sucursal
				select 1
			end
			else
			begin
				select 0				
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion licor en la sucursal',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar productos Sucursal
CREATE PROCEDURE seleccionarLicorSucursal (@ID_Producto int, @ID_Sucursal int)
AS
BEGIN
	select C.Nombre, C.AnnoCosecha, TA.Nombre as Annejado, LP.Pais as LugarProcedencia, I.Cantidad, S.Nombre as Sucursal, C.Precio, C.Foto
	from Inventario I join Catalogo C on I.ID_Catalogo=C.ID
		join Lugar_Procedencia LP on C.ID_Procedencia=LP.ID
		join Tipo_Annejado TA on C.ID_Annejado=TA.ID
		join Sucursal S on S.ID=I.ID_Sucursal
	where I.ID_Catalogo=isnull(@ID_Producto,ID_Catalogo) and I.ID_Sucursal=isnull(@ID_Sucursal,ID_Sucursal)
END
GO


--------------- CRUD Procedencia ---------------

-- Insertar lugar de procedencia
CREATE PROCEDURE agregarLugarProcedencia (@Nombre_Pais varchar(25))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Lugar_Procedencia where Upper(Pais)=Upper(@Nombre_Pais)

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
				insert into Lugar_Procedencia values (@Nombre_Pais)
				select 1			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion del lugar de procedencia',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar lugar de procedencia
CREATE PROCEDURE actualizarLugarProcedencia (@ID_Lugar int, @Nombre_Pais varchar(25))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Lugar_Procedencia where ID=@ID_Lugar

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update Lugar_Procedencia set Pais=@Nombre_Pais where ID=@ID_Lugar
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion del lugar de procedencia',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar lugar de procedencia
CREATE PROCEDURE eliminarLugarProcedencia (@ID_Procedencia int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Lugar_Procedencia where id=@ID_Procedencia

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			delete Lugar_Procedencia where id=@ID_Procedencia
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion del lugar de procedencia',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar Lugar Procedencia
CREATE PROCEDURE seleccionarLugarProcedencia (@ID_Lugar int, @Nombre_lugar varchar(25))
AS
BEGIN
	select ID, Pais from LUGAR_PROCEDENCIA where ID=isnull(@ID_Lugar,ID) and Pais like '%'+isnull(@Nombre_lugar,Pais)+'%'
END
GO

--------------- CRUD Tipo annejado ---------------

-- Insertar tipo annejado
CREATE PROCEDURE agregarTipoAnnejado (@Nombre_Annejado varchar(20), @Descripcion varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from TIPO_ANNEJADO where Upper(Nombre)=Upper(@Nombre_Annejado)

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
			insert into TIPO_ANNEJADO values (@Nombre_Annejado,@Descripcion)
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion del tipo de annejado',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar tipo annejado 
CREATE PROCEDURE actualizarTipoAnnejado (@ID_Annejado int, @Nombre_Annejado varchar(20), @Descripcion varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from TIPO_ANNEJADO where ID=@ID_Annejado

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update TIPO_ANNEJADO set Nombre=@Nombre_Annejado, Descripcion=@Descripcion where ID=@ID_Annejado
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion del tipo de annejado',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar tipo de annejado
CREATE PROCEDURE eliminarTipoAnnejado (@ID_Annejado int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from TIPO_ANNEJADO where id=@ID_Annejado

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			delete TIPO_ANNEJADO where id=@ID_Annejado
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion del tipo de annejado',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar Tipo de annejado
CREATE PROCEDURE seleccionarTipoAnnejado (@ID_Annejado int, @Nombre_Annejado varchar(25))
AS
BEGIN
	select ID, Nombre, Descripcion from Tipo_Annejado where ID=isnull(@ID_Annejado,ID) and Nombre like '%'+isnull(@Nombre_Annejado,Nombre)+'%'
END
GO



--------------- Datos de tiendas, nombre, direccion, ubicacion, horario ---------------

-- Insertar Sucursal
CREATE PROCEDURE agregarSucursal (@Id_Horario int, @ID_Direccion int, @nombre varchar(20), @ubicacion varchar(20))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Sucursal where ID_Direccion=@ID_Direccion and Upper(nombre)=Upper(@nombre) and ubicacion.STEquals(geometry::STGeomFromText(@ubicacion, 0))=1

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			insert into SUCURSAL values (@Id_Horario,@ID_Direccion,@nombre,@ubicacion)
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion de la sucursal',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar Sucursal
CREATE PROCEDURE actualizarSucursal (@ID_Sucursal int, @Id_Horario int, @ID_Direccion int, @nombre varchar(20), @ubicacion varchar(20))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Sucursal where id=@ID_Sucursal

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update Sucursal set Id_Horario=isnull(@Id_Horario,ID_HORARIO), ID_Direccion=isnull(@ID_Direccion,ID_Direccion), nombre=isnull(@nombre,NOMBRE), ubicacion=isnull(geometry::STGeomFromText(@ubicacion, 0),@ubicacion)  
				where ID=@ID_Sucursal
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion de la sucursal',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar sucursal
CREATE PROCEDURE eliminarSucursal (@ID_Sucursal int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Sucursal where id=@ID_Sucursal

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			delete Sucursal where id=@ID_Sucursal
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion de la sucursal',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar sucursal
CREATE PROCEDURE seleccionarSucursal (@ID_Sucursal int, @Nombre_Sucursal varchar(25))
AS
BEGIN
	select S.ID, S.NOMBRE,H.ENTRADA as Hora_Entrada, H.SALIDA as Hora_Salida, H.DIAS, D.PAIS, D.PROVINCIA, D.CANTON, D.DETALLE
	from SUCURSAL S join Horario H on S.ID_HORARIO=H.ID
		join Direccion D on D.ID=S.ID_DIRECCION
	where S.ID=isnull(@ID_Sucursal,S.ID) and S.Nombre like '%'+isnull(@Nombre_Sucursal,S.Nombre)+'%'
END
GO

---- CRUD Horario

-- Insertar Horario
CREATE PROCEDURE agregarHorario (@Entrada time, @Salida time, @Dias varchar(16))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Horario where Entrada=@Entrada and Salida=@Salida and Upper(Dias)=Upper(@Dias)

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
			insert into Horario values (@Entrada,@Salida,@Dias)
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion del horario',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar Horario
CREATE PROCEDURE actualizarHorario (@ID_Horario int, @Entrada time, @Salida time, @Dias varchar(16))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from HORARIO where id=@ID_Horario

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update HORARIO set Entrada=isnull(@Entrada,Entrada), Salida=isnull(@Salida,Salida), Dias=isnull(@Dias,Dias)
				where ID=@ID_Horario
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion del horario',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar horario
CREATE PROCEDURE eliminarHorario (@ID_Horario int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Horario where id=@ID_Horario

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
				delete Horario where id=@ID_Horario
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion del horario',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar horario
CREATE PROCEDURE seleccionarHorario (@ID_Horario int)
AS
BEGIN
	select ID,ENTRADA,SALIDA,DIAS
	from Horario
	where ID=isnull(@ID_Horario,ID)
END
GO



---- CRUD Direccion

-- Insertar Direccion
CREATE PROCEDURE agregarDireccion (@Pais varchar(25), @Provincia varchar(25), @Canton varchar(25), @Detalle varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Direccion where Upper(Pais)=Upper(@Pais) and Upper(Provincia)=Upper(@Provincia) and Upper(Canton)=Upper(@Canton) and Upper(Detalle)=Upper(@Detalle)

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
			  insert into Direccion values (@Pais,@Provincia,@Canton,@Detalle)
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion de la direccion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar Direccion
CREATE PROCEDURE actualizarDireccion(@ID_Direccion int, @Pais varchar(25), @Provincia varchar(25), @Canton varchar(25), @Detalle varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from DIRECCION where id=@ID_Direccion

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update DIRECCION set Pais=isnull(@Pais,Pais), Provincia=isnull(@Provincia,Provincia), Canton=isnull(@Canton,Canton), Detalle=isnull(@Detalle,Detalle)
				where ID=@ID_Direccion
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion de la direccion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar Direccion
CREATE PROCEDURE eliminarDireccion (@ID_Direccion int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from Direccion where id=@ID_Direccion

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
				delete Direccion where id=@ID_Direccion
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion de la direccion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar Direccion
CREATE PROCEDURE seleccionarDireccion (@ID_Direccion int)
AS
BEGIN
	select ID,Pais,PROVINCIA,CANTON,DETALLE
	from Direccion
	where ID=isnull(@ID_Direccion,ID)
END
GO



-- Actualizacion año licores (el resto del crud se realiza junto con el de productos)
CREATE PROCEDURE actualizarAnnoLicores (@ID_Catalogo int, @Anno numeric(4))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from CATALOGO where id=@ID_Catalogo

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
				update CATALOGO set ANNOCOSECHA=@Anno
				where ID=@ID_Catalogo
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion del anno del licor',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO


-- Actualizacion precio (el resto del crud se realiza junto con el de productos)
CREATE PROCEDURE actualizarPrecioLicores (@ID_Catalogo int, @Precio money)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from CATALOGO where id=@ID_Catalogo

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update CATALOGO set PRECIO=@Precio
				where ID=@ID_Catalogo
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion del precio del licor',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO


--------------- CRUD Combinacion ---------------

-- Insertar combinacion
CREATE PROCEDURE agregarCombinacion (@Nombre_Producto varchar(35), @Descripcion varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from COMBINACION where Upper(PRODUCTO)=Upper(@Nombre_Producto)

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
			insert into COMBINACION values (@Nombre_Producto,@Descripcion)
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion de la combinacion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar combinacion 
CREATE PROCEDURE actualizarCombinacion (@ID_Combinacion int, @Nombre_Producto varchar(35), @Descripcion varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from COMBINACION where ID=@ID_Combinacion

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update COMBINACION set PRODUCTO=@Nombre_Producto, Descripcion=@Descripcion where ID=@ID_Combinacion
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion de la combinacion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar COMBINACION
CREATE PROCEDURE eliminarCombinacion (@ID_Combinacion int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from COMBINACION where id=@ID_Combinacion

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			delete COMBINACION where id=@ID_Combinacion
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion de la combinacion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar Combinacion
CREATE PROCEDURE seleccionarCombinacion (@ID_Combinacion int, @Nombre_Producto varchar(25))
AS
BEGIN
	select ID, Producto, Descripcion from COMBINACION where ID=isnull(@ID_Combinacion,ID) and PRODUCTO like '%'+isnull(@Nombre_Producto,PRODUCTO)+'%'
END
GO


--------------- CRUD Empleados ---------------
/*
-- Insertar empleado
CREATE PROCEDURE agregarUsuario (@Nombre_Producto varchar(35), @Descripcion varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from COMBINACION where Upper(PRODUCTO)=Upper(@Nombre_Producto)

	BEGIN TRY
		BEGIN
			if(Len(@existe)<1) or (@existe is null)
			begin
			insert into COMBINACION values (@Nombre_Producto,@Descripcion)
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la insercion de la combinacion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Actualizar combinacion 
CREATE PROCEDURE actualizarCombinacion (@ID_Combinacion int, @Nombre_Producto varchar(35), @Descripcion varchar(200))
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from COMBINACION where ID=@ID_Combinacion

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			update COMBINACION set PRODUCTO=@Nombre_Producto, Descripcion=@Descripcion where ID=@ID_Combinacion
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la actualizacion de la combinacion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Eliminar COMBINACION
CREATE PROCEDURE eliminarCombinacion (@ID_Combinacion int)
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION BeforeInsert;

	declare @existe int
	select @existe=id from COMBINACION where id=@ID_Combinacion

	BEGIN TRY
		BEGIN
			if(Len(@existe)>0) or (@existe is not null)
			begin
			delete COMBINACION where id=@ID_Combinacion
				select 1
			  
			end
			else
			begin
				select 0
			end

		END
	END TRY
	BEGIN CATCH
		BEGIN
			raiserror('Ha ocurrido un problema durante la eliminacion de la combinacion',1,1)
			ROLLBACK TRANSACTION BeforeInsert;
		END
	END CATCH

	COMMIT TRANSACTION
	RETURN	
END
GO

-- Seleccionar Combinacion
CREATE PROCEDURE seleccionarCombinacion (@ID_Combinacion int, @Nombre_Producto varchar(25))
AS
BEGIN
	select ID, Producto, Descripcion from COMBINACION where ID=isnull(@ID_Combinacion,ID) and PRODUCTO like '%'+isnull(@Nombre_Producto,PRODUCTO)+'%'
END


*/