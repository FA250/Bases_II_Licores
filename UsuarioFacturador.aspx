<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioFacturador.aspx.cs" Inherits="LicoreraWeb.UsuarioFacturador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="height: 703px">
    
        <br />
        <br />
        <br />
        <asp:Label ID="label_facturarCliente" runat="server" Text="Facturar Cliente"></asp:Label>
        <br />
        <br />
        <asp:Label ID="label_Ingrese" runat="server" Text="Cédula del cliente"></asp:Label>
        <br />
        <br />
        <asp:TextBox ID="textbox_idCliente" runat="server" Width="267px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="Id de producto"></asp:Label>
        <asp:CheckBoxList ID="checkboxlist_listaIDProducto" runat="server" Width="275px">
        </asp:CheckBoxList>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Método de Pago"></asp:Label>
        <br />
        <asp:RadioButtonList ID="radiobuttonlist_metodoPago" runat="server">
            <asp:ListItem>Efectivo</asp:ListItem>
            <asp:ListItem>Tarjeta de Crédito</asp:ListItem>
        </asp:RadioButtonList>
        <asp:Button ID="button_volver" runat="server" OnClick="button_volver_Click" style="z-index: 1; left: 1149px; top: 669px; position: absolute" Text="Volver" />
        <br />
        <asp:Label ID="label_ProductoAFacturar" runat="server" style="position: absolute; z-index: 1; left: 15px; top: 547px" Text="Productos a facturar"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="dropdownlist_productosAFacturar" runat="server" style="z-index: 1; left: 13px; top: 589px; position: absolute; height: 30px;" Width="274px" Height="200px">
        </asp:DropDownList>
        <asp:Label ID="label_idProducto" runat="server" Text="Id de Producto"></asp:Label>
        <asp:Label ID="label_cantidadProducto" runat="server" style="z-index: 1; left: 225px; top: 429px; position: absolute; width: 72px" Text="Cantidad"></asp:Label>
        <br />
        <asp:TextBox ID="textbox_idProducto" runat="server" Width="202px"></asp:TextBox>
        <asp:TextBox ID="textbox_cantidadProducto" runat="server" Width="72px"></asp:TextBox>
        <br />
        <asp:Button ID="button_agregarProducto" runat="server" Text="Agregar Producto" Width="288px" OnClick="button_agregarProducto_Click" />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" style="z-index: 1; left: 14px; top: 657px; position: absolute; margin-bottom: 3px" Text="Facturar" Width="273px" OnClick="Button1_Click" />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    
    </div>
    </form>
</body>
</html>
