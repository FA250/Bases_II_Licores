/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005                    */
/* Created on:     6/19/2018 2:46:44 PM                         */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CATALOGO') and o.name = 'FK_CATALOGO___LUGAR_PR')
alter table CATALOGO
   drop constraint FK_CATALOGO___LUGAR_PR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CATALOGO') and o.name = 'FK_CATALOGO___TIPO_ANN')
alter table CATALOGO
   drop constraint FK_CATALOGO___TIPO_ANN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CATALOGO_VENTA') and o.name = 'FK_CATALOGO___CATALOGO')
alter table CATALOGO_VENTA
   drop constraint FK_CATALOGO___CATALOGO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CATALOGO_VENTA') and o.name = 'FK_CATALOGO___VENTA')
alter table CATALOGO_VENTA
   drop constraint FK_CATALOGO___VENTA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMBINACION_CATALOGO') and o.name = 'FK_COMBINAC___CATALOGO')
alter table COMBINACION_CATALOGO
   drop constraint FK_COMBINAC___CATALOGO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMBINACION_CATALOGO') and o.name = 'FK_COMBINAC___COMBINAC')
alter table COMBINACION_CATALOGO
   drop constraint FK_COMBINAC___COMBINAC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMBINACION_CATALOGO') and o.name = 'FK_COMBINAC___TIPO_ANN')
alter table COMBINACION_CATALOGO
   drop constraint FK_COMBINAC___TIPO_ANN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('INVENTARIO') and o.name = 'FK_INVENTAR___CATALOGO')
alter table INVENTARIO
   drop constraint FK_INVENTAR___CATALOGO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('INVENTARIO') and o.name = 'FK_INVENTAR___SUCURSAL')
alter table INVENTARIO
   drop constraint FK_INVENTAR___SUCURSAL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SUCURSAL') and o.name = 'FK_SUCURSAL___DIRECCIO')
alter table SUCURSAL
   drop constraint FK_SUCURSAL___DIRECCIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SUCURSAL') and o.name = 'FK_SUCURSAL___HORARIO')
alter table SUCURSAL
   drop constraint FK_SUCURSAL___HORARIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USUARIO') and o.name = 'FK_USUARIO___NIVEL')
alter table USUARIO
   drop constraint FK_USUARIO___NIVEL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USUARIO') and o.name = 'FK_USUARIO___NOMBRE')
alter table USUARIO
   drop constraint FK_USUARIO___NOMBRE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USUARIO') and o.name = 'FK_USUARIO___SUCURSAL')
alter table USUARIO
   drop constraint FK_USUARIO___SUCURSAL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USUARIO') and o.name = 'FK_USUARIO___TELEFONO')
alter table USUARIO
   drop constraint FK_USUARIO___TELEFONO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VENTA') and o.name = 'FK_VENTA___DESCUENT')
alter table VENTA
   drop constraint FK_VENTA___DESCUENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VENTA') and o.name = 'FK_VENTA___METODO_P')
alter table VENTA
   drop constraint FK_VENTA___METODO_P
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VENTA') and o.name = 'FK_VENTA___SUCURSAL')
alter table VENTA
   drop constraint FK_VENTA___SUCURSAL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VENTA') and o.name = 'FK_VENTA___USUARIO')
alter table VENTA
   drop constraint FK_VENTA___USUARIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CATALOGO')
            and   type = 'U')
   drop table CATALOGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CATALOGO_VENTA')
            and   type = 'U')
   drop table CATALOGO_VENTA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMBINACION')
            and   type = 'U')
   drop table COMBINACION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMBINACION_CATALOGO')
            and   type = 'U')
   drop table COMBINACION_CATALOGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DESCUENTO')
            and   type = 'U')
   drop table DESCUENTO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIRECCION')
            and   type = 'U')
   drop table DIRECCION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('HORARIO')
            and   type = 'U')
   drop table HORARIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('INVENTARIO')
            and   type = 'U')
   drop table INVENTARIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LUGAR_PROCEDENCIA')
            and   type = 'U')
   drop table LUGAR_PROCEDENCIA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('METODO_PAGO')
            and   type = 'U')
   drop table METODO_PAGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NIVEL')
            and   type = 'U')
   drop table NIVEL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NOMBRE')
            and   type = 'U')
   drop table NOMBRE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SUCURSAL')
            and   type = 'U')
   drop table SUCURSAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TELEFONO')
            and   type = 'U')
   drop table TELEFONO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TIPO_ANNEJADO')
            and   type = 'U')
   drop table TIPO_ANNEJADO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USUARIO')
            and   type = 'U')
   drop table USUARIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VENTA')
            and   type = 'U')
   drop table VENTA
