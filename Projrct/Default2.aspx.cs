using System;
using System.Web.UI;
using System.Configuration;
using System.Data.SqlClient;

public partial class _Default2 : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Code to execute on page load
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        // Get the connection string from Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO login (name, email, pass, phone, addr, city, state, pin) " +
                           "VALUES (@name, @email, @pass, @phone, @addr, @city, @state, @pin)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                // Use precise parameterized queries instead of AddWithValue
                cmd.Parameters.Add(new SqlParameter("@name", Username.Text.Trim()));
                cmd.Parameters.Add(new SqlParameter("@email", Email.Text.Trim()));
                cmd.Parameters.Add(new SqlParameter("@pass", ConfirmPassword.Text.Trim())); // No hashing here
                cmd.Parameters.Add(new SqlParameter("@phone", PhoneNumber.Text.Trim()));
                cmd.Parameters.Add(new SqlParameter("@addr", Address.Text.Trim()));
                cmd.Parameters.Add(new SqlParameter("@city", City.Text.Trim()));
                cmd.Parameters.Add(new SqlParameter("@state", State.Text.Trim()));
                cmd.Parameters.Add(new SqlParameter("@pin", Pincode.Text.Trim()));

                try
                {
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Registration Successful!');", true);
                        ClearTextBoxes(); // Clear the textboxes after successful registration
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Registration Failed. Please try again.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred. Please try again later.');", true);
                }
            }
        }
    }

    private void ClearTextBoxes()
    {
        Username.Text = string.Empty;
        Email.Text = string.Empty;
        Password.Text = string.Empty;
        ConfirmPassword.Text = string.Empty;
        PhoneNumber.Text = string.Empty;
        Address.Text = string.Empty;
        City.Text = string.Empty;
        State.Text = string.Empty;
        Pincode.Text = string.Empty;
    }
}
