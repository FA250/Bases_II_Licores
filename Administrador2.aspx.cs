using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LicoreraWeb
{
    public partial class Administrador2 : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UsuarioAdministrador.aspx");
        }

        protected void button_agregarProducto_Click(object sender, EventArgs e)
        {

            String idProductoString = textbox_idProducto.Text;
            String idSucursalString = textbox_idSucursal.Text;
            String cantidadString = textbox_Cantidad.Text;

            if( !string.IsNullOrWhiteSpace(idProductoString) &&
                !string.IsNullOrWhiteSpace(idSucursalString) &&
                !string.IsNullOrWhiteSpace(cantidadString))
            {

                int idProducto = Int32.Parse(idProductoString);
                int idSucursal = Int32.Parse(idSucursalString);
                int cantidadd = Int32.Parse(cantidadString);

                this.conn = (SqlConnection)Session["SQL"];
                SqlCommand cmd = new SqlCommand("agregarLicorSucursal", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                // Parametros 
                cmd.Parameters.Add(new SqlParameter("@ID_Producto", SqlDbType.Int) { Value = idProducto });
                cmd.Parameters.Add(new SqlParameter("@ID_Sucursal", SqlDbType.Int) { Value = idSucursal });
                cmd.Parameters.Add(new SqlParameter("@Cantidad", SqlDbType.Int) { Value = cantidadd });

                // execute the command
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {

                        int resultado = rdr.GetInt32(0);
                        if (resultado == 1)
                        {
                            Response.Write("<script>alert('Se ha ingresado el nuevo producto a la sucursal') </script>");
                            return;

                        }
                        else
                        {
                            Response.Write("<script>alert('Error al ingresar el producto') </script>");
                            return;
                        }
                        //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                    }
                }

            }


            else
            {
                Response.Write("<script>alert('Se debe ingresar todos los campos') </script>");
                return;
            }
            
        }
    }
}