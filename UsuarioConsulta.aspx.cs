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
        }
    }
}