using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class ManageOrders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindOrders(); // Bind orders to GridView
        }
    }

    // Bind orders to the GridView
    private void BindOrders()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT OrderID, CustomerID, OrderDate, ProductName, TotalAmount, Status 
                             FROM Orders";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                OrderGridView.DataSource = reader;
                OrderGridView.DataBind();
            }
        }
    }

    // Edit button click event in GridView
    protected void OrderGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        // Get the OrderID from the DataKey
        int orderID = Convert.ToInt32(OrderGridView.DataKeys[e.NewEditIndex].Value);
        hdnOrderID.Value = orderID.ToString();
        lblModalTitle.Text = "Edit Order";

        // Fetch the order details and populate the form
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT Status FROM Orders WHERE OrderID = @OrderID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@OrderID", orderID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    ddlStatus.SelectedValue = reader["Status"].ToString();
                }
            }
        }

        // Show the modal for editing
        ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "showModal();", true);
    }

    // Save button click event (for editing order status)
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Orders SET Status = @Status WHERE OrderID = @OrderID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@OrderID", Convert.ToInt32(hdnOrderID.Value));
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Refresh the GridView and close the modal
            BindOrders();
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", "closeModal();", true);
            ShowMessage("Order updated successfully!");
            Response.Redirect("~/ManageOrders.aspx");
        }
    }

    // Reset button click event
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddlStatus.SelectedIndex = 0;
    }

    // Delete button click event in GridView
    protected void OrderGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        // Get the OrderID from the DataKey
        int orderID = Convert.ToInt32(OrderGridView.DataKeys[e.RowIndex].Value);

        // Delete the order
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "DELETE FROM Orders WHERE OrderID = @OrderID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@OrderID", orderID);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Refresh the GridView
        BindOrders();
        ShowMessage("Order deleted successfully!");
    }

    // Show a message to the user
    private void ShowMessage(string message, bool isError = false)
    {
        MessageLabel.Text = message;
        MessageLabel.CssClass = isError ? "message-label error" : "message-label success";
        MessageLabel.Visible = true;
    }
}