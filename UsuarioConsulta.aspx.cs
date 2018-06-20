using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Text;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using Microsoft.SqlServer;



namespace LicoreraWeb
{
    public partial class UsuarioConsulta : System.Web.UI.Page
    {

        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Logging.aspx");
        }

        protected void button_consultarHorario_Click(object sender, EventArgs e)
        {
            this.conn = (SqlConnection)Session["SQL"];


            String idSucursalString = this.textbox_idSucursal.Text;

            int idSucursal = Int32.Parse(idSucursalString);

            SqlCommand cmd = new SqlCommand("consultaHorarioSucursal", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ID_Sucursal", SqlDbType.Int) { Value = idSucursal });


            this.table_horarios.Rows.Clear();


            // Se añaden las filas iniciales de la tabla 
            TableCell cel1 = new TableCell();
            TableCell cel2 = new TableCell();
            TableCell cel3 = new TableCell();

            cel1.Text = "Horario Entrada: ";
            cel2.Text = "Horario Salida: ";
            cel3.Text = "Horario Dias: ";

            TableRow filaInicial = new TableRow();
            filaInicial.Cells.Add(cel1);
            filaInicial.Cells.Add(cel2);
            filaInicial.Cells.Add(cel3);

            this.table_horarios.Rows.Add(filaInicial);
            TimeSpan horarioEntrada;
            TimeSpan horarioSalida;
            String horarioDias;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {

                while (rdr.Read())
                {


                    cel1 = new TableCell();
                    cel2 = new TableCell();
                    cel3 = new TableCell();
                    horarioEntrada = rdr.GetTimeSpan(0);
                    horarioSalida = rdr.GetTimeSpan(1);
                    horarioDias = rdr.GetString(2);
                    cel1.Text = horarioEntrada.ToString("c");
                    cel2.Text = horarioSalida.ToString("c");
                    cel3.Text = horarioDias;
                    filaInicial = new TableRow();
                    filaInicial.Cells.Add(cel1);
                    filaInicial.Cells.Add(cel2);
                    filaInicial.Cells.Add(cel3);
                    this.table_horarios.Rows.Add(filaInicial);


                    //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                }
            }

        }

        protected void button_consultarProducto_Click(object sender, EventArgs e)
        {
            String nombreProducto = textbox_nombreProducto.Text;
            String idSucursalActualString = textbox_idSucursalActual.Text;
            String idProductoString = textbox_idProductoConsulta.Text;


            
            if (string.IsNullOrWhiteSpace(idSucursalActualString))
            {
                Response.Write("<script>alert('Ingrese solo uno de los dos campos') </script>");
                return;
            }

            

            // nombre nulo y id no nulo
            if (string.IsNullOrWhiteSpace(nombreProducto) && !string.IsNullOrWhiteSpace(idProductoString) )
            {
                this.conn = (SqlConnection)Session["SQL"];
                int idProducto = Int32.Parse(textbox_idProductoConsulta.Text);
                int idSucursal = Int32.Parse(textbox_idSucursalActual.Text);

                // Procedimiento almacenado
                SqlCommand cmd = new SqlCommand("consultaProductos", conn);
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("@ID_Sucursal", SqlDbType.Int) { Value = idSucursal });
                cmd.Parameters.Add(new SqlParameter("@ID_producto", SqlDbType.Int) { Value = idProducto });
                cmd.Parameters.Add(new SqlParameter("@Nombre_Producto", SqlDbType.VarChar,20) { Value = DBNull.Value });



                String nombreConsultado = "";
                int precioConsultado = 0;
                // byte[] myImage = (byte[])reader["MyImageColumn"];
                byte[] fotoConsultada = null;
                String nombreSucursalConsultada  = "";
                Double distancia = 0.0;
                int idProductoConsultado = 0;

                String lineaConsulta = "";





                dropdownlist_sucursales.Items.Clear();
                ListItem item = new ListItem();
                

                // execute the command
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {
                        idProducto = rdr.GetInt32(0);
                        nombreConsultado = rdr.GetString(1);
                        int precio = (int) rdr.GetSqlMoney(2);
                        fotoConsultada = (byte[]) rdr["Foto"];
                        nombreSucursalConsultada = rdr.GetString(4);
                        distancia = rdr.GetDouble(5);
                        lineaConsulta = "Nombre : " + nombreConsultado + " ID: " + idProducto + " Precio: " + precio + " Nombre Sucursal: " + nombreSucursalConsultada + " Distancia: " + distancia;

                        // Se anaden los valores consultados a la interfaz
                        this.label_precioConsultado.Text = precio.ToString();
                        item = new ListItem();
                        item.Text = lineaConsulta;
                        this.dropdownlist_sucursales.Items.Add(item);

                        string base64String = Convert.ToBase64String(fotoConsultada);
                        this.image_fotoProducto.ImageUrl = String.Format("data:image/jpg;base64,{0}", base64String);



                        //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);

                    }

                    
                    
                }



            }
            else if (string.IsNullOrWhiteSpace(idProductoString) && !string.IsNullOrWhiteSpace(nombreProducto) )
            {
                
            }
            else if( string.IsNullOrWhiteSpace(idProductoString) && string.IsNullOrWhiteSpace(nombreProducto))
            {
                Response.Write("<script>alert('Ingrese el id del producto o el nombre del producto') </script>");
                return;
            }
            else {

                Response.Write("<script>alert('Ingrese solo el id o solo el nombre del producto') </script>");
                return;
            }
        }

