<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioAdministrador.aspx.cs" Inherits="LicoreraWeb.UsuarioAdministrador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="label_consultarPrecio" runat="server" Text="Consultar Precio Producto"></asp:Label>
    
        <br />
        
        <asp:Label ID="label_nombrePConsulta" runat="server" Text="Nombre:" style="z-index: 1; left: 10px; top: 37px; position: absolute"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" style="z-index: 1; left: 407px; top: 81px; position: absolute" Text="Nombre:"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_nombrePConsulta" runat="server" style="z-index: 1; left: 11px; top: 65px; position: absolute"></asp:TextBox>
        <br />
        <asp:Button ID="button_consultarPrecioProducto" runat="server" Text="Consultar" Width="334px" OnClick="Button1_Click" style="z-index: 1; left: 14px; top: 128px; position: absolute" />
        <br />
        <asp:Label runat="server" style="z-index: 1; left: 409px; top: 27px; position: absolute; width: 168px" Text="Ingresar Nuevo Producto"></asp:Label>
        <br />
        <asp:Label ID="label_precio" runat="server" Text="Precio" style="z-index: 1; left: 17px; top: 177px; position: absolute"></asp:Label>
        <asp:Label ID="label_precioConsultado" runat="server" style="z-index: 1; top: 175px; position: absolute; width: 270px; left: 80px"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_idPConsulta" runat="server" OnTextChanged="textbox_idPConsulta_TextChanged" style="z-index: 1; left: 189px; top: 64px; position: absolute"></asp:TextBox>
        <br />
        <asp:Label ID="label_actualizarPrecio" runat="server" Text="Actualizar Precio" style="z-index: 1; left: 12px; top: 229px; position: absolute"></asp:Label>
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Id:" style="z-index: 1; left: 10px; top: 257px; position: absolute"></asp:Label>
        <asp:Label ID="label_tipoAnejado" runat="server" style="z-index: 1; left: 413px; top: 404px; position: absolute; width: 157px" Text="Tipo Añejado:"></asp:Label>
        <asp:DropDownList ID="dropdownlist_tipoAnejado" runat="server" style="z-index: 1; left: 413px; top: 435px; position: absolute; width: 165px; height: 19px">
        </asp:DropDownList>
        <br />
        <asp:TextBox ID="textbox_idPActualizar" runat="server" style="z-index: 1; left: 10px; top: 279px; position: absolute"></asp:TextBox>
        <asp:TextBox ID="textbox_nuevoPrecio" runat="server" style="z-index: 1; left: 178px; top: 279px; position: absolute"></asp:TextBox>
        <asp:Label ID="Label5" runat="server" style="z-index: 1; left: 407px; top: 144px; position: absolute" Text="Año Cosecha:"></asp:Label>
        <br />
        <asp:Button ID="button_actualizarPrecio" runat="server" Text="Actualizar Precio" Width="333px" style="z-index: 1; left: 10px; top: 304px; position: absolute" OnClick="Button2_Click" />
        <asp:FileUpload ID="fileupload_imagenNuevoProducto" runat="server" style="z-index: 1; left: 413px; top: 313px; position: absolute; width: 165px" />
        <br />
        <br />
        <asp:Label ID="label_nombreSucursal" runat="server" style="z-index: 1; left: 640px; top: 140px; position: absolute" Text="Nombre Sucursal:"></asp:Label>
        <asp:TextBox ID="textbox_nombreSucursalTodos" runat="server" style="z-index: 1; left: 634px; top: 168px; position: absolute"></asp:TextBox>
        <asp:Table ID="table_consultas" runat="server" BackColor="White" BorderColor="Black" BorderStyle="Solid" GridLines="Both" style="z-index: 1; left: 820px; top: 32px; position: absolute; height: 72px; width: 403px">
        </asp:Table>
        <br />
        <asp:Label ID="label_productoMasVendido" runat="server" Text="Productos más vendidos:" style="z-index: 1; left: 10px; top: 377px; position: absolute; "></asp:Label>
        <br />
        <asp:Label ID="label_imagen" runat="server" style="z-index: 1; left: 409px; top: 279px; position: absolute" Text="Imagen:"></asp:Label>
        <asp:Button ID="button_ingresarProducto" runat="server" style="z-index: 1; left: 414px; top: 477px; position: absolute; width: 167px" Text="Ingresar Producto" OnClick="Button3_Click" />
        <asp:TextBox ID="textbox_idSucursalConsultaMasVendidos" runat="server" style="z-index: 1; left: 13px; top: 472px; position: absolute; width: 220px"></asp:TextBox>
        <asp:Label ID="Label10" runat="server" style="z-index: 1; left: 10px; top: 409px; position: absolute" Text="Productos sin salida:"></asp:Label>
        <br />
        <asp:Button ID="button_consultarVentas" runat="server" OnClick="button_consultarVentas_Click" style="z-index: 1; left: 650px; top: 450px; position: absolute; width: 146px" Text="Consultar Ventas" />
        <asp:Label ID="label_nuevoPrecio" runat="server" style="z-index: 1; left: 182px; top: 243px; position: absolute; width: 155px" Text="Nuevo Precio:"></asp:Label>
        <asp:RadioButtonList ID="radiobuttonlist_productosMasVendidos" runat="server" style="z-index: 1; left: 14px; top: 554px; position: absolute; height: 54px; width: 229px">
            <asp:ListItem Value="0">Por Sucursal</asp:ListItem>
            <asp:ListItem Value="1">Global</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Label ID="Label9" runat="server" style="z-index: 1; left: 13px; top: 441px; position: absolute; width: 195px" Text="Id Sucursal:"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_nombreNuevoProducto" runat="server" style="z-index: 1; left: 407px; top: 110px; position: absolute"></asp:TextBox>
        <asp:Label ID="Label7" runat="server" style="z-index: 1; left: 190px; top: 39px; position: absolute; width: 163px" Text="Id Producto:"></asp:Label>
        <br />
        <asp:Label ID="label_idSucursal" runat="server" style="z-index: 1; left: 638px; top: 79px; position: absolute" Text="Id Sucursal:"></asp:Label>
        <asp:Label ID="Label6" runat="server" style="z-index: 1; left: 653px; top: 281px; position: absolute" Text="Consulta de Ventas"></asp:Label>
        <asp:Label ID="label_fechaInicial" runat="server" style="z-index: 1; left: 652px; top: 490px; position: absolute; width: 137px" Text="Fecha Inicial"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_anhoCosecha" runat="server" style="z-index: 1; left: 409px; top: 178px; position: absolute"></asp:TextBox>
        <asp:TextBox ID="textbox_precioIngresarNuevoProducto" runat="server" style="z-index: 1; left: 409px; top: 249px; position: absolute"></asp:TextBox>
        <asp:Button ID="button_consultarProductos" runat="server" OnClick="button_consultarProductos_Click" style="z-index: 1; left: 637px; top: 203px; position: absolute; width: 164px; margin-bottom: 0px" Text="Consultar Productos" />
        <asp:Calendar ID="Calendar1" runat="server" style="z-index: 1; left: 907px; top: 456px; position: absolute; height: 213px; width: 244px; margin-top: 1px"></asp:Calendar>
        <br />
        <asp:Label ID="label_precioNuevo" runat="server" style="z-index: 1; left: 408px; top: 213px; position: absolute" Text="Precio:"></asp:Label>
        <asp:TextBox ID="textbox_idSucursal" runat="server" style="z-index: 1; left: 635px; top: 105px; position: absolute"></asp:TextBox>
        <asp:RadioButtonList ID="radiobuttonlist_consultaVentas" runat="server" style="z-index: 1; left: 650px; top: 315px; position: absolute; height: 28px; width: 152px">
            <asp:ListItem Value="0">Por Sucursal</asp:ListItem>
            <asp:ListItem Value="1">Por Vino</asp:ListItem>
            <asp:ListItem Value="2">Por Fechas</asp:ListItem>
            <asp:ListItem Value="3">Por Tipo de Pago</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Button ID="button_fechaInicial" runat="server" OnClick="button_fechaInicial_Click" style="z-index: 1; left: 909px; top: 679px; position: absolute; width: 109px; height: 29px; right: 832px" Text="Fecha Inicial" />
        <asp:Label ID="label_nombreSucursalMasMenosVendidos" runat="server" style="width: 226px; z-index: 1; left: 16px; top: 500px; position: absolute" Text="Nombre Sucursal:"></asp:Label>
        <br />
        <asp:Label ID="label_consultarProductorSucursal" runat="server" style="z-index: 1; left: 638px; top: 21px; position: absolute; width: 165px; margin-top: 6px" Text="Consultar Productos de Sucursal"></asp:Label>
        <asp:Button ID="button_fechaFinal" runat="server" OnClick="button_fechaFinal_Click" style="z-index: 1; left: 1027px; top: 679px; position: absolute; width: 114px" Text="Fecha Final" />
        <asp:Label ID="label_fechaFinal" runat="server" style="z-index: 1; left: 651px; top: 523px; position: absolute; width: 138px" Text="Fecha Final"></asp:Label>
        <asp:TextBox ID="textbox_nombreSucursalMasMenosVendido" runat="server" style="margin-left: 6px; " Width="220px"></asp:TextBox>
        <br />
        <asp:Label ID="label_idSucursal0" runat="server" style="z-index: 1; left: 638px; top: 79px; position: absolute" Text="Id Sucursal:"></asp:Label>
        <asp:Button ID="button_consultarMasVendidos" runat="server" OnClick="button_consultarMasVendidos_Click" Text="Consultar Más Vendidos" Width="230px" style="z-index: 1; left: 14px; top: 621px; position: absolute; right: 999px;" />
        <asp:DropDownList ID="dropdownlist_paisNuevoProducto" runat="server" style="z-index: 1; left: 412px; top: 372px; position: absolute; width: 165px">
        </asp:DropDownList>
        <br />
        <asp:Button ID="button_consultaSinSalida" runat="server" OnClick="Button4_Click" Text="Consultar No Vendidos" Width="231px" style="z-index: 1; left: 14px; top: 658px; position: absolute" />
        <br />
        <br />
        <asp:Label ID="label_paisNuevoProducto" runat="server" style="z-index: 1; left: 411px; top: 346px; position: absolute; width: 162px" Text="País:"></asp:Label>
        <br />
        <br />
        <asp:Button ID="button_Volver" runat="server" OnClick="button_Volver_Click" Text="Volver" style="z-index: 1; left: 19px; top: 692px; position: absolute; width: 71px;" />
        <br />
    
    </div>
        <asp:Button ID="button_siguiente" runat="server" OnClick="button_siguiente_Click" style="z-index: 1; left: 178px; top: 694px; position: absolute" Text="Siguiente" />
    </form>
</body>
</html>
