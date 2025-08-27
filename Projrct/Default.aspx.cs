using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Clear session on page load if logout action is detected
        if (!string.IsNullOrEmpty(Request.QueryString["action"]) && Request.QueryString["action"].ToLower() == "logout")
        {
            Session.Clear();
            Session.Abandon();
            Session.Remove("IsAdmin");
            Session.Remove("Cid");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = Username.Text.Trim();
        string password = Password.Text.Trim();

        if (username == "admin" && password == "1033")
        {
            ClearTextBoxes();
            Session["IsAdmin"] = true; // Set admin session
            Session.Remove("Cid"); // Ensure regular user session is cleared
            Response.Redirect("~/AHome.aspx");
            Context.ApplicationInstance.CompleteRequest(); // Prevents ThreadAbortException
        }
        else
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT cid FROM login WHERE name = @name AND pass = @pass";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@name", username);
                    cmd.Parameters.AddWithValue("@pass", password);  // Password should be hashed!

                    try
                    {
                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            Session["Cid"] = Convert.ToInt32(result); // Store user ID in session
                            Session.Remove("IsAdmin"); // Ensure admin session is cleared
                            ClearTextBoxes();

                            // Show success message and redirect
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Login Successful!');", true);
                            Response.Redirect("~/Home.aspx");
                            Context.ApplicationInstance.CompleteRequest(); // Prevents ThreadAbortException
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid Username or Password.');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log the error (avoid exposing technical details to the user)
                        System.Diagnostics.Debug.WriteLine("Login Error: " + ex.Message);
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred. Please try again later.');", true);
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }
    }

    private void ClearTextBoxes()
    {
        Username.Text = "";
        Password.Text = "";
    }
}