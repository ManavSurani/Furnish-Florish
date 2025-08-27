using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class ManageProducts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSuppliers(); // Bind suppliers to dropdown
            BindProducts();
            BindCategories();// Bind products to GridView
        }
    }
    private void BindCategories()
    {
        // Predefined categories
        ddlCategory.Items.Clear();
        ddlCategory.Items.Add(new ListItem("Select Category", ""));
        ddlCategory.Items.Add(new ListItem("Sofa", "Sofa"));
        ddlCategory.Items.Add(new ListItem("Bed", "Bed"));
        ddlCategory.Items.Add(new ListItem("Dining", "Dining"));
        ddlCategory.Items.Add(new ListItem("Closet", "Closet"));
    }
    private void BindSuppliers()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT sid, name FROM supplier";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlSupplier.DataSource = reader;
                ddlSupplier.DataTextField = "name";
                ddlSupplier.DataValueField = "sid";
                ddlSupplier.DataBind();
            }
        }
    }

    private void BindProducts()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT p.ProductID, p.ProductName, p.ImageUrl, p.ProductLink, p.Rating, p.ReviewCount, p.Price, p.OriginalPrice, p.Discount, p.BestPrice, p.category, p.quantity, s.name FROM Product p INNER JOIN supplier s ON p.sid = s.sid";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ProductGridView.DataSource = reader;
                ProductGridView.DataBind();
            }
        }
    }

    protected void btnAddProduct_Click(object sender, EventArgs e)
    {
        hdnProductID.Value = "0"; // Indicates a new product
        lblModalTitle.Text = "Add New Product";
        txtImageUrl.Text = "";
        txtProductName.Text = "";
        txtProductLink.Text = "";
        txtRating.Text = "";
        txtReviewCount.Text = "";
        txtPrice.Text = "";
        txtOriginalPrice.Text = "";
        txtDiscount.Text = "";
        txtBestPrice.Text = "";
        ddlCategory.SelectedIndex = 0;
        txtQuantity.Text = "";
        ddlSupplier.SelectedIndex = 0;
        ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "showModal();", true);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query;
                if (hdnProductID.Value == "0")
                {
                    query = "INSERT INTO Product (ProductName, ImageUrl, ProductLink, Rating, ReviewCount, Price, OriginalPrice, Discount, BestPrice, category, quantity, sid) VALUES (@ProductName, @ImageUrl, @ProductLink, @Rating, @ReviewCount, @Price, @OriginalPrice, @Discount, @BestPrice, @category, @quantity, @sid)";
                }
                else
                {
                    query = "UPDATE Product SET ProductName = @ProductName, ImageUrl = @ImageUrl, ProductLink = @ProductLink, Rating = @Rating, ReviewCount = @ReviewCount, Price = @Price, OriginalPrice = @OriginalPrice, Discount = @Discount, BestPrice = @BestPrice, category = @category, quantity = @quantity, sid = @sid WHERE ProductID = @ProductID";
                }

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                    cmd.Parameters.AddWithValue("@ImageUrl", txtImageUrl.Text);
                    cmd.Parameters.AddWithValue("@ProductLink", txtProductLink.Text);
                    cmd.Parameters.AddWithValue("@Rating", Convert.ToDecimal(txtRating.Text));
                    cmd.Parameters.AddWithValue("@ReviewCount", Convert.ToInt32(txtReviewCount.Text));
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
                    cmd.Parameters.AddWithValue("@OriginalPrice", Convert.ToDecimal(txtOriginalPrice.Text));
                    cmd.Parameters.AddWithValue("@Discount", Convert.ToDecimal(txtDiscount.Text));
                    cmd.Parameters.AddWithValue("@BestPrice", Convert.ToDecimal(txtBestPrice.Text));
                    cmd.Parameters.AddWithValue("@category", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@quantity", Convert.ToInt32(txtQuantity.Text));
                    cmd.Parameters.AddWithValue("@sid", Convert.ToInt32(ddlSupplier.SelectedValue));

                    if (hdnProductID.Value != "0")
                    {
                        cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt32(hdnProductID.Value));
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindProducts();
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", "closeModal();", true);
            Response.Redirect("~/ManageProducts.aspx");
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtImageUrl.Text = "";
        txtProductName.Text = "";
        txtProductLink.Text = "";
        txtRating.Text = "";
        txtReviewCount.Text = "";
        txtPrice.Text = "";
        txtOriginalPrice.Text = "";
        txtDiscount.Text = "";
        txtBestPrice.Text = "";
        txtQuantity.Text = "";
        ddlCategory.SelectedIndex = 0;
        ddlSupplier.SelectedIndex = 0;
    }

    protected void ProductGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        int productID = Convert.ToInt32(ProductGridView.DataKeys[e.NewEditIndex].Value);
        hdnProductID.Value = productID.ToString();
        lblModalTitle.Text = "Edit Product";

        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "SELECT ProductName, ImageUrl, ProductLink, Rating, ReviewCount, Price, OriginalPrice, Discount, BestPrice, category, sid FROM Product WHERE ProductID = @ProductID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProductID", productID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtImageUrl.Text = reader["ImageUrl"].ToString();
                    txtProductName.Text = reader["ProductName"].ToString();
                    txtProductLink.Text = reader["ProductLink"].ToString();
                    txtRating.Text = reader["Rating"].ToString();
                    txtReviewCount.Text = reader["ReviewCount"].ToString();
                    txtPrice.Text = reader["Price"].ToString();
                    txtOriginalPrice.Text = reader["OriginalPrice"].ToString();
                    txtDiscount.Text = reader["Discount"].ToString();
                    txtBestPrice.Text = reader["BestPrice"].ToString();
                    ddlCategory.SelectedValue = reader["category"].ToString();
                    ddlSupplier.SelectedValue = reader["sid"].ToString();
                }
            }
        }

        ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "showModal();", true);
    }

    protected void ProductGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int productID = Convert.ToInt32(ProductGridView.DataKeys[e.RowIndex].Value);

        string connectionString = ConfigurationManager.ConnectionStrings["Mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "DELETE FROM Product WHERE ProductID = @ProductID";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ProductID", productID);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        BindProducts();
    }
}