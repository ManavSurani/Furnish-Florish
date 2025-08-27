using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class AHome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Fetch and display the total users count
            lblTotalUsers.Text = GetTotalUsersCount().ToString();

            // Fetch and display the total products count
            lblTotalProducts.Text = GetTotalProductsCount().ToString();

            // Fetch and display the total orders count
            lblTotalOrders.Text = GetTotalOrdersCount().ToString();

            // Fetch and display the total revenue
            lblRevenue.Text = GetTotalRevenue().ToString("C"); // Format as currency
        }
    }

    private int GetTotalUsersCount()
    {
        int totalUsers = 0;
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(cid) FROM login"; // Query to count users
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    totalUsers = Convert.ToInt32(cmd.ExecuteScalar()); // Execute the query
                }
            }
        }
        catch (Exception ex)
        {
            // Log the error or display a message
            lblTotalUsers.Text = "Error";
        }

        return totalUsers;
    }

    private int GetTotalProductsCount()
    {
        int totalProducts = 0;
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(ProductId) FROM product"; // Query to count products
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    totalProducts = Convert.ToInt32(cmd.ExecuteScalar()); // Execute the query
                }
            }
        }
        catch (Exception ex)
        {
            // Log the error or display a message
            lblTotalProducts.Text = "Error";
        }

        return totalProducts;
    }

    private int GetTotalOrdersCount()
    {
        int totalOrders = 0;
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(OrderID) FROM Orders"; // Query to count orders
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    totalOrders = Convert.ToInt32(cmd.ExecuteScalar()); // Execute the query
                }
            }
        }
        catch (Exception ex)
        {
            // Log the error or display a message
            lblTotalOrders.Text = "Error";
        }

        return totalOrders;
    }

    private decimal GetTotalRevenue()
    {
        decimal totalRevenue = 0;
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT SUM(TotalAmount) FROM Orders"; // Query to calculate total revenue
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != DBNull.Value)
                    {
                        totalRevenue = Convert.ToDecimal(result); // Execute the query
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log the error or display a message
            lblRevenue.Text = "Error";
        }

        return totalRevenue;
    }
}