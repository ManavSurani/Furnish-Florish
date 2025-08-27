using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class ManageSupplier : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSuppliers(); // Bind the GridView on initial page load
        }
    }

    // Bind suppliers to the GridView
    private void BindSuppliers()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT sid, name, phone, email, address FROM supplier", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        SupplierGridView.DataSource = dt;
                        SupplierGridView.DataBind();
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

    // Open the modal to add a new supplier
    protected void btnAddSupplier_Click(object sender, EventArgs e)
    {
        ClearData(); // Clear form fields
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    // Submit the form to add/update a supplier
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SaveOrUpdateSupplier();
    }

    // Save button click event
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveOrUpdateSupplier();
    }

    // Common method to save or update a supplier
    private void SaveOrUpdateSupplier()
    {
        try
        {
            string name = txtName.Text;
            string phone = txtPhone.Text;
            string email = txtEmail.Text;
            string address = txtAddress.Text;

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query;
                if (string.IsNullOrEmpty(hdnSupplierID.Value))
                {
                    // Insert new supplier
                    query = "INSERT INTO supplier (name, phone, email, address) VALUES (@name, @phone, @email, @address)";
                }
                else
                {
                    // Update existing supplier
                    query = "UPDATE supplier SET name = @name, phone = @phone, email = @email, address = @address WHERE sid = @sid";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@phone", phone);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@address", address);

                    if (!string.IsNullOrEmpty(hdnSupplierID.Value))
                    {
                        cmd.Parameters.AddWithValue("@sid", hdnSupplierID.Value);
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowMessage(string.IsNullOrEmpty(hdnSupplierID.Value) ? "Supplier added successfully." : "Supplier updated successfully.");
            BindSuppliers(); // Refresh the GridView
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
        txtPhone.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtAddress.Text = string.Empty;
        hdnSupplierID.Value = string.Empty;
    }

    // Handle row editing in the GridView
    protected void SupplierGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        string supplierID = SupplierGridView.DataKeys[e.NewEditIndex].Value.ToString();
        hdnSupplierID.Value = supplierID;

        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT name, phone, email, address FROM supplier WHERE sid = @sid", con))
            {
                cmd.Parameters.AddWithValue("@sid", supplierID);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtName.Text = reader["name"].ToString();
                        txtPhone.Text = reader["phone"].ToString();
                        txtEmail.Text = reader["email"].ToString();
                        txtAddress.Text = reader["address"].ToString();
                    }
                }
            }
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    // Handle row deleting in the GridView
    protected void SupplierGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            string supplierID = SupplierGridView.DataKeys[e.RowIndex].Value.ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM supplier WHERE sid = @sid", con))
                {
                    cmd.Parameters.AddWithValue("@sid", supplierID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowMessage("Supplier deleted successfully.");
            BindSuppliers(); // Refresh the GridView
        }
        catch (Exception ex)
        {
            ShowMessage("An error occurred: " + ex.Message, true);
        }
    }
}