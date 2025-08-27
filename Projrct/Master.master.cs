using System;
using System.Web.UI;

public partial class Master : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Handle logout action for regular users
        if (!string.IsNullOrEmpty(Request.QueryString["action"]) && Request.QueryString["action"].ToLower() == "logout")
        {
            UserLogout();
        }

        // Ensure controls are not null before modifying visibility
        if (userNev != null)
        {
            // Check if the user is logged in (regular user)
            bool isUserLoggedIn = Session["Cid"] != null;

            if (isUserLoggedIn)
            {
                userNev.Visible = true;
            }
            else
            {
                // If the user is not logged in, hide the navigation and redirect to the login page
                userNev.Visible = false;
                Response.Redirect("~/Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }

    // Function to handle user logout
    private void UserLogout()
    {
        // Clear user-specific session variables
        Session.Remove("Cid");

        // Clear all other session variables
        Session.Clear();
        Session.Abandon();

        // Redirect to the login page
        Response.Redirect("~/Default.aspx", false);
        Context.ApplicationInstance.CompleteRequest(); // Prevents thread abort exception
    }
}