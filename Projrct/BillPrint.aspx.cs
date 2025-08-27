using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class BillPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Check if the user is logged in
            if (Session["Cid"] == null)
            {
                Response.Redirect("Default.aspx"); // Redirect to login page if not logged in
            }
            else
            {
                // Load user details
                LoadUserDetails();

                // Load order details
                LoadOrderDetails();
            }
        }
    }

    // Load user details
    private void LoadUserDetails()
    {
        try
        {
            int cid = Convert.ToInt32(Session["Cid"]);

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT name, email, addr, city, state, pin 
                                 FROM login 
                                 WHERE cid = @Cid";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Cid", cid);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Display user details
                            lblUserName.Text = reader["name"].ToString();
                            lblUserEmail.Text = reader["email"].ToString();
                            lblUserAddress.Text = string.Format("{0}, {1}, {2}, {3}",
                                reader["addr"].ToString(),
                                reader["city"].ToString(),
                                reader["state"].ToString(),
                                reader["pin"].ToString());
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log error and show message
            LogError(ex);
            Response.Write("An error occurred while loading user details. Please try again later.");
        }
    }

    // Load order details
    private void LoadOrderDetails()
    {
        try
        {
            int cid = Convert.ToInt32(Session["Cid"]);

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT ProductName, Quantity, Price, TotalAmount 
                                 FROM Orders 
                                 WHERE CustomerID = @Cid 
                                 ORDER BY OrderDate DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Cid", cid);
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind order details to GridView
                        OrderGridView.DataSource = dt;
                        OrderGridView.DataBind();

                        // Calculate and display grand total
                        CalculateGrandTotal(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log error and show message
            LogError(ex);
            Response.Write("An error occurred while loading order details. Please try again later.");
        }
    }

    // Calculate grand total
    private void CalculateGrandTotal(DataTable orderData)
    {
        decimal grandTotal = 0;
        foreach (DataRow row in orderData.Rows)
        {
            grandTotal += Convert.ToDecimal(row["TotalAmount"]);
        }
        GrandTotalLabel.Text = string.Format("Grand Total: ₹{0:N2}", grandTotal);
    }

    // Log errors to a file
    private void LogError(Exception ex)
    {
        string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
        string logMessage = string.Format("{0}: {1}\n{2}\n\n", DateTime.Now, ex.Message, ex.StackTrace);
        System.IO.File.AppendAllText(logFilePath, logMessage);
    }
}