﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logging.aspx.cs" Inherits="LicoreraWeb.Logging" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" BackColor="White" BorderColor="White" ForeColor="Black" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" style="z-index: 1; left: 633px; top: 236px; position: absolute; height: 80px; width: 276px">
            <asp:ListItem>Usuario Administrador</asp:ListItem>
            <asp:ListItem>Usuario de Consultas</asp:ListItem>
            <asp:ListItem>Usuario Facturador</asp:ListItem>
        </asp:RadioButtonList>
        <asp:TextBox ID="TextBox1" runat="server" style="position: absolute; z-index: 1; left: 636px; top: 180px; width: 265px"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" style="position: absolute; z-index: 1; left: 632px; top: 141px" Text="Ingrese su número de identificación"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" BackColor="White" BorderColor="White" ForeColor="Black" OnClick="Button1_Click" style="z-index: 1; left: 633px; top: 363px; position: absolute; width: 272px" Text="Ingresar" />
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
