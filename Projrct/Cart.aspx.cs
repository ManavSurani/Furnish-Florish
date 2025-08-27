using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Cid"] == null)
            {
                Response.Redirect("default.aspx"); // Redirect to login page if not logged in
            }
            else
            {
                MessageLabel.Visible = false;
                BindCart();
                CalculateGrandTotal();
            }
        }
    }

    private void BindCart()
    {
        try
        {
            int cid;
            if (Session["Cid"] == null || !int.TryParse(Session["Cid"].ToString(), out cid))
            {
                ShowErrorMessage("User session is invalid. Please log in again.");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT id, image_url, product_name, price, quantity, total 
                                 FROM cart 
                                 WHERE cid = @Cid";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Cid", cid);
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        CartGridView.DataSource = dt;
                        CartGridView.DataBind();
                    }
                }
            }

            if (CartGridView.Rows.Count == 0)
            {
                MessageLabel.Text = "Your cart is empty.";
                MessageLabel.ForeColor = System.Drawing.Color.Red;
                MessageLabel.Visible = true;
                ClearCartButton.Enabled = false; // Disable clear cart button
            }
        }
        catch (Exception ex)
        {
            ShowErrorMessage("An error occurred while loading your cart.");
            LogError(ex);
        }
    }

    private void CalculateGrandTotal()
    {
        decimal grandTotal = 0;
        foreach (GridViewRow row in CartGridView.Rows)
        {
            decimal totalPrice = Convert.ToDecimal(row.Cells[4].Text); // Use the correct column index
            grandTotal += totalPrice;
        }
        GrandTotalLabel.Text = string.Format("Grand Total: ₹{0:N2}", grandTotal);
    }

    protected void CartGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int cartId = Convert.ToInt32(CartGridView.DataKeys[e.RowIndex].Value);
            int cid = Convert.ToInt32(Session["Cid"]);

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM cart WHERE id = @CartId AND cid = @Cid";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CartId", cartId);
                    cmd.Parameters.AddWithValue("@Cid", cid);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowSuccessMessage("Item removed from cart.");
            BindCart();
            CalculateGrandTotal();
        }
        catch (Exception ex)
        {
            ShowErrorMessage("An error occurred while removing the item.");
            LogError(ex);
        }
    }

    protected void ClearCartButton_Click(object sender, EventArgs e)
    {
        try
        {
            int cid = Convert.ToInt32(Session["Cid"]);

            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM cart WHERE cid = @Cid";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Cid", cid);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowSuccessMessage("Your cart has been cleared.");
            BindCart();
            CalculateGrandTotal();
        }
        catch (Exception ex)
        {
            ShowErrorMessage("An error occurred while clearing your cart.");
            LogError(ex);
        }
    }

    protected void CheckoutButton_Click(object sender, EventArgs e)
    {
        try
        {
            int cid;
            if (Session["Cid"] == null || !int.TryParse(Session["Cid"].ToString(), out cid))
            {
                ShowErrorMessage("User session is invalid. Please log in again.");
                return;
            }

            // Redirect to the checkout page
            Response.Redirect("Checkout.aspx");
        }
        catch (Exception ex)
        {
            ShowErrorMessage("An error occurred during checkout. Please try again.");
            LogError(ex);
        }
    }

    private void ShowSuccessMessage(string message)
    {
        MessageLabel.Text = message;
        MessageLabel.ForeColor = System.Drawing.Color.Green;
        MessageLabel.Visible = true;
    }

    private void ShowErrorMessage(string message)
    {
        MessageLabel.Text = message;
        MessageLabel.ForeColor = System.Drawing.Color.Red;
        MessageLabel.Visible = true;
    }

    private void LogError(Exception ex)
    {
        // Log the exception to a file, database, or logging framework
        // Example: File.AppendAllText("error.log", $"{DateTime.Now}: {ex.Message}\n{ex.StackTrace}\n\n");
    }
}