go

/*==============================================================*/
/* Table: CATALOGO                                              */
/*==============================================================*/
create table CATALOGO (
   ID                   int                  identity,
   ID_ANNEJADO          int                  null,
   ID_PROCEDENCIA       int                  null,
   NOMBRE               varchar(20)          null,
   ANNOCOSECHA          numeric(4)           null,
   PRECIO               money                null,
   FOTO                 varbinary(Max)       null,
   constraint PK_CATALOGO primary key (ID)
)
go

/*==============================================================*/
/* Table: CATALOGO_VENTA                                        */
/*==============================================================*/
create table CATALOGO_VENTA (
   ID                   int                  identity,
   ID_CATALOGO          int                  null,
   ID_VENTA             int                  null,
   CANTIDAD             int                  null,
   SUBTOTAL             money                null,
   constraint PK_CATALOGO_VENTA primary key (ID)
)
go

/*==============================================================*/
/* Table: COMBINACION                                           */
/*==============================================================*/
create table COMBINACION (
   ID                   int                  identity,
   PRODUCTO             varchar(35)          null,
   DESCRIPCION          varchar(200)         null,
   constraint PK_COMBINACION primary key (ID)
)
go

/*==============================================================*/
/* Table: COMBINACION_CATALOGO                                  */
/*==============================================================*/
create table COMBINACION_CATALOGO (
   ID                   int                  not null,
   ID_CATALOGO          int                  null,
   ID_COMBINACION       int                  null,
   constraint PK_COMBINACION_CATALOGO primary key (ID)
)
go

/*==============================================================*/
/* Table: DESCUENTO                                             */
/*==============================================================*/
create table DESCUENTO (
   ID                   int                  identity,
   DESCUENTO            float                null,
   MONTO_MENSUAL        money                null,
   ACTIVO               bit                  null,
   constraint PK_DESCUENTO primary key (ID)
)
go

/*==============================================================*/
/* Table: DIRECCION                                             */
/*==============================================================*/
create table DIRECCION (
   ID                   int                  identity,
   PAIS                 varchar(25)          null,
   PROVINCIA            varchar(25)          null,
   CANTON               varchar(25)          null,
   DETALLE              varchar(200)         null,
   constraint PK_DIRECCION primary key (ID)
)
go

/*==============================================================*/
/* Table: HORARIO                                               */
/*==============================================================*/
create table HORARIO (
   ID                   int                  identity,
   ENTRADA              time                 null,
   SALIDA               time                 null,
   DIAS                 varchar(16)          null,
   constraint PK_HORARIO primary key (ID)
)
go

/*==============================================================*/
/* Table: INVENTARIO                                            */
/*==============================================================*/
create table INVENTARIO (
   ID                   int                  identity,
   ID_CATALOGO          int                  null,
   ID_SUCURSAL          int                  null,
   CANTIDAD             int                  null,
   constraint PK_INVENTARIO primary key (ID)
)
go

/*==============================================================*/
/* Table: LUGAR_PROCEDENCIA                                     */
/*==============================================================*/
create table LUGAR_PROCEDENCIA (
   ID                   int                  identity,
   PAIS                 varchar(25)          null,
   constraint PK_LUGAR_PROCEDENCIA primary key (ID)
)
go

/*==============================================================*/
/* Table: METODO_PAGO                                           */
/*==============================================================*/
create table METODO_PAGO (
   ID                   int                  identity,
   NOMBRE               varchar(15)          null,
   constraint PK_METODO_PAGO primary key (ID)
)
go

/*==============================================================*/
/* Table: NIVEL                                                 */
/*==============================================================*/
create table NIVEL (
   ID                   numeric(2)           not null,
   NOMBRE               varchar(25)          null,
   DESCRIPCION          varchar(200)         null,
   constraint PK_NIVEL primary key (ID)
)
go

/*==============================================================*/
/* Table: NOMBRE                                                */
/*==============================================================*/
create table NOMBRE (
   ID                   int                  not null,
   NOMBRE               varchar(20)          null,
   APELLIDO1            varchar(20)          null,
   APELLIDO2            varchar(20)          null,
   constraint PK_NOMBRE primary key (ID)
)
go

/*==============================================================*/
/* Table: SUCURSAL                                              */
/*==============================================================*/
create table SUCURSAL (
   ID                   int                  identity,
   ID_HORARIO           int                  null,
   ID_DIRECCION         int                  null,
   NOMBRE               varchar(20)          null,
   UBICACION            geometry             null,
   constraint PK_SUCURSAL primary key (ID)
)
go

