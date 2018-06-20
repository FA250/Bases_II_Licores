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


using System.Data;
using System.Data.SqlClient;
using System.Xml;


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

                bool aceptado = false;

                // Conexion a SQL 
                SqlConnection conn = new SqlConnection();
                conn.ConnectionString =
                "Data Source=DESKTOP-R6CF7AS;" +
                "Initial Catalog=Licores;" +
                "User id=Moke;" +
                "Password=1234;";
                conn.Open();
                Session["SQL"] = conn; // El objeto queda en la sesion para poder ser compartido entre las paginas
                

                // Valores de Interfaz
                String tipoUsuario = RadioButtonList1.SelectedItem.Text;
                String contrasena = this.textbox_contrasena.Text;
                String idUsuario = this.textbox_identificacion.Text;
                int numeroUsuario = 1;

                // Parametros

                

                

                // Parametros de procedimiento almacenado
                SqlCommand cmd = new SqlCommand("verificarUsuario", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Cedula", SqlDbType.Int, 10) { Value = idUsuario });
                cmd.Parameters.Add(new SqlParameter("@Contrasenna", SqlDbType.VarChar) { Value = contrasena });


                switch (tipoUsuario) // 1 Administrador 2 Consulta  3 Facturar
                {
                    case "Usuario Administrador":
                        numeroUsuario = 1; 
                           
                        break;

                    case "Usuario de Consultas":
                        numeroUsuario = 2;
                       
                        break;
                    case "Usuario Facturador":
                        numeroUsuario = 3;
                       
                        break;

                    default:
                        
                        break;

                }
                Session["idUsuario"] = numeroUsuario;


                // Parametro de numero de usuario
                cmd.Parameters.Add(new SqlParameter("@tipo_Usuario", SqlDbType.Int) { Value = numeroUsuario });

                // Lectura de Procedimiento
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {
                        // Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                        aceptado = true;
                    }
                }


                // Validacion de usuario
                if (aceptado )

                {
                    switch (numeroUsuario)
                    {
                        case 1:
                            Response.Redirect("~/UsuarioAdministrador.aspx");
                            break;
                        case 2:
                            Response.Redirect("~/UsuarioConsulta.aspx");
                            break;
                        case 3:
                            Response.Redirect("~/UsuarioFacturador.aspx");
                            break;
                    }
                }
                else
                {
                    Response.Write("<script>alert('El nombre de usuario o la contraseña son incorrectos') </script>");
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