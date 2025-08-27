using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls; // Add this line

public partial class Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Bind dropdowns and GridView on initial load
            BindOrderIDDropdown();
            BindCustomerIDDropdown();
            BindOrders();
        }
    }

    // Bind Order ID dropdown
    private void BindOrderIDDropdown()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT DISTINCT OrderID FROM Orders";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlOrderID.DataSource = reader;
                ddlOrderID.DataTextField = "OrderID";
                ddlOrderID.DataValueField = "OrderID";
                ddlOrderID.DataBind();
            }
        }
        ddlOrderID.Items.Insert(0, new ListItem("All", "0"));
    }

    // Bind Customer ID dropdown
    private void BindCustomerIDDropdown()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT DISTINCT CustomerID FROM Orders";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlCustomerID.DataSource = reader;
                ddlCustomerID.DataTextField = "CustomerID";
                ddlCustomerID.DataValueField = "CustomerID";
                ddlCustomerID.DataBind();
            }
        }
        ddlCustomerID.Items.Insert(0, new ListItem("All", "0"));
    }

    // Bind Orders to GridView based on filters
    private void BindOrders()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT OrderID, CustomerID, ProductName, OrderDate, TotalAmount, Status 
                             FROM Orders 
                             WHERE (@OrderID = 0 OR OrderID = @OrderID)
                               AND (@CustomerID = 0 OR CustomerID = @CustomerID)
                               AND (@Status = '' OR Status = @Status)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@OrderID", Convert.ToInt32(ddlOrderID.SelectedValue));
                cmd.Parameters.AddWithValue("@CustomerID", Convert.ToInt32(ddlCustomerID.SelectedValue));
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                OrderGridView.DataSource = dt;
                OrderGridView.DataBind();
            }
        }
    }

    // Event handler for Order ID dropdown change
    protected void ddlOrderID_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindOrders();
    }

    // Event handler for Customer ID dropdown change
    protected void ddlCustomerID_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindOrders();
    }

    // Event handler for Status dropdown change
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindOrders();
    }

    // Event handler for View button click
    protected void btnView_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string orderID = btn.CommandArgument;
        Response.Redirect("OrderView.aspx?OrderID=" + orderID);
    }
}