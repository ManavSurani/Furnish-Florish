using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class OrderView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["OrderID"] != null)
            {
                int orderId;
                if (int.TryParse(Request.QueryString["OrderID"], out orderId))
                {
                    LoadOrderDetails(orderId);
                }
                else
                {
                    ShowError("Invalid Order ID.");
                }
            }
            else
            {
                ShowError("No Order ID provided.");
            }
        }
    }

    private void LoadOrderDetails(int orderId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        int customerId = -1; // Store CustomerID

        // Step 1: Fetch Order Details & CustomerID
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string orderQuery = "SELECT CustomerID, ProductName, Quantity, Price, TotalAmount FROM Orders WHERE OrderID = @OrderID";
            using (SqlCommand cmd = new SqlCommand(orderQuery, con))
            {
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        customerId = Convert.ToInt32(dt.Rows[0]["CustomerID"]); // Store CustomerID
                    }

                    OrderGridView.DataSource = dt;
                    OrderGridView.DataBind();

                    // Calculate Grand Total
                    decimal grandTotal = 0;
                    foreach (DataRow row in dt.Rows)
                    {
                        grandTotal += Convert.ToDecimal(row["TotalAmount"]);
                    }
                    GrandTotalLabel.Text = string.Format("Grand Total: ₹{0:N2}", grandTotal);
                }
            }
        }

        // Step 2: Fetch Customer Details using CustomerID
        if (customerId > 0)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string customerQuery = "SELECT name, email, addr, city, state, pin FROM login WHERE cid = @CustomerID";
                using (SqlCommand cmd = new SqlCommand(customerQuery, con))
                {
                    cmd.Parameters.AddWithValue("@CustomerID", customerId);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblUserName.Text = reader["name"].ToString();
                            lblUserEmail.Text = reader["email"].ToString();
                            lblUserAddress.Text = string.Format("{0}, {1}, {2}, {3}",
                                reader["addr"].ToString(),
                                reader["city"].ToString(),
                                reader["state"].ToString(),
                                reader["pin"].ToString());
                        }
                        else
                        {
                            ShowError("Customer details not found.");
                        }
                    }
                }
            }
        }
        else
        {
            ShowError("Customer ID not found in order.");
        }
    }

    private void ShowError(string message)
    {
        lblErrorMessage.Text = message;
        lblErrorMessage.Visible = true;
        lblUserName.Text = lblUserEmail.Text = lblUserAddress.Text = "N/A";
        GrandTotalLabel.Text = "N/A";
        OrderGridView.DataSource = null;
        OrderGridView.DataBind();
    }
}
