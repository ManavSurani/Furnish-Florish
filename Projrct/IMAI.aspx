<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="IMAI.aspx.cs" Inherits="IMAI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link href="App_Themes/Theme1/Dining.css" rel="stylesheet" type="text/css" />
<div class="product-details-container">
        <div class="image-panel">
            <div class="thumbnail-column">
                <div class="thumbnail-scrollable">
                    <% for(int i = 1; i <= 6; i++) { %>
                        <div class="thumbnail-item">
                            <img src="images/Wardrobe/IMAI/<%=i%>.jpg" alt="Thumbnail <%=i%>" class="thumbnail-image" onclick="changeFeaturedImage('<%=i%>')">
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="main-image">
                <img id="featuredImage" src="images/Wardrobe/IMAI/1.jpg" alt="Featured Flipper Sofa" class="featured-product-image">
            </div>
        </div>
        <div class="product-info">
            <h1>IMAI 4 Door Wardrobe with two external drawer</h1>
            <p class="product-size">Size: <strong>4 Door, With 2 Internal drawer, 2 External Drawer, With Mirror, 1 Hanging Area</strong></p>
            <p>Wenge & Frosty White</p>
            <p class="rating-section">Rating: <span class="rating">4.3</span> <span class="rating">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.81K reviews)</p>
            <p class="cart-stat">200+ added to the cart last week</p>
            <p class="price">Price: <span class="current-price">₹27,300</span> <span class="original-price">₹39,000</span> <span class="discount">(30% off)</span></p>
            <p></p>
            <h2 class="best-price">₹27,300</h2>

            <!-- Quantity Selector -->
            <div class="quantity-container">
                <label for="ddlQuantity" class="quantity-label">Quantity:</label>
                <asp:DropDownList ID="ddlQuantity" runat="server" CssClass="quantity-select">
                </asp:DropDownList>
            </div>

            <!-- Add to Cart Button -->
            <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="go-to-cart" OnClick="btnAddToCart_Click" />
        </div>
    </div>
    <script>
        function changeFeaturedImage(index) {
            const featuredImage = document.getElementById('featuredImage');
            featuredImage.src = `images/Wardrobe/IMAI/${index}.jpg`;
        }

        document.getElementById('quantity').addEventListener('change', function () {
            const selectedQuantity = this.value;
            console.log(`Selected Quantity: ${selectedQuantity}`);
        });
    </script>
</asp:Content>

