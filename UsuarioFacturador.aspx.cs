using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace LicoreraWeb
{

    public static class GlobalVariables
    {
        public static ArrayList listaIdProducto;
        public static ArrayList listaCantidad;
        public static ArrayList listaPrecioUnitario;
    }
    public partial class UsuarioFacturador : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (GlobalVariables.listaIdProducto == null)
            {
                GlobalVariables.listaIdProducto = new ArrayList();
            }

            if (GlobalVariables.listaCantidad == null)
            {
                GlobalVariables.listaCantidad = new ArrayList();
            }

            if (GlobalVariables.listaPrecioUnitario == null)
            {
                GlobalVariables.listaPrecioUnitario = new ArrayList();
            }
        }

        protected void button_agregarProducto_Click(object sender, EventArgs e)
        {       

            int cantidadProducto = 0;
            int idProducto = 0;


            if (Int32.TryParse(textbox_cantidadProducto.Text, out cantidadProducto) &&
                Int32.TryParse(textbox_idProducto.Text, out idProducto))
            {

                if (!GlobalVariables.listaIdProducto.Contains(idProducto))
                {
                    GlobalVariables.listaIdProducto.Add(idProducto);
                    GlobalVariables.listaCantidad.Add(cantidadProducto);

                    String item = ("ID: " + idProducto.ToString() + " Cantidad: " + cantidadProducto.ToString());
                    this.dropdownlist_productosAFacturar.Items.Add(new ListItem(item));


                }
                else
                {
                    int pos = GlobalVariables.listaIdProducto.IndexOf(idProducto);
                    int nuevaCantidad = (int)GlobalVariables.listaCantidad[pos] + cantidadProducto;
                    GlobalVariables.listaCantidad[pos] = nuevaCantidad;
                    String item = ("ID: " + idProducto.ToString() + " Cantidad: " + cantidadProducto.ToString());
                    this.dropdownlist_productosAFacturar.Items.Add(new ListItem(item));


                    

                    
                }

                /* Original
                this.listaIdProducto.Add(idProducto);
                this.listaCantidad.Add(cantidadProducto);

                String item = ("ID: " + idProducto.ToString() + " Cantidad: " + cantidadProducto.ToString());
                this.dropdownlist_productosAFacturar.Items.Add(new ListItem(item));
                */ // Fin origninal


            }
            else
            {
                Response.Write("<script>alert('La cantidad y el id de producto deben ser un valor entero') </script>");
            }






            // Prueba 
            String prueba = "Largo lista id: " + GlobalVariables.listaIdProducto.Count + " Largo lista cantidad: " + GlobalVariables.listaCantidad.Count + " Lista precio unitario: " + GlobalVariables.listaPrecioUnitario.Count;
            label_prueba.Text = prueba;

            //this.dropdownlist_productosAFacturar.Items.Clear();



        }



        protected void Button1_Click(object sender, EventArgs e) // Facturar
        {
            this.conn = (SqlConnection)Session["SQL"];

            String idUsuarioString = textbox_idCliente.Text;
            String idSucursalString = textbox_idSucursal.Text;

            if( string.IsNullOrWhiteSpace(idUsuarioString) || string.IsNullOrWhiteSpace(idSucursalString))
            {
                Response.Write("<script>alert('Se debe ingresar el ID de usuario y el ID de Sucursal') </script>");
                return;
            }

            int metodoPago = 0;
            // Metodo de Pago
            if (radiobuttonlist_metodoPago.SelectedIndex != -1)
            {

                // tarjeta 1 y efectivo 2
                
                String opcionSelecionada = this.radiobuttonlist_metodoPago.SelectedItem.Text;
                if(opcionSelecionada.Equals("Tarjeta de Crédito"))
                {
                    metodoPago = 1;
                }
                else
                {
                    metodoPago = 2; 
                }
            }
            else
            {
                Response.Write("<script>alert('Seleccione un metodo de pago') </script>");
                return;
            }



            // total items: todas las cantidad sumadas
            // cantidad de licores : cantidad de identificaroes 


            int idUsuario = Int32.Parse(idUsuarioString);
            int idSucursal = Int32.Parse(idSucursalString);

            // Cantidad total de items 
            int totalItems = 0;
            for (int i = 0; i < GlobalVariables.listaCantidad.Count; i++)
            {
                totalItems = totalItems + (int)GlobalVariables.listaCantidad[i];
            }
            // Cantidad de Licores
            int cantidadLicores = GlobalVariables.listaIdProducto.Count;
            // Monto Total
            int montoTotal = this.CalcularMontoTotal();

            // id Del Facturador
            int idFacturador = (int) Session["idUsuario"];


            // Procedimiento registrar catalogo de venta

            int idCatalogo = 0;
            int cantidadTemp = 0;
            int subTotal = 0;
            int precioUnitario = 0;



            // Prueba 
            String prueba = "Largo lista id: " + GlobalVariables.listaIdProducto.Count + " Largo lista cantidad: " + GlobalVariables.listaCantidad.Count + " Lista precio unitario: " + GlobalVariables.listaPrecioUnitario.Count;
            label_prueba.Text = prueba;

            // Fin de prueba



            for (int i = 0; i < GlobalVariables.listaIdProducto.Count; i++)
            {



                idCatalogo = (int)GlobalVariables.listaIdProducto[i];
                cantidadTemp = (int)GlobalVariables.listaCantidad[i];
                precioUnitario = (int)GlobalVariables.listaPrecioUnitario[i];
                subTotal = cantidadTemp * precioUnitario;

                // Procedimiento almacenado  registrar catalogo
                SqlCommand cmd1 = new SqlCommand("registrarCatalogo_Venta", conn);
                cmd1.CommandType = CommandType.StoredProcedure;

                cmd1.Parameters.Add(new SqlParameter("@Identificacion_Cliente", SqlDbType.Int) { Value = idUsuario });
                cmd1.Parameters.Add(new SqlParameter("@ID_Catalogo", SqlDbType.Int) { Value = idCatalogo });
                cmd1.Parameters.Add(new SqlParameter("@Cantidad", SqlDbType.Int) { Value = cantidadTemp });
                cmd1.Parameters.Add(new SqlParameter("@Subtotal", SqlDbType.Money) { Value = subTotal });

                // execute the command
                using (SqlDataReader rdr = cmd1.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {
                        int resultado = rdr.GetInt32(0);
                        if(resultado != 1)
                        {
                            Response.Write("<script>alert('Error en el ingreso en el catalogo') </script>");
                            return;
                        }
                        
                    }
                }


            }

            // Prueba 


            prueba = "Largo lista id: " + GlobalVariables.listaIdProducto.Count + " Largo lista cantidad: " + GlobalVariables.listaCantidad.Count + " Lista precio unitario: " + GlobalVariables.listaPrecioUnitario;
            label_prueba.Text = prueba;

            // Fin de prueba



            // Procedimiento almacenado  Facturar
            SqlCommand cmd = new SqlCommand("facturar", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@ID_Usuario", SqlDbType.Int) { Value = idFacturador });
            cmd.Parameters.Add(new SqlParameter("@ID_Sucursal", SqlDbType.Int) { Value = idSucursal });
            cmd.Parameters.Add(new SqlParameter("@Cantidad_Licores", SqlDbType.Int) { Value = cantidadLicores });
            cmd.Parameters.Add(new SqlParameter("@Total_Items", SqlDbType.Int) { Value = totalItems });
            cmd.Parameters.Add(new SqlParameter("@Monto_Total", SqlDbType.Money) { Value = montoTotal });
            cmd.Parameters.Add(new SqlParameter("@Identificacion_Cliente", SqlDbType.Int) { Value = idUsuario });
            cmd.Parameters.Add(new SqlParameter("@ID_Metodo_Pago", SqlDbType.Int) { Value = metodoPago });

            // execute the command
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                // iterate through results, printing each to console
                while (rdr.Read())
                {
                    int resultado = rdr.GetInt32(0);
                    if(resultado == 1)
                    {
                        Response.Write("<script>alert('Se ha facturado') </script>");
                        
                    }
                    else
                    {
                        Response.Write("<script>alert('Error al facturar') </script>");
                        
                    }

                   // Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                }
            }
            





        }


        protected int CalcularMontoTotal()
        {
            this.conn = (SqlConnection)Session["SQL"];


            
            int montoTotal = 0;
            int id = 0;
            int precioTemporal = 0;
            int cantidadTemporal = 0;

            for (int i = 0; i < GlobalVariables.listaIdProducto.Count; i++)
            {

                id = (int)GlobalVariables.listaIdProducto[i];
                cantidadTemporal = (int)GlobalVariables.listaCantidad[i];
                precioTemporal = 0;
                


                SqlCommand cmd = new SqlCommand("consultarPrecio", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                // Parametros 
                cmd.Parameters.Add(new SqlParameter("@nombre", SqlDbType.VarChar, 20) { Value = DBNull.Value });
                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int) { Value = id });

                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {
                        precioTemporal = rdr.GetInt32(0);
                        montoTotal = montoTotal + (precioTemporal * cantidadTemporal);
                        GlobalVariables.listaPrecioUnitario.Add(precioTemporal);
                    }
                }


            }
            return montoTotal;

            
        }

        protected void button_volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Logging.aspx");
        }
    }
}