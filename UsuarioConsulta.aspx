<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioConsulta.aspx.cs" Inherits="LicoreraWeb.UsuarioConsulta" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="z-index: 1; left: 10px; top: 15px; position: absolute; height: 616px; width: 1152px">
    
        <br />
        <asp:Label ID="label_ingreseIDSucursal" runat="server" style="z-index: 1; left: 776px; top: 33px; position: absolute; width: 241px" Text="Ingrese el ID de sucursal"></asp:Label>
        <asp:Label ID="label_NombreProducto" runat="server" style="z-index: 1; left: 134px; top: 29px; position: absolute" Text="Nombre del Producto:"></asp:Label>
        <br />
        <asp:Label ID="label_consultaHorario" runat="server" style="z-index: 1; left: 774px; top: -1px; position: absolute" Text="Consulta de Horario de Sucursal"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_consultarProducto" runat="server" style="z-index: 1; left: 134px; top: 3px; position: absolute; width: 234px" Text="Consulta de Producto"></asp:Label>
        <br />
        <asp:Button ID="button_consultarHorario" runat="server" style="z-index: 1; left: 779px; top: 93px; position: absolute; width: 253px" Text="Consultar Horario" OnClick="button_consultarHorario_Click" />
        <asp:Label ID="label_idProductoConsulta" runat="server" style="z-index: 1; left: 136px; top: 94px; position: absolute; width: 212px" Text="Id del Producto:"></asp:Label>
        <br />
        <asp:Button ID="button_consultarProducto" runat="server" style="z-index: 1; left: 135px; top: 213px; position: absolute; margin-top: 4px; width: 212px;" Text="Consultar Producto" OnClick="button_consultarProducto_Click" />
        <br />
        <asp:TextBox ID="textbox_nombreProducto" runat="server" style="z-index: 1; left: 134px; top: 59px; position: absolute; width: 208px;"></asp:TextBox>
        <asp:TextBox ID="textbox_idProductoConsulta" runat="server" style="z-index: 1; left: 134px; top: 123px; position: absolute; width: 205px"></asp:TextBox>
        <br />
        <asp:TextBox ID="textbox_idSucursal" runat="server" style="z-index: 1; left: 780px; top: 60px; position: absolute; width: 250px"></asp:TextBox>
        <asp:Label ID="label_idSucursalActualConsultaProducto" runat="server" style="z-index: 1; left: 135px; top: 153px; position: absolute; width: 211px; bottom: 441px" Text="Id Sucursal Actual:"></asp:Label>
        <br />
        <asp:Label ID="label_precio" runat="server" style="z-index: 1; left: 137px; top: 269px; position: absolute; width: 177px; height: 26px; margin-top: 0px;" Text="Precio del Producto"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_precioConsultado" runat="server" style="z-index: 1; left: 136px; top: 299px; position: absolute"></asp:Label>
        <asp:TextBox ID="textbox_idSucursalActual" runat="server" style="z-index: 1; left: 135px; top: 181px; position: absolute; width: 204px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="label_sucursales" runat="server" style="z-index: 1; left: 377px; top: 332px; position: absolute" Text="Disponible en las siguientes sucursales:"></asp:Label>
        <asp:Table ID="table_horarios" runat="server" style="z-index: 1; left: 785px; top: 139px; position: absolute; height: 28px; width: 238px">
        </asp:Table>
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:DropDownList ID="dropdownlist_sucursales" runat="server" style="z-index: 1; left: 376px; top: 359px; position: absolute; width: 207px;">
        </asp:DropDownList>
        <br />
        <asp:Label ID="label_fotoProducto" runat="server" style="z-index: 1; left: 135px; top: 332px; position: absolute; width: 202px;" Text="Fotografía del Producto:"></asp:Label>
        <br />
        <br />
        <asp:Image ID="image_fotoProducto" runat="server" style="z-index: 1; left: 140px; top: 360px; position: absolute; height: 159px; width: 201px;" />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="button_volver" runat="server" OnClick="button_volver_Click" style="z-index: 1; left: 3px; top: 582px; position: absolute" Text="Volver" />
        <br />
        <br />
        <br />
    
    </div>
    </form>
</body>
</html>
