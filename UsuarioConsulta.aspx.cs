﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LicoreraWeb
{
    public partial class UsuarioConsulta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void button_volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Logging.aspx");
        }
    }
}