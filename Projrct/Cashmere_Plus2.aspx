<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Cashmere_Plus2.aspx.cs" Inherits="Cashmere_Plus2" %>

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
                            <img src="images/Wardrobe/Cashmere_Plus2/<%=i%>.jpg" alt="Thumbnail <%=i%>" class="thumbnail-image" onclick="changeFeaturedImage('<%=i%>')">
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="main-image">
                <img id="featuredImage" src="images/Wardrobe/Cashmere_Plus2/1.jpg" alt="Featured Flipper Sofa" class="featured-product-image">
            </div>
        </div>
        <div class="product-info">
            <h1>Cashmere Plus 2 Door</h1>
            <p class="product-size">Size: <strong>2 Door, 2 Shelves, Without Partition, 1 Drawer, Without Trays, With Mirror, 1 Hanging Area</strong></p>
            <p>Wyoming Maple & Frappe</p>
            <p class="rating-section">Rating: <span class="rating">4.5</span> <span class="rating">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (2.0K reviews)</p>
            <p class="cart-stat">200+ added to the cart last week</p>
            <p class="price">Price: <span class="current-price">₹15,898</span> <span class="original-price">₹23,990</span> <span class="discount">(34% off)</span></p>
            <p></p>
            <h2 class="best-price">₹15,898</h2>

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
            featuredImage.src = `images/Wardrobe/Cashmere_Plus2/${index}.jpg`;
        }

        document.getElementById('quantity').addEventListener('change', function () {
            const selectedQuantity = this.value;
            console.log(`Selected Quantity: ${selectedQuantity}`);
        });
        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
</asp:Content>

