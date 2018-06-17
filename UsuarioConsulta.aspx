﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioConsulta.aspx.cs" Inherits="LicoreraWeb.UsuarioConsulta" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="z-index: 1; left: 10px; top: 15px; position: absolute; height: 616px; width: 1152px">
    
        <br />
        <asp:Label ID="label_ingreseIDSucursal" runat="server" style="z-index: 1; left: 517px; top: 127px; position: absolute; width: 241px" Text="Ingrese el ID de sucursal"></asp:Label>
        <br />
        <asp:Label ID="label_consultaHorario" runat="server" style="z-index: 1; left: 512px; top: 94px; position: absolute" Text="Consulta de Horario de Sucursal"></asp:Label>
        <asp:Button ID="button_consultarHorario" runat="server" style="z-index: 1; left: 516px; top: 207px; position: absolute; width: 253px" Text="Consultar Horario" />
        <br />
        <br />
        <asp:Label ID="label_consultarProducto" runat="server" style="z-index: 1; left: 140px; top: 92px; position: absolute; width: 234px" Text="Consulta de Producto"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_ingreseNombreProducto" runat="server" style="z-index: 1; left: 137px; top: 126px; position: absolute" Text="Ingrese el nombre del Producto"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_nombreProducto" runat="server" style="z-index: 1; left: 142px; top: 165px; position: absolute"></asp:TextBox>
        <br />
        <asp:TextBox ID="textbox_idSucursal" runat="server" style="z-index: 1; left: 518px; top: 163px; position: absolute; width: 250px"></asp:TextBox>
        <br />
        <asp:Label ID="label_precio" runat="server" style="z-index: 1; left: 135px; top: 212px; position: absolute; width: 177px; height: 26px" Text="Precio del Producto"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_precioConsultado" runat="server" style="z-index: 1; left: 132px; top: 257px; position: absolute"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_sucursales" runat="server" style="z-index: 1; left: 130px; top: 303px; position: absolute" Text="Disponible en las siguientes sucursales:"></asp:Label>
        <asp:Table ID="table_horarios" runat="server" style="z-index: 1; left: 520px; top: 273px; position: absolute; height: 28px; width: 238px">
        </asp:Table>
        <br />
        <br />
        <br />
        <asp:DropDownList ID="dropdownlist_sucursales" runat="server" style="z-index: 1; left: 134px; top: 351px; position: absolute">
        </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Label ID="label_fotoProducto" runat="server" style="z-index: 1; left: 133px; top: 410px; position: absolute" Text="Fotografía del Producto:"></asp:Label>
        <br />
        <br />
        <asp:Image ID="image_fotoProducto" runat="server" style="z-index: 1; left: 217px; top: 465px; position: absolute" />
        <br />
        <br />
        <br />
        <asp:Button ID="button_consultarProducto" runat="server" style="z-index: 1; left: 125px; top: 517px; position: absolute; margin-top: 4px" Text="Consultar Producto" />
        <br />
        <br />
        <br />
        <asp:Button ID="button_volver" runat="server" OnClick="button_volver_Click" style="z-index: 1; left: 3px; top: 582px; position: absolute" Text="Volver" />
        <br />
    
    </div>
    </form>
</body>
</html>