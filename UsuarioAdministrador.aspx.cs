using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



using System.Text;
using System.Data;
using System.Data.SqlClient;


namespace LicoreraWeb
{
    public partial class UsuarioAdministrador : System.Web.UI.Page
    {
        String fecha1;
        String fecha2;


        SqlConnection conn; 
        


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_consultarVentas_Click(object sender, EventArgs e)
        {


            this.conn =  (SqlConnection)Session["SQL"];

            String opcionConsulta = this.radiobuttonlist_consultaVentas.SelectedValue;

            switch (opcionConsulta)
            {
                case "0": // Por sucursal

                    break;

                case "1": // Por Vino
                    break;

                case "2": // Por Fechas
                    
                    
                    break;

                case "3": // Por tipo de Pago
                    break;
            }

            // Llamada a stored procedure 

            
                conn.Open();

                // 1.  create a command object identifying the stored procedure
                SqlCommand cmd = new SqlCommand("CustOrderHist", conn);

                // 2. set the command object so it knows to execute a stored procedure
                cmd.CommandType = CommandType.StoredProcedure;

            // 3. add parameter to command, which will be passed to the stored procedure
            int custId = 12;
                cmd.Parameters.Add(new SqlParameter("@CustomerID", custId));

                // execute the command
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {
                        Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                    }
                }
            



        }

        protected void button_fechaInicial_Click(object sender, EventArgs e)
        {
            this.fecha1 = this.Calendar1.SelectedDate.ToString();
            this.label_fechaInicial.Text = fecha1; 


        }

        protected void button_fechaFinal_Click(object sender, EventArgs e)
        {
            this.fecha2 = this.Calendar1.SelectedDate.ToString();
            this.label_fechaFinal.Text = fecha2;
        }

        protected void button_consultarProductos_Click(object sender, EventArgs e)
        {
            String idSucursal = this.textbox_idSucursal.Text; 
        }

        protected void button_Volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Logging.aspx");
        }

        protected void button_consultarMasVendidos_Click(object sender, EventArgs e)
        {


            String opcionConsultarMasVendidos = this.radiobuttonlist_productosMasVendidos.SelectedValue;

            switch (opcionConsultarMasVendidos)
            {
                case "0": // Por sucursal
                    String sucursal = this.textbox_idSucursalConsultaMasVendidos.Text; 
                    break;
                case "1": // Global
                    break;

            }
        }

        protected void Button4_Click(object sender, EventArgs e)  // Boton Aquellos Sin Salida
        {
            String opcinAquellosSinSalida = this.radiobuttonlist_productosMasVendidos.SelectedValue;

            switch (opcinAquellosSinSalida)
            {
                case "0": // Por sucursal
                    String sucursal = this.textbox_idSucursalConsultaMasVendidos.Text; 
                    break;
                case "1": // Global
                    break;
                    
            }
        }

        protected void Button1_Click(object sender, EventArgs e) // Consultar Precio Producto
        {

        }
    }
}