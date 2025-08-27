<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Vanilla_4_seater_Glass_Metal_Dining_Set.aspx.cs" Inherits="Vanilla_4_seater_Glass_Metal_Dining_Set" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="App_Themes/Theme1/Dining.css" rel="stylesheet" type="text/css" />
<div class="product-details-container">
        <div class="image-panel">
            <div class="thumbnail-column">
                <div class="thumbnail-scrollable">
                    <% for(int i = 1; i <= 10; i++) { %>
                        <div class="thumbnail-item">
                            <img src="images/Dining/Vanilla_4_seater_Glass_Metal_Dining_Set/<%=i%>.jpg" alt="Thumbnail <%=i%>" class="thumbnail-image" onclick="changeFeaturedImage('<%=i%>')">
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="main-image">
                <img id="featuredImage" src="images/Dining/Vanilla_4_seater_Glass_Metal_Dining_Set/1.jpg" alt="Featured Flipper Sofa" class="featured-product-image">
            </div>
        </div>
        <div class="product-info">
            <h1>Vanilla 4-seater Glass & Metal Dining Set</h1>
            <p class="product-size">Size: <strong> 4 Seater, With Cushion</strong></p>
            <p>Omega Pearl, Classic Brown, Sheesham wood</p>
            <p class="rating-section">Rating: <span class="rating">4.3</span> <span class="rating">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.5K reviews)</p>
            <p class="cart-stat">200+ added to the cart last week</p>
            <p class="price">Price: <span class="current-price">₹16,399</span> <span class="original-price">₹22,143</span> <span class="discount">(26% off)</span></p>
            <p></p>
            <h2 class="best-price">₹16,399</h2>

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
            featuredImage.src = `images/Dining/Vanilla_4_seater_Glass_Metal_Dining_Set/${index}.jpg`;
        }

        document.getElementById('quantity').addEventListener('change', function () {
            const selectedQuantity = this.value;
            console.log(`Selected Quantity: ${selectedQuantity}`);
        });
    </script>
</asp:Content>

