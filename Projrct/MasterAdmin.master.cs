using System;
using System.Web.UI;

public partial class MasterAdmin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Handle logout action for admin
        if (!string.IsNullOrEmpty(Request.QueryString["action"]) && Request.QueryString["action"].ToLower() == "logout")
        {
            AdminLogout();
        }

        // Ensure controls are not null before modifying visibility
        if (adminNav != null)
        {
            // Check if the user is an admin
            bool isAdmin = Session["IsAdmin"] != null && Convert.ToBoolean(Session["IsAdmin"]);

            if (isAdmin)
            {
                adminNav.Visible = true;
            }
            else
            {
                // If the user is not an admin, redirect to the login page
                adminNav.Visible = false;
                Response.Redirect("~/Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }

    // Function to handle admin logout
    private void AdminLogout()
    {
        // Clear admin-specific session variables
        Session.Remove("IsAdmin");

        // Clear all other session variables
        Session.Clear();
        Session.Abandon();

        // Redirect to the login page
        Response.Redirect("~/Default.aspx", false);
        Context.ApplicationInstance.CompleteRequest(); // Prevents thread abort exception
    }
}