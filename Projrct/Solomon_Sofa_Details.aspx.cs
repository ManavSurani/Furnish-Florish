using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Solomon_Sofa_Details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Bind quantities to the dropdown list
            ddlQuantity.DataSource = Enumerable.Range(1, 10);
            ddlQuantity.DataBind();
        }

        // Redirect to login page if the session is not set
        if (Session["Cid"] == null)
        {
            Response.Redirect("~/Default.aspx");
        }
    }

    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        try
        {


            // Validate quantity
            int quantity;
            if (!int.TryParse(ddlQuantity.SelectedValue, out quantity))
            {
                Response.Write("<script>alert('Invalid quantity selected.');</script>");
                return;
            }

            // Product details
            decimal price = 32999; // Consider moving this to a config file or database
            string productName = "Solomon Sofa - Three Seater";
            string imageUrl = "images/Sofa/Solomon_Sofa/1.jpg";

            // Add to cart
            CartHelper.AddToCart(Session["Cid"].ToString(), productName, imageUrl, quantity, price);

            // Success message
            Response.Write("<script>alert('Item added to cart successfully!');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('An error occurred while adding the item to the cart. Please try again later.');</script>");
        }
    }
}