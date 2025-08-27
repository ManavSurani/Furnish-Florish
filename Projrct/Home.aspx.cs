using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Cid"] == null)
        {
            // Redirect to login page if the session is not set
            Response.Redirect("~/Default.aspx");
        }
    }
}