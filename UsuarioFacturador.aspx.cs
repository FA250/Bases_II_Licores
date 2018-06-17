using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LicoreraWeb
{
    public partial class UsuarioFacturador : System.Web.UI.Page
    {
        List<int> listaIdProducto= new List<int>();
        List<int> listaCantidad = new List<int>();


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_agregarProducto_Click(object sender, EventArgs e)
        {
            int cantidadProducto = 0;
            int idProducto = 0; 

            if (Int32.TryParse(textbox_cantidadProducto.Text, out cantidadProducto) &&
                Int32.TryParse(textbox_idProducto.Text, out idProducto))
            {
                this.listaIdProducto.Add(idProducto);
                this.listaCantidad.Add(cantidadProducto);

                String item = ("ID: " + idProducto.ToString() + " Cantidad: " + cantidadProducto.ToString());
                this.dropdownlist_productosAFacturar.Items.Add(new ListItem(item));


            }
            else
            {
                Response.Write("<script>alert('La cantidad y el id de producto deben ser un valor entero') </script>");
            }

            //this.dropdownlist_productosAFacturar.Items.Clear();

            

            



            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
        }

        protected void button_volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Logging.aspx");
        }
    }
}