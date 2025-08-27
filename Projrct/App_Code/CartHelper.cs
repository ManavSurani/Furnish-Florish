using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

public static class CartHelper
{
    public static void AddToCart(string cid, string productName, string imageUrl, int quantity, decimal price)
    {
        int customerId;
        if (!int.TryParse(cid, out customerId))
            throw new Exception("Invalid customer ID. Please log in.");

        if (productName.Length > 100 || imageUrl.Length > 200)
            throw new Exception("Invalid product details length.");

        decimal total = quantity * price;
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = @"
        MERGE INTO cart AS target
        USING (VALUES (@Cid, @ProductName, @ImageUrl, @Quantity, @Price, @Total))
               AS source (cid, product_name, image_url, quantity, price, total)
        ON target.product_name = source.product_name AND target.cid = source.cid
        WHEN MATCHED THEN
            UPDATE SET target.quantity = target.quantity + source.quantity, target.total = target.total + source.total
        WHEN NOT MATCHED THEN
            INSERT (cid, image_url, product_name, quantity, price, total)
            VALUES (source.cid, source.image_url, source.product_name, source.quantity, source.price, source.total);
        ";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Cid", customerId);
                cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Total", total);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    // Log the exception details (ex.Message, ex.StackTrace, etc.)
                    throw new Exception("An error occurred while adding the product to the cart.", ex);
                }
                finally
                {
                    if (conn.State == System.Data.ConnectionState.Open)
                        conn.Close();
                }
            }
        }
    }
}
