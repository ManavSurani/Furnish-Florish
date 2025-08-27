using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class ManageUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindUsers(); // Bind the GridView on initial page load
        }
    }

    // Bind users to the GridView
    private void BindUsers()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT cid, name, email, phone, addr, city, state, pin FROM login", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        UserGridView.DataSource = dt;
                        UserGridView.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage("An error occurred: " + ex.Message, true);
        }
    }

    // Show a message to the user
    private void ShowMessage(string message, bool isError = false)
    {
        MessageLabel.Text = message;
        MessageLabel.CssClass = isError ? "message-label error" : "message-label success";
        MessageLabel.Visible = true;
    }

    // Open the modal to add a new user
    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        ClearData(); // Clear form fields
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    // Submit the form to add/update a user
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SaveOrUpdateUser();
    }

    // Save button click event
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveOrUpdateUser();
    }

    // Common method to save or update a user
    private void SaveOrUpdateUser()
    {
        try
        {
            string name = txtName.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string phone = txtPhone.Text;
            string address = txtAddress.Text;
            string city = txtCity.Text;
            string state = txtState.Text;
            string pin = txtPin.Text;

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query;
                if (string.IsNullOrEmpty(hdnUserID.Value))
                {
                    // Insert new user
                    query = "INSERT INTO login (name, email, pass, phone, addr, city, state, pin) VALUES (@name, @email, @pass, @phone, @addr, @city, @state, @pin)";
                }
                else
                {
                    // Update existing user
                    query = "UPDATE login SET name = @name, email = @email, pass = @pass, phone = @phone, addr = @addr, city = @city, state = @state, pin = @pin WHERE cid = @cid";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@pass", password);
                    cmd.Parameters.AddWithValue("@phone", phone);
                    cmd.Parameters.AddWithValue("@addr", address);
                    cmd.Parameters.AddWithValue("@city", city);
                    cmd.Parameters.AddWithValue("@state", state);
                    cmd.Parameters.AddWithValue("@pin", pin);

                    if (!string.IsNullOrEmpty(hdnUserID.Value))
                    {
                        cmd.Parameters.AddWithValue("@cid", hdnUserID.Value);
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowMessage(string.IsNullOrEmpty(hdnUserID.Value) ? "User added successfully." : "User updated successfully.");
            BindUsers(); // Refresh the GridView
            ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
            ClearData(); // Clear form fields
        }
        catch (Exception ex)
        {
            ShowMessage("An error occurred: " + ex.Message, true);
        }
    }

    // Reset the form
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearData();
    }

    // Clear form data
    private void ClearData()
    {
        txtName.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtPassword.Text = string.Empty;
        txtPhone.Text = string.Empty;
        txtAddress.Text = string.Empty;
        txtCity.Text = string.Empty;
        txtState.Text = string.Empty;
        txtPin.Text = string.Empty;
        hdnUserID.Value = string.Empty;
    }

    // Handle row editing in the GridView
    protected void UserGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        string userID = UserGridView.DataKeys[e.NewEditIndex].Value.ToString();
        hdnUserID.Value = userID;

        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT name, email, pass, phone, addr, city, state, pin FROM login WHERE cid = @cid", con))
            {
                cmd.Parameters.AddWithValue("@cid", userID);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtName.Text = reader["name"].ToString();
                        txtEmail.Text = reader["email"].ToString();
                        txtPassword.Text = reader["pass"].ToString();
                        txtPhone.Text = reader["phone"].ToString();
                        txtAddress.Text = reader["addr"].ToString();
                        txtCity.Text = reader["city"].ToString();
                        txtState.Text = reader["state"].ToString();
                        txtPin.Text = reader["pin"].ToString();
                    }
                }
            }
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    // Handle row deleting in the GridView
    protected void UserGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            string userID = UserGridView.DataKeys[e.RowIndex].Value.ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM login WHERE cid = @cid", con))
                {
                    cmd.Parameters.AddWithValue("@cid", userID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowMessage("User deleted successfully.");
            BindUsers(); // Refresh the GridView
        }
        catch (Exception ex)
        {
            ShowMessage("An error occurred: " + ex.Message, true);
        }
    }
}