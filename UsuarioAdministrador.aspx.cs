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
            ConsultarProcedencia();
            ConsultarTipoAnnejado();
        }

        protected void button_consultarVentas_Click(object sender, EventArgs e)
        {


            this.conn = (SqlConnection)Session["SQL"];

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
        

        protected void ConsultarTipoAnnejado()
        {

            this.conn = (SqlConnection)Session["SQL"];
            SqlCommand cmd = new SqlCommand("seleccionarTipoAnnejado", conn);


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ID_Annejado", SqlDbType.Int) { Value = DBNull.Value });
            cmd.Parameters.Add(new SqlParameter("@Nombre_Annejado", SqlDbType.VarChar, 25) { Value = DBNull.Value });
            
            // execute the command
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                String idTipoConsultadoString = "";
                String nombreTipoConsultadoString = "";
                int idTipo = 0;
                ListItem item = new ListItem();


                while (rdr.Read())
                {

                    idTipo = rdr.GetInt32(0);
                    idTipoConsultadoString = idTipo.ToString();
                    nombreTipoConsultadoString = rdr.GetString(1);

                    item = new ListItem();
                    item.Value = idTipoConsultadoString;
                    item.Text = nombreTipoConsultadoString;
                    this.dropdownlist_tipoAnejado.Items.Add(item);
                    //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                }
            }


        }
        protected void ConsultarProcedencia()
        {


            this.conn = (SqlConnection)Session["SQL"];
            SqlCommand cmd = new SqlCommand("seleccionarLugarProcedencia", conn);


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ID_Lugar", SqlDbType.Int, 10) { Value = DBNull.Value });
            cmd.Parameters.Add(new SqlParameter("@Nombre_lugar", SqlDbType.VarChar, 25) { Value = DBNull.Value });

            // execute the command
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                String idLugarConsultadoString = "";
                String nombreLugarConsultadoString = "";
                int idLugar = 0;
                ListItem item = new ListItem();
                

                while (rdr.Read())
                {

                    idLugar = rdr.GetInt32(0);
                    idLugarConsultadoString = idLugar.ToString();
                    nombreLugarConsultadoString = rdr.GetString(1);

                    item = new ListItem();
                    item.Value = idLugarConsultadoString;
                    item.Text = nombreLugarConsultadoString;
                    this.dropdownlist_paisNuevoProducto.Items.Add(item);
                    //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
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


                    String idSucursalString= this.textbox_idSucursalConsultaMasVendidos.Text;
                    String nombreSucursalString = this.textbox_nombreSucursalMasMenosVendido.Text;
                    this.conn = (SqlConnection)Session["SQL"];


                    // id nulo, nombre no nulo 
                    if (string.IsNullOrWhiteSpace(idSucursalString) && !string.IsNullOrWhiteSpace(nombreSucursalString))
                    {

                        SqlCommand cmd1 = new SqlCommand("productos_mas_vendidos", conn);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.Add(new SqlParameter("@ID_sucursal", SqlDbType.Int) { Value = DBNull.Value });
                        cmd1.Parameters.Add(new SqlParameter("@Nombre_sucursal", SqlDbType.VarChar, 20) { Value = nombreSucursalString });

                        // execute the command
                        using (SqlDataReader rdr = cmd1.ExecuteReader())
                        {
                            // iterate through results, printing each to console
                            this.table_consultas.Rows.Clear();

                            // Se añaden las filas iniciales de la tabla 
                            TableCell cel1 = new TableCell();
                            TableCell cel2 = new TableCell();
                            TableCell cel3 = new TableCell();
                            TableCell cel4 = new TableCell();

                            cel1.Text = "ID";
                            cel2.Text = "Nombre";
                            cel3.Text = "Precio";
                            cel4.Text = "Cantidad";
                            TableRow filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            filaInicial.Cells.Add(cel4);

                            this.table_consultas.Rows.Add(filaInicial);

                            ///prueba 
                            //
                            /*
                             cel1 = new TableCell();
                             cel2 = new TableCell();
                             cel3 = new TableCell();
                             cel4 = new TableCell();

                            cel1.Text = "Ijose";
                            cel2.Text = "juan";
                            cel3.Text = "jeje";
                            cel4.Text = "hola";
                            filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            filaInicial.Cells.Add(cel4);

                            this.table_consultas.Rows.Add(filaInicial);

                            */
                            // fin prueba


                            int id = 0;
                            String nombre = "";
                            int precio = 0;
                            int cantidad = 0;


                            while (rdr.Read())
                            {

                                id = rdr.GetInt32(0);
                                nombre = rdr.GetString(1);
                                precio = rdr.GetInt32(2);
                                cantidad = rdr.GetInt32(3);

                                cel1.Text = id.ToString();
                                cel2.Text = nombre;
                                cel3.Text = precio.ToString();
                                cel4.Text = cantidad.ToString();
                                filaInicial = new TableRow();
                                filaInicial.Cells.Add(cel1);
                                filaInicial.Cells.Add(cel2);
                                filaInicial.Cells.Add(cel3);
                                filaInicial.Cells.Add(cel4);
                                this.table_consultas.Rows.Add(filaInicial);

                                //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                            }
                        }


                    }
                    // nombre nulo , id no nulo 
                    else if (string.IsNullOrWhiteSpace(nombreSucursalString) && !string.IsNullOrWhiteSpace(idSucursalString))
                    {

                        int idSucursal = Int32.Parse(idSucursalString);
                        SqlCommand cmd2 = new SqlCommand("productos_mas_vendidos", conn);
                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.Add(new SqlParameter("@ID_sucursal", SqlDbType.Int) { Value = idSucursal });
                        cmd2.Parameters.Add(new SqlParameter("@Nombre_sucursal", SqlDbType.VarChar, 20) { Value = DBNull.Value });


                        // execute the command
                        using (SqlDataReader rdr = cmd2.ExecuteReader())
                        {
                            // iterate through results, printing each to console


                            this.table_consultas.Rows.Clear();

                            // Se añaden las filas iniciales de la tabla 
                            TableCell cel1 = new TableCell();
                            TableCell cel2 = new TableCell();
                            TableCell cel3 = new TableCell();
                            TableCell cel4 = new TableCell();
                            cel1.Text = "ID";
                            cel2.Text = "Nombre";
                            cel3.Text = "Precio";
                            cel4.Text = "Cantidad";
                            TableRow filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            filaInicial.Cells.Add(cel4);

                            this.table_consultas.Rows.Add(filaInicial);

                            /*
                            // Prueba
                            cel1 = new TableCell();
                            cel2 = new TableCell();
                            cel3 = new TableCell();
                            cel4 = new TableCell();

                            cel1.Text = "Ijose";
                            cel2.Text = "juan";
                            cel3.Text = "jeje";
                            cel4.Text = "hola";
                            filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            filaInicial.Cells.Add(cel4);

                            this.table_consultas.Rows.Add(filaInicial);
                            // fin prueba
                            */


                            int id = 0;
                            String nombre = "";
                            int precio = 0;
                            int cantidad = 0;


                            while (rdr.Read())
                            {

                                id = rdr.GetInt32(0);
                                nombre = rdr.GetString(1);
                                precio = rdr.GetInt32(2);
                                cantidad = rdr.GetInt32(3);

                                cel1.Text = id.ToString();
                                cel2.Text = nombre;
                                cel3.Text = precio.ToString();
                                cel4.Text = cantidad.ToString();
                                filaInicial = new TableRow();
                                filaInicial.Cells.Add(cel1);
                                filaInicial.Cells.Add(cel2);
                                filaInicial.Cells.Add(cel3);
                                filaInicial.Cells.Add(cel4);
                                this.table_consultas.Rows.Add(filaInicial);

                                //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                            }


                        }
                    }
                    else if(!string.IsNullOrWhiteSpace(nombreSucursalString) && !string.IsNullOrWhiteSpace(idSucursalString))
                    {
                        Response.Write("<script>alert('Ingrese solo uno de los dos campos') </script>");
                        return;
                    }
                    else
                    {
                        Response.Write("<script>alert('Ingrese solo uno de los dos campos') </script>");
                        return;

                    }
                    break;

                case "1": // Global

                    SqlCommand cmd = new SqlCommand("productos_mas_vendidos", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@ID_sucursal", SqlDbType.Int) { Value = DBNull.Value });
                    cmd.Parameters.Add(new SqlParameter("@Nombre_sucursal", SqlDbType.VarChar, 20) { Value = DBNull.Value });

                    // execute the command
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        // iterate through results, printing each to console
                        this.table_consultas.Rows.Clear();


                        // Se añaden las filas iniciales de la tabla 
                        TableCell cel1 = new TableCell();
                        TableCell cel2 = new TableCell();
                        TableCell cel3 = new TableCell();
                        TableCell cel4 = new TableCell();
                        cel1.Text = "ID";
                        cel2.Text = "Nombre";
                        cel3.Text = "Precio";
                        cel4.Text = "Cantidad";
                        TableRow filaInicial = new TableRow();
                        filaInicial.Cells.Add(cel1);
                        filaInicial.Cells.Add(cel2);
                        filaInicial.Cells.Add(cel3);
                        filaInicial.Cells.Add(cel4);
                        //this.table_consultas.Rows.Add(filaInicial);
                        table_consultas.Rows.AddAt(0, filaInicial);

                        int id = 0;
                        String nombre = "";
                        int precio = 0;
                        int cantidad = 0;


                        while (rdr.Read())
                        {

                            id = rdr.GetInt32(0);
                            nombre = rdr.GetString(1);
                            precio = rdr.GetInt32(2);
                            cantidad = rdr.GetInt32(3);

                            cel1.Text = id.ToString();
                            cel2.Text = nombre;
                            cel3.Text = precio.ToString();
                            cel4.Text = cantidad.ToString();
                            filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            filaInicial.Cells.Add(cel4);
                            this.table_consultas.Rows.Add(filaInicial);

                            //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                        }
                    }
                    break;

            }
        }

        protected void Button4_Click(object sender, EventArgs e)  // Boton Aquellos Sin Salida
        {
            String opcinAquellosSinSalida = this.radiobuttonlist_productosMasVendidos.SelectedValue;

            switch (opcinAquellosSinSalida)
            {
                case "0": // Por sucursal
                    String idsucursalString = this.textbox_idSucursalConsultaMasVendidos.Text;
                    String nombreSucursalString = this.textbox_idSucursalConsultaMasVendidos.Text;

                    // id nulo, nombre sucursal no 
                    if (string.IsNullOrWhiteSpace(idsucursalString) && !string.IsNullOrWhiteSpace(nombreSucursalString))
                    {

                        SqlCommand cmd6 = new SqlCommand("productos_no_vendidos", conn);
                        cmd6.CommandType = CommandType.StoredProcedure;
                        cmd6.Parameters.Add(new SqlParameter("@ID_sucursal", SqlDbType.Int) { Value = DBNull.Value });
                        cmd6.Parameters.Add(new SqlParameter("@Nombre_sucursal", SqlDbType.VarChar, 20) { Value = nombreSucursalString });

                        // execute the command
                        using (SqlDataReader rdr = cmd6.ExecuteReader())
                        {
                            // iterate through results, printing each to console

                            this.table_consultas.Rows.Clear();
                            // Se añaden las filas iniciales de la tabla 
                            TableCell cel1 = new TableCell();
                            TableCell cel2 = new TableCell();
                            TableCell cel3 = new TableCell();
                            TableCell cel4 = new TableCell();
                            cel1.Text = "ID";
                            cel2.Text = "Nombre";
                            cel3.Text = "Precio";
                            TableRow filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            //this.table_consultas.Rows.Add(filaInicial);
                            this.table_consultas.Rows.AddAt(0, filaInicial);

                            int id = 0;
                            String nombre = "";
                            int precio = 0;


                            while (rdr.Read())
                            {

                                id = rdr.GetInt32(0);
                                nombre = rdr.GetString(1);
                                precio = rdr.GetInt32(2);

                                cel1.Text = id.ToString();
                                cel2.Text = nombre;
                                cel3.Text = precio.ToString();
                                filaInicial = new TableRow();
                                filaInicial.Cells.Add(cel1);
                                filaInicial.Cells.Add(cel2);
                                filaInicial.Cells.Add(cel3);
                                this.table_consultas.Rows.Add(filaInicial);

                                //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                            }


                        }



                    
                    }

                    // nombre nulo, id no 
                    else if (string.IsNullOrWhiteSpace(nombreSucursalString) && !string.IsNullOrWhiteSpace(idsucursalString))
                    {

                        int idSucursal = Int32.Parse(idsucursalString);
                        SqlCommand cmd5 = new SqlCommand("productos_no_vendidos", conn);
                        cmd5.CommandType = CommandType.StoredProcedure;
                        cmd5.Parameters.Add(new SqlParameter("@ID_sucursal", SqlDbType.Int) { Value = idSucursal });
                        cmd5.Parameters.Add(new SqlParameter("@Nombre_sucursal", SqlDbType.VarChar, 20) { Value = DBNull.Value});

                        // execute the command
                        using (SqlDataReader rdr = cmd5.ExecuteReader())
                        {
                            // iterate through results, printing each to console

                            this.table_consultas.Rows.Clear();
                            // Se añaden las filas iniciales de la tabla 
                            TableCell cel1 = new TableCell();
                            TableCell cel2 = new TableCell();
                            TableCell cel3 = new TableCell();
                            cel1.Text = "ID";
                            cel2.Text = "Nombre";
                            cel3.Text = "Precio";
                            TableRow filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            this.table_consultas.Rows.Add(filaInicial);

                            int id = 0;
                            String nombre = "";
                            int precio = 0;


                            while (rdr.Read())
                            {

                                id = rdr.GetInt32(0);
                                nombre = rdr.GetString(1);
                                precio = rdr.GetInt32(2);

                                cel1.Text = id.ToString();
                                cel2.Text = nombre;
                                cel3.Text = precio.ToString();
                                filaInicial = new TableRow();
                                filaInicial.Cells.Add(cel1);
                                filaInicial.Cells.Add(cel2);
                                filaInicial.Cells.Add(cel3);
                                this.table_consultas.Rows.Add(filaInicial);

                                //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                            }


                        }

                    }
                    // ambos nulos 
                    else if (string.IsNullOrWhiteSpace(nombreSucursalString) && string.IsNullOrWhiteSpace(idsucursalString))
                    {
                        Response.Write("<script>alert('Ingrese  uno de los dos campos') </script>");
                        return;
                    }
                    // ambos llenos
                    else
                    {
                        Response.Write("<script>alert('Ingrese solo uno de los dos campos') </script>");
                        return;

                    }

                    break;
                case "1": // Global

                    SqlCommand cmd = new SqlCommand("productos_no_vendidos", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@ID_sucursal", SqlDbType.Int) { Value = DBNull.Value });
                    cmd.Parameters.Add(new SqlParameter("@Nombre_sucursal", SqlDbType.VarChar, 20) { Value = DBNull.Value });

                    // execute the command
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        // iterate through results, printing each to console

                        this.table_consultas.Rows.Clear();
                        // Se añaden las filas iniciales de la tabla 
                        TableCell cel1 = new TableCell();
                        TableCell cel2 = new TableCell();
                        TableCell cel3 = new TableCell();
                        cel1.Text = "ID";
                        cel2.Text = "Nombre";
                        cel3.Text = "Precio";
                        TableRow filaInicial = new TableRow();
                        filaInicial.Cells.Add(cel1);
                        filaInicial.Cells.Add(cel2);
                        filaInicial.Cells.Add(cel3);
                        this.table_consultas.Rows.Add(filaInicial);

                        int id = 0;
                        String nombre = "";
                        int precio = 0;


                        while (rdr.Read())
                        {

                            id = rdr.GetInt32(0);
                            nombre = rdr.GetString(1);
                            precio = rdr.GetInt32(2);

                            cel1.Text = id.ToString();
                            cel2.Text = nombre;
                            cel3.Text = precio.ToString();
                            filaInicial = new TableRow();
                            filaInicial.Cells.Add(cel1);
                            filaInicial.Cells.Add(cel2);
                            filaInicial.Cells.Add(cel3);
                            this.table_consultas.Rows.Add(filaInicial);

                            //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                        }


                    }


                    break;

            }
        }

        protected void Button1_Click(object sender, EventArgs e) // Consultar Precio Producto
        {

            this.conn = (SqlConnection)Session["SQL"];
            //conn.Open();
            String nombreProcedimiento = "consultarPrecio";
            SqlCommand cmd = new SqlCommand(nombreProcedimiento, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            // Variables de interfaz

            String nombreProducto = this.textbox_nombrePConsulta.Text;
            String idProducto_String = this.textbox_idPConsulta.Text;

            //int idSucursal = Int32.Parse(this.textbox_idSucursalConsultaPrecio.Text);
            // int idProducto = Int32.Parse(this.textbox_idPConsulta.Text);

            System.Text.RegularExpressions.Regex.IsMatch(textbox_idPConsulta.Text, "[ ^ 0-9]");

            // Parametros de Procedimiento 

            // Si el id de producto esta vacio y el nombre no
            if (string.IsNullOrWhiteSpace(this.textbox_idPConsulta.Text) && !string.IsNullOrWhiteSpace(this.textbox_nombrePConsulta.Text))
            {
                cmd.Parameters.Add(new SqlParameter("@nombre", SqlDbType.VarChar, 20) { Value = nombreProducto });
                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int) { Value = DBNull.Value });
            }
            // Si el nombre de producto esta vacio y el id no
            else if (string.IsNullOrWhiteSpace(this.textbox_nombrePConsulta.Text) && !string.IsNullOrWhiteSpace(this.textbox_idPConsulta.Text))
            {
                int idproducto = Int32.Parse(idProducto_String);
                cmd.Parameters.Add(new SqlParameter("@nombre", SqlDbType.VarChar, 20) { Value = DBNull.Value });
                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int) { Value = idproducto });
            }
            // Ninguno vacio
            else if (!string.IsNullOrWhiteSpace(this.textbox_nombrePConsulta.Text) && !string.IsNullOrWhiteSpace(this.textbox_idPConsulta.Text))
            {
                Response.Write("<script>alert('Ingrese solo uno de los dos campos') </script>");
                return;
            }
            else // ambos vacios
            {
                Response.Write("<script>alert('Ingrese el id o el nombre de producto') </script>");

            }





            // execute the command
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                int precio = 0;
                // iterate through results, printing each to console
                while (rdr.Read())
                {
                    //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                    precio = (int) rdr.GetSqlMoney(0);
                    this.label_precioConsultado.Text = precio.ToString();
                }
            }


        }

        protected void button_cargarImagen_Click(object sender, EventArgs e)
        {
            if (this.fileupload_imagenNuevoProducto.HasFile)
            {
                this.fileupload_imagenNuevoProducto.SaveAs("c:\\" + this.fileupload_imagenNuevoProducto.FileName);
            }

        }

        protected void Button3_Click(object sender, EventArgs e) // Ingresar Producto Nuevo

        {
            this.conn = (SqlConnection)Session["SQL"];

            String nombreProducto = this.textbox_nombreNuevoProducto.Text;
            int anho = Int32.Parse(this.textbox_anhoCosecha.Text);
            int precio = Int32.Parse(textbox_precioIngresarNuevoProducto.Text);
            int procedencia = Int32.Parse(this.dropdownlist_paisNuevoProducto.SelectedValue);
            int idnnejado = Int32.Parse(dropdownlist_paisNuevoProducto.SelectedValue);
            int idProcedendia = Int32.Parse(this.dropdownlist_paisNuevoProducto.SelectedValue);



            int length = fileupload_imagenNuevoProducto.PostedFile.ContentLength;
            byte[] picSize = new byte[length];
            HttpPostedFile uplImage = fileupload_imagenNuevoProducto.PostedFile;
            uplImage.InputStream.Read(picSize, 0, length);
            // com.Parameters.AddWithValue("@Picture", picSize); 


            // Procedimiento Almacenado
            SqlCommand cmd = new SqlCommand("insertarProducto", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@id_annejado", SqlDbType.Int) { Value = idnnejado });
            cmd.Parameters.Add(new SqlParameter("@ID_procedencia", SqlDbType.Int) { Value = idProcedendia });
            cmd.Parameters.Add(new SqlParameter("@nombre", SqlDbType.VarChar, 20) { Value = nombreProducto });
            cmd.Parameters.Add(new SqlParameter("@anno_cosecha", SqlDbType.Int) { Value = anho });
            cmd.Parameters.Add(new SqlParameter("@precio", SqlDbType.Money) { Value = precio });
            cmd.Parameters.Add(new SqlParameter("@foto", SqlDbType.VarBinary,-1) { Value = picSize });

            // execute the command
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                // iterate through results, printing each to console
                while (rdr.Read())
                {
                    int resultado = rdr.GetInt32(0);
                    if(resultado == 1)
                    {
                        Response.Write("<script>alert('Nuevo Producto ingresado') </script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Error en el ingreso del nuevo producto') </script>");
                    }

                    //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                }
            }






        }

        protected void textbox_idPConsulta_TextChanged(object sender, EventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(this.textbox_idPConsulta.Text, "  ^ [0-9]"))
            {
                textbox_idPConsulta.Text = "";
            }

        }

        protected void Button2_Click(object sender, EventArgs e) // Actualizar precio
        {
            String idProductoString = this.textbox_idPActualizar.Text;
            String precioString = this.textbox_nuevoPrecio.Text;

            if (string.IsNullOrWhiteSpace(idProductoString) && !string.IsNullOrWhiteSpace(precioString))
            {
                Response.Write("<script>alert('Ingrese el id del Producto') </script>");
                return;
            }
            else if (string.IsNullOrWhiteSpace(precioString) && !string.IsNullOrWhiteSpace(idProductoString))
            {
                Response.Write("<script>alert('Ingrese el precio del Producto') </script>");
                return;
            }
            else if (string.IsNullOrWhiteSpace(precioString) && string.IsNullOrWhiteSpace(idProductoString))
            {
                Response.Write("<script>alert('Ingrese el id y el precio del producto') </script>");
                return;
            }

            else
            {

                // Procedimiento almacenado 
                this.conn = (SqlConnection)Session["SQL"];
                SqlCommand cmd = new SqlCommand("actualizarPrecio", conn);
                cmd.CommandType = CommandType.StoredProcedure;


                // Parametros de procedimiento 
                int idProducto = Int32.Parse(idProductoString);
                int precio = Int32.Parse(precioString);

                cmd.Parameters.Add(new SqlParameter("@id", SqlDbType.Int) { Value = idProducto });
                cmd.Parameters.Add(new SqlParameter("@precio", SqlDbType.Money) { Value = precio });

                // execute the command
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    // iterate through results, printing each to console
                    while (rdr.Read())
                    {
                        //Console.WriteLine("Product: {0,-35} Total: {1,2}", rdr["ProductName"], rdr["Total"]);
                        int respuesta = rdr.GetInt32(0);
                        if (respuesta == 1)
                        {

                        }
                        else
                        {
                            Response.Write("<script>alert('Error en la actualizacion') </script>");
                        }
                    }


                }

            }
        }

        protected void button_siguiente_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Administrador2.aspx");
        }
    }
}

            
