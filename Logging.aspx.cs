using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; 

namespace LicoreraWeb
{
    public partial class Logging : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            

            if (RadioButtonList1.SelectedIndex != -1)
            {


                // Conexion a SQL 
                String connectionString = "Data Source=//DESKTOP-R6CF7AS\\MSSQLSERVER;Initial Catalog=BDRestaurante; User ID =Jose;Password=1234";

                String ip = "186.176.116.137";
                String port = "1433";
                String user = "Jose";
                String password = "1234";
                String dataBaseName = "BDRestaurante";
                String conString = "Data Source=" + ip + "," + port + ";Network Library=DBMSSOCN;Initial Catalog=" + dataBaseName + ";User ID=" + user + ";Password=" + password;

                SqlConnection cnn = new SqlConnection(connectionString);

                try
                {
                    cnn.Open();
                    Response.Write("<script>alert('Conexión a Base de Datos establecida') </script>");
                    Console.WriteLine("Conexion establecida");
                    cnn.Close();

                }
                catch (Exception ex)
                {
                    Console.WriteLine("Conexion no establecida");
                    Response.Write("<script>alert('Error en la conexion') </script>");
                }


                /*

                String tipoUsuario = RadioButtonList1.SelectedItem.Text;
                switch (tipoUsuario)
                {
                    case "Usuario Administrador":
                        Response.Redirect("~/UsuarioAdministrador.aspx");
                        break;

                    case "Usuario de Consultas":
                        Response.Redirect("~/UsuarioConsulta.aspx");
                        break;
                    case "Usuario Facturador":
                        Response.Redirect("~/UsuarioFacturador.aspx");
                        break;

                    default:
                        
                        break;



                }

            }
            else
            {

                // Alerta debe seleccionar un tipo de usuario para poder ingresar
                Response.Write("<script>alert('Seleccione un tipo de usuario') </script>");
               
    */
            }




        }


        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}