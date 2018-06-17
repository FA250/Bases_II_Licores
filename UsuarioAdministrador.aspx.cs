using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LicoreraWeb
{
    public partial class UsuarioAdministrador : System.Web.UI.Page
    {
        String fecha1;
        String fecha2; 
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_consultarVentas_Click(object sender, EventArgs e)
        {


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
    }
}