        protected void button_consultaEmpleados_Click(object sender, EventArgs e)
        {

            this.conn = (SqlConnection)Session["SQL"];
            String idSucursalString = this.textbox_idSucursalConsultaEmpleado.Text;
            int idSucursal = Int32.Parse(idSucursalString);

            SqlCommand cmd = new SqlCommand("consultaEmpleadosSucursal", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ID_Sucursal", SqlDbType.Int) { Value = idSucursal });



            this.table_horarios.Rows.Clear();
            // Se añaden las filas iniciales de la tabla 
            TableCell cel1 = new TableCell();
            TableCell cel2 = new TableCell();
            TableCell cel3 = new TableCell();
            TableCell cel4 = new TableCell();
            TableCell cel5 = new TableCell();
            TableCell cel6 = new TableCell();

            cel1.Text = "Cedula: ";
            cel2.Text = "Nombre: ";
            cel3.Text = "Primer Apellido: ";
            cel4.Text = "Segundo Apellido Apellido: ";
            cel5.Text = "Celular: ";
            cel6.Text = "Telefono: ";

            TableRow filaInicial = new TableRow();
            filaInicial.Cells.Add(cel1);
            filaInicial.Cells.Add(cel2);
            filaInicial.Cells.Add(cel3);
            filaInicial.Cells.Add(cel4);
            filaInicial.Cells.Add(cel5);
            filaInicial.Cells.Add(cel6);
            this.table_horarios.Rows.Add(filaInicial);


            // Variables de retorno del procedimiento

            int cedula = 0;
            String nombre = "";
            String apellido = "";
            String apellido2 = "";
            int celular = 0;
            int telefono = 0; 


            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                // iterate through results, printing each to console
                while (rdr.Read())
                {
                    label12.Text = " Encontro";
                    cedula = rdr.GetInt32(0);
                    nombre = rdr.GetString(1);
                    apellido = rdr.GetString(2);
                    apellido2 = rdr.GetString(3);
                    celular = rdr.GetInt32(4);
                    telefono = rdr.GetInt32(5);

                     cel1 = new TableCell();
                     cel2 = new TableCell();
                     cel3 = new TableCell();
                     cel4 = new TableCell();
                     cel5 = new TableCell();
                     cel6 = new TableCell(); ;

                    cel1.Text = cedula.ToString();
                    cel2.Text = nombre;
                    cel3.Text = apellido;
                    cel4.Text = apellido2;
                    cel5.Text = celular.ToString();
                    cel6.Text = telefono.ToString();

                    filaInicial = new TableRow();
                    filaInicial.Cells.Add(cel1);
                    filaInicial.Cells.Add(cel2);
                    filaInicial.Cells.Add(cel3);
                    filaInicial.Cells.Add(cel4);
                    filaInicial.Cells.Add(cel5);
                    filaInicial.Cells.Add(cel6);
                    this.table_horarios.Rows.Add(filaInicial);



                    //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);

                }
            }




        }
    }
}