/*==============================================================*/
/* Table: TELEFONO                                              */
/*==============================================================*/
create table TELEFONO (
   ID                   int                  not null,
   CELULAR              int                  null,
   TELEFONO             int                  null,
   constraint PK_TELEFONO primary key (ID)
)
go

/*==============================================================*/
/* Table: TIPO_ANNEJADO                                         */
/*==============================================================*/
create table TIPO_ANNEJADO (
   ID                   int                  identity,
   NOMBRE               varchar(20)          null,
   DESCRIPCION          varchar(200)         null,
   constraint PK_TIPO_ANNEJADO primary key (ID)
)
go

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   CEDULA               int                  not null,
   ID_NOMBRE            int                  null,
   ID_TELEFONO          int                  null,
   ID_NIVEL             numeric(2)           null,
   ID_SUCURSAL          int                  null,
   CONTRASENNA          varchar(10)          null,
   FOTO                 varbinary(Max)       null,
   constraint PK_USUARIO primary key (CEDULA)
)
go

/*==============================================================*/
/* Table: VENTA                                                 */
/*==============================================================*/
create table VENTA (
   ID                   int                  identity,
   ID_USUARIO           int                  null,
   ID_SUCURSAL          int                  null,
   ID_DESCUENTO         int                  null,
   ID_METODO_PAGO       int                  null,
   CANT_LICORES         int                  null,
   TOTAL_ITEMS          int                  null,
   IMPUESTO_VENTA       float                null,
   FECHA_COMPRA         datetime             null,
   IDENTIFICACION_CLIENTE int                  null,
   MONTO_TOTAL          money                null,
   constraint PK_VENTA primary key (ID)
)
go

alter table CATALOGO
   add constraint FK_CATALOGO___LUGAR_PR foreign key (ID_PROCEDENCIA)
      references LUGAR_PROCEDENCIA (ID)
go

alter table CATALOGO
   add constraint FK_CATALOGO___TIPO_ANN foreign key (ID_ANNEJADO)
      references TIPO_ANNEJADO (ID)
go

alter table CATALOGO_VENTA
   add constraint FK_CATALOGO___CATALOGO foreign key (ID_CATALOGO)
      references CATALOGO (ID)
go

alter table CATALOGO_VENTA
   add constraint FK_CATALOGO___VENTA foreign key (ID_VENTA)
      references VENTA (ID)
go

alter table COMBINACION_CATALOGO
   add constraint FK_COMBINAC___CATALOGO foreign key (ID_CATALOGO)
      references CATALOGO (ID)
go

alter table COMBINACION_CATALOGO
   add constraint FK_COMBINAC___COMBINAC foreign key (ID_COMBINACION)
      references COMBINACION (ID)
go

alter table COMBINACION_CATALOGO
   add constraint FK_COMBINAC___TIPO_ANN foreign key (ID_CATALOGO)
      references TIPO_ANNEJADO (ID)
go

alter table INVENTARIO
   add constraint FK_INVENTAR___CATALOGO foreign key (ID_CATALOGO)
      references CATALOGO (ID)
go

alter table INVENTARIO
   add constraint FK_INVENTAR___SUCURSAL foreign key (ID_SUCURSAL)
      references SUCURSAL (ID)
go

alter table SUCURSAL
   add constraint FK_SUCURSAL___DIRECCIO foreign key (ID_DIRECCION)
      references DIRECCION (ID)
go

alter table SUCURSAL
   add constraint FK_SUCURSAL___HORARIO foreign key (ID_HORARIO)
      references HORARIO (ID)
go

alter table USUARIO
   add constraint FK_USUARIO___NIVEL foreign key (ID_NIVEL)
      references NIVEL (ID)
go

alter table USUARIO
   add constraint FK_USUARIO___NOMBRE foreign key (ID_NOMBRE)
      references NOMBRE (ID)
go

alter table USUARIO
   add constraint FK_USUARIO___SUCURSAL foreign key (ID_SUCURSAL)
      references SUCURSAL (ID)
go

alter table USUARIO
   add constraint FK_USUARIO___TELEFONO foreign key (ID_TELEFONO)
      references TELEFONO (ID)
go

alter table VENTA
   add constraint FK_VENTA___DESCUENT foreign key (ID_DESCUENTO)
      references DESCUENTO (ID)
go

alter table VENTA
   add constraint FK_VENTA___METODO_P foreign key (ID_METODO_PAGO)
      references METODO_PAGO (ID)
go

alter table VENTA
   add constraint FK_VENTA___SUCURSAL foreign key (ID_SUCURSAL)
      references SUCURSAL (ID)
go

alter table VENTA
   add constraint FK_VENTA___USUARIO foreign key (ID_USUARIO)
      references USUARIO (CEDULA)
go

