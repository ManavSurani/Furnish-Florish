<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Rosemary.aspx.cs" Inherits="Rosemary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link href="App_Themes/Theme1/Dining.css" rel="stylesheet" type="text/css" />
<div class="product-details-container">
        <div class="image-panel">
            <div class="thumbnail-column">
                <div class="thumbnail-scrollable">
                    <% for(int i = 1; i <= 12; i++) { %>
                        <div class="thumbnail-item">
                            <img src="images/Dining/Rosemary/<%=i%>.jpg" alt="Thumbnail <%=i%>" class="thumbnail-image" onclick="changeFeaturedImage('<%=i%>')">
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="main-image">
                <img id="featuredImage" src="images/Dining/Rosemary/1.jpg" alt="Featured Flipper Sofa" class="featured-product-image">
            </div>
        </div>
        <div class="product-info">
            <h1>Rosemary 4 Seater Glass & Metal Dining Set</h1>
            <p class="product-size">Size: <strong> 4 Seater</strong></p>
            <p>Carbon black</p>
            <p class="rating-section">Rating: <span class="rating">4.2</span> <span class="rating">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.7K reviews)</p>
            <p class="cart-stat">200+ added to the cart last week</p>
            <p class="price">Price: <span class="current-price">₹16,386</span> <span class="original-price">₹22,143</span> <span class="discount">(26% off)</span></p>
            <p></p>
            <h2 class="best-price">₹16,386</h2>

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
            featuredImage.src = `images/Dining/Rosemary/${index}.jpg`;
        }

        document.getElementById('quantity').addEventListener('change', function () {
            const selectedQuantity = this.value;
            console.log(`Selected Quantity: ${selectedQuantity}`);
        });
    </script>
</asp:Content>

