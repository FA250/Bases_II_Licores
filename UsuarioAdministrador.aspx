<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioAdministrador.aspx.cs" Inherits="LicoreraWeb.UsuarioAdministrador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <asp:Label ID="label_consultarPrecio" runat="server" Text="Consultar Precio Producto"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_nombrePConsulta" runat="server" Text="Nombre:"></asp:Label>
        <asp:Label ID="Label4" runat="server" style="z-index: 1; left: 407px; top: 81px; position: absolute" Text="Nombre:"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_nombrePConsulta" runat="server"></asp:TextBox>
        <asp:TextBox ID="textbox_idPConsulta" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Consultar" Width="334px" />
        <br />
        <asp:Label runat="server" style="z-index: 1; left: 409px; top: 27px; position: absolute; width: 168px" Text="Ingresar Nuevo Producto"></asp:Label>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Precio"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_actualizarPrecio" runat="server" Text="Actualizar Precio"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Id:"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_idPActualizar" runat="server"></asp:TextBox>
        <asp:TextBox ID="textbox_nuevoPrecio" runat="server"></asp:TextBox>
        <asp:Label ID="Label5" runat="server" style="z-index: 1; left: 407px; top: 144px; position: absolute" Text="Año Cosecha:"></asp:Label>
        <br />
        <asp:Button ID="Button2" runat="server" Text="Actualizar Precio" Width="333px" />
        <br />
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Text="Productos más vendidos / Productos Sin Salida:"></asp:Label>
        <br />
        <asp:Label ID="label_imagen" runat="server" style="z-index: 1; left: 409px; top: 279px; position: absolute" Text="Imagen:"></asp:Label>
        <asp:Button ID="Button3" runat="server" style="z-index: 1; left: 409px; top: 336px; position: absolute; width: 167px" Text="Ingresar Producto" />
        <asp:TextBox ID="textbox_idSucursalConsultaMasVendidos" runat="server" style="z-index: 1; left: 12px; top: 451px; position: absolute; width: 220px"></asp:TextBox>
        <br />
        <asp:Button ID="button_consultarVentas" runat="server" OnClick="button_consultarVentas_Click" style="z-index: 1; left: 642px; top: 365px; position: absolute; width: 146px" Text="Consultar Ventas" />
        <asp:Label ID="label_nuevoPrecio" runat="server" style="z-index: 1; left: 184px; top: 219px; position: absolute; width: 155px" Text="Nuevo Precio:"></asp:Label>
        <asp:RadioButtonList ID="radiobuttonlist_productosMasVendidos" runat="server" style="z-index: 1; left: 9px; top: 485px; position: absolute; height: 54px; width: 229px">
            <asp:ListItem Value="0">Por Sucursal</asp:ListItem>
            <asp:ListItem Value="1">Global</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Label ID="Label9" runat="server" style="z-index: 1; left: 13px; top: 419px; position: absolute; width: 195px" Text="Id Sucursal:"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_nombreNuevoProducto" runat="server" style="z-index: 1; left: 407px; top: 110px; position: absolute"></asp:TextBox>
        <asp:Label ID="Label7" runat="server" style="z-index: 1; left: 181px; top: 55px; position: absolute; width: 68px" Text="Id:"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_imagenPath" runat="server" style="z-index: 1; left: 409px; top: 308px; position: absolute"></asp:TextBox>
        <asp:Label ID="label_idSucursal" runat="server" style="z-index: 1; left: 638px; top: 79px; position: absolute" Text="Id Sucursal:"></asp:Label>
        <asp:Label ID="Label6" runat="server" style="z-index: 1; left: 638px; top: 191px; position: absolute" Text="Consulta de Ventas"></asp:Label>
        <asp:Label ID="label_fechaInicial" runat="server" style="z-index: 1; left: 645px; top: 403px; position: absolute; width: 137px" Text="Fecha Inicial"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_anhoCosecha" runat="server" style="z-index: 1; left: 409px; top: 178px; position: absolute"></asp:TextBox>
        <asp:TextBox ID="textbox_precioIngresarNuevoProducto" runat="server" style="z-index: 1; left: 409px; top: 249px; position: absolute"></asp:TextBox>
        <asp:Button ID="button_consultarProductos" runat="server" OnClick="button_consultarProductos_Click" style="z-index: 1; left: 636px; top: 138px; position: absolute; width: 164px; margin-bottom: 0px" Text="Consultar Productos" />
        <asp:Table ID="Table1" runat="server" Height="218px" style="z-index: 1; left: 865px; top: 24px; position: absolute; height: 218px; width: 341px; margin-top: 0px" Width="341px">
        </asp:Table>
        <asp:Calendar ID="Calendar1" runat="server" style="z-index: 1; left: 893px; top: 277px; position: absolute; height: 213px; width: 244px; margin-top: 1px"></asp:Calendar>
        <br />
        <asp:Label ID="label_precioNuevo" runat="server" style="z-index: 1; left: 408px; top: 213px; position: absolute" Text="Precio:"></asp:Label>
        <asp:TextBox ID="textbox_idSucursal" runat="server" style="z-index: 1; left: 635px; top: 105px; position: absolute"></asp:TextBox>
        <asp:RadioButtonList ID="radiobuttonlist_consultaVentas" runat="server" style="z-index: 1; left: 640px; top: 225px; position: absolute; height: 28px; width: 152px">
            <asp:ListItem Value="0">Por Sucursal</asp:ListItem>
            <asp:ListItem Value="1">Por Vino</asp:ListItem>
            <asp:ListItem Value="2">Por Fechas</asp:ListItem>
            <asp:ListItem Value="3">Por Tipo de Pago</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Button ID="button_fechaInicial" runat="server" OnClick="button_fechaInicial_Click" style="z-index: 1; left: 901px; top: 502px; position: absolute; width: 109px; height: 29px; right: 238px" Text="Fecha Inicial" />
        <br />
        <asp:Label ID="label_consultarProductorSucursal" runat="server" style="z-index: 1; left: 638px; top: 21px; position: absolute; width: 165px; margin-top: 6px" Text="Consultar Productos de Sucursal"></asp:Label>
        <asp:Button ID="button_fechaFinal" runat="server" OnClick="button_fechaFinal_Click" style="z-index: 1; left: 1021px; top: 503px; position: absolute; width: 114px" Text="Fecha Final" />
        <asp:Label ID="label_fechaFinal" runat="server" style="z-index: 1; left: 646px; top: 435px; position: absolute; width: 138px" Text="Fecha Final"></asp:Label>
        <br />
        <asp:Label ID="label_idSucursal0" runat="server" style="z-index: 1; left: 638px; top: 79px; position: absolute" Text="Id Sucursal:"></asp:Label>
        <asp:Button ID="button_consultarMasVendidos" runat="server" OnClick="button_consultarMasVendidos_Click" Text="Consultar Más Vendidos" Width="230px" />
        <br />
        <asp:Button ID="button_consultaSinSalida" runat="server" OnClick="Button4_Click" Text="Consultar Aquellos Sin Salida" Width="231px" />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="button_Volver" runat="server" OnClick="button_Volver_Click" Text="Volver" />
        <br />
    
    </div>
    </form>
</body>
</html>
