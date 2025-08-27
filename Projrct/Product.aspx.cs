using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Product : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindProducts();
        }
    }

    // Bind products to the Repeater
    private void BindProducts()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT 
                    ProductName, 
                    ImageUrl, 
                    ProductLink, 
                    Rating, 
                    ReviewCount, 
                    Price, 
                    OriginalPrice, 
                    Discount, 
                    BestPrice,
                    category
                FROM Product"; // Replace with your actual query
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        ProductRepeater.DataSource = dt;
                        ProductRepeater.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log the error (e.g., to a file or database)
            // Example: LogError(ex);

            // Display a user-friendly error message
            Response.Write("<script>alert('An error occurred while loading products. Please try again later.');</script>");
        }
    }

    // Convert numeric rating to star icons
    public string GetStars(object rating)
    {
        if (rating == null) return string.Empty;

        double ratingValue = Convert.ToDouble(rating);
        int fullStars = (int)ratingValue;
        bool hasHalfStar = (ratingValue - fullStars) >= 0.5;

        string stars = new string('★', fullStars);
        if (hasHalfStar) stars += '☆';

        return stars;
    }
}