using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Linq;
using System.Collections.Generic;

public partial class Checkout : System.Web.UI.Page
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

                // Load cart details for the current logged-in user
                LoadCartDetails();
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
                string query = @"SELECT name, email, phone, addr, city, state, pin 
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
                        else
                        {
                            ShowMessage("User data not found.", true);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            LogError(ex);
            ShowMessage("An error occurred while loading user details. Please try again later.", true);
        }
    }

    // Load cart details
    private void LoadCartDetails()
    {
        try
        {
            int cid = Convert.ToInt32(Session["Cid"]);

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT id, image_url, product_name, price, quantity, total 
                                 FROM cart 
                                 WHERE cid = @Cid";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Cid", cid);
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind cart items to GridView
                        CartGridView.DataSource = dt;
                        CartGridView.DataBind();

                        // Calculate and display grand total
                        CalculateGrandTotal(dt);
                    }
                }
            }

            if (CartGridView.Rows.Count == 0)
            {
                MessageLabel.Text = "Your cart is empty.";
                MessageLabel.ForeColor = System.Drawing.Color.Red;
                MessageLabel.Visible = true;
                ProceedToBillingButton.Enabled = false; // Disable the button if the cart is empty
            }
        }
        catch (Exception ex)
        {
            LogError(ex);
            ShowMessage("An error occurred while loading your cart. Please try again later.", true);
        }
    }

    // Calculate grand total
    private void CalculateGrandTotal(DataTable cartData)
    {
        decimal grandTotal = 0;
        foreach (DataRow row in cartData.Rows)
        {
            decimal totalPrice = Convert.ToDecimal(row["total"]);
            grandTotal += totalPrice;
        }
        GrandTotalLabel.Text = string.Format("Grand Total: ₹{0:N2}", grandTotal);
    }

    // Proceed to Billing button click event
    protected void ProceedToBillingButton_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
    }

    // Submit billing information
    protected void btnSubmitBilling_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string cardNumber = txtCardNumber.Text;
            string expiryDate = txtExpiryDate.Text;
            string cvv = txtCVV.Text;

            bool isCardValid = IsValidCardNumber(cardNumber);
            bool isExpiryValid = IsValidExpiryDate(expiryDate);
            bool isCVVValid = IsValidCVV(cvv);

            // Validate billing information
            if (!isCardValid)
            {
                ShowMessage("Invalid card number. Please check your details and try again.", true);
                return;
            }

            if (!isExpiryValid)
            {
                ShowMessage("Invalid expiry date. Please use the format MM/YY and ensure the date is in the future.", true);
                return;
            }

            if (!isCVVValid)
            {
                ShowMessage("Invalid CVV. Please enter a 3-digit number.", true);
                return;
            }

            try
            {
                // Process order and update stock
                ProcessOrderAndUpdateStock();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeBillingModal", "closeBillingModal();", true);
                ShowMessage("Order placed successfully! Thank you for your purchase.");
                Response.Redirect("~/BillPrint.aspx");
            }
            catch (Exception ex)
            {
                LogError(ex);
                ShowMessage("An error occurred while placing your order. Please try again later.", true);
            }
        }
    }

    // Validate card number using Luhn algorithm
    private bool IsValidCardNumber(string cardNumber)
    {
        if (string.IsNullOrWhiteSpace(cardNumber) || cardNumber.Length != 16 || !cardNumber.All(char.IsDigit))
            return false;

        int sum = 0;
        bool alternate = false;

        // Apply Luhn's algorithm
        for (int i = cardNumber.Length - 1; i >= 0; i--)
        {
            int digit = cardNumber[i] - '0'; // Convert char to int

            if (alternate)
            {
                digit *= 2;
                if (digit > 9) digit -= 9;
            }

            sum += digit;
            alternate = !alternate;
        }

        return (sum % 10 == 0);
    }

    // Validate expiry date
    private bool IsValidExpiryDate(string expiryDate)
    {
        if (string.IsNullOrWhiteSpace(expiryDate) || expiryDate.Length != 5 || expiryDate[2] != '/')
            return false;

        string[] parts = expiryDate.Split('/');
        int month, year;

        // Ensure both parts are valid numbers
        if (parts.Length != 2 || !int.TryParse(parts[0], out month) || !int.TryParse(parts[1], out year))
            return false;

        if (month < 1 || month > 12)
            return false;

        // Convert 2-digit year to full year
        int currentYear = DateTime.Now.Year % 100;
        int fullYear = 2000 + year; // Converts '25' to '2025'

        // Ensure the expiry date is in the future
        DateTime expiry = new DateTime(fullYear, month, DateTime.DaysInMonth(fullYear, month));

        return expiry >= DateTime.Now;
    }

    // Validate CVV
    private bool IsValidCVV(string cvv)
    {
        return !string.IsNullOrWhiteSpace(cvv) && (cvv.Length == 3 || cvv.Length == 4) && cvv.All(char.IsDigit);
    }

    // Process order and update stock
    private void ProcessOrderAndUpdateStock()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString))
        {
            con.Open();
            SqlTransaction transaction = con.BeginTransaction();
            try
            {
                int cid = Convert.ToInt32(Session["Cid"]);
                DateTime orderDate = DateTime.Now;

                // Step 1: Fetch cart items into a list
                var cartItems = new List<CartItem>();
                string getCartQuery = @"SELECT product_name, quantity, price, total FROM cart WHERE cid = @Cid";
                using (SqlCommand getCartCmd = new SqlCommand(getCartQuery, con, transaction))
                {
                    getCartCmd.Parameters.AddWithValue("@Cid", cid);
                    using (SqlDataReader reader = getCartCmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            cartItems.Add(new CartItem
                            {
                                ProductName = reader["product_name"].ToString(),
                                Quantity = Convert.ToInt32(reader["quantity"]),
                                Price = Convert.ToDecimal(reader["price"]),
                                TotalAmount = Convert.ToDecimal(reader["total"])
                            });
                        }
                    }
                }

                // Step 2: Insert cart items into Orders table
                foreach (var item in cartItems)
                {
                    string orderQuery = @"INSERT INTO Orders (CustomerID, OrderDate, ProductName, Quantity, Price, TotalAmount) 
                                         VALUES (@CustomerID, @OrderDate, @ProductName, @Quantity, @Price, @TotalAmount)";
                    using (SqlCommand orderCmd = new SqlCommand(orderQuery, con, transaction))
                    {
                        orderCmd.Parameters.AddWithValue("@CustomerID", cid);
                        orderCmd.Parameters.AddWithValue("@OrderDate", orderDate);
                        orderCmd.Parameters.AddWithValue("@ProductName", item.ProductName);
                        orderCmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                        orderCmd.Parameters.AddWithValue("@Price", item.Price);
                        orderCmd.Parameters.AddWithValue("@TotalAmount", item.TotalAmount);
                        orderCmd.ExecuteNonQuery();
                    }
                }

                // Step 3: Update product stock
                string updateStockQuery = @"UPDATE Product SET quantity = quantity - @Quantity 
                                           WHERE ProductName = @ProductName";
                using (SqlCommand updateStockCmd = new SqlCommand(updateStockQuery, con, transaction))
                {
                    updateStockCmd.Parameters.Add(new SqlParameter("@Quantity", SqlDbType.Int));
                    updateStockCmd.Parameters.Add(new SqlParameter("@ProductName", SqlDbType.VarChar));

                    foreach (var item in cartItems)
                    {
                        updateStockCmd.Parameters["@Quantity"].Value = item.Quantity;
                        updateStockCmd.Parameters["@ProductName"].Value = item.ProductName;
                        updateStockCmd.ExecuteNonQuery();
                    }
                }

                // Step 4: Clear the cart (only if all previous steps succeed)
                string clearCartQuery = @"DELETE FROM cart WHERE cid = @Cid";
                using (SqlCommand clearCartCmd = new SqlCommand(clearCartQuery, con, transaction))
                {
                    clearCartCmd.Parameters.AddWithValue("@Cid", cid);
                    clearCartCmd.ExecuteNonQuery();
                }

                // Commit the transaction if everything succeeds
                transaction.Commit();

                // Reload cart details to reflect the empty cart
                LoadCartDetails();
            }
            catch (Exception ex)
            {
                // Rollback the transaction if any error occurs
                transaction.Rollback();
                LogError(ex);
                throw; // Re-throw the exception to handle it in the calling method
            }
        }
    }

    // Log errors to a file
    private void LogError(Exception ex)
    {
        string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
        string logMessage = string.Format("{0}: {1}\n{2}\n\n", DateTime.Now, ex.Message, ex.StackTrace);
        System.IO.File.AppendAllText(logFilePath, logMessage);
    }

    // Show a message to the user
    private void ShowMessage(string message, bool isError = false)
    {
        MessageLabel.Text = message;
        MessageLabel.CssClass = isError ? "message-label error" : "message-label success";
        MessageLabel.Visible = true;
    }

    // Back button click event
    protected void BackButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
}

// Helper class to represent cart items
public class CartItem
{
    public string ProductName { get; set; }
    public int Quantity { get; set; }
    public decimal Price { get; set; }
    public decimal TotalAmount { get; set; }
}