using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;


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
                SqlConnection conn = new SqlConnection();
                conn.ConnectionString =
                "Data Source=DESKTOP-R6CF7AS;" +
                "Initial Catalog=BDRestaurantes;" +
                "User id=Moke;" +
                "Password=1234;";
                conn.Open();

                Session["SQL"] = conn; // El objeto queda en la sesion para poder ser compartido entre las paginas


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
               
    
            }




        }


        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}