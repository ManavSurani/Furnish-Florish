<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Organza.aspx.cs" Inherits="Organza" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link href="App_Themes/Theme1/Dining.css" rel="stylesheet" type="text/css" />
<div class="product-details-container">
        <div class="image-panel">
            <div class="thumbnail-column">
                <div class="thumbnail-scrollable">
                    <% for(int i = 1; i <= 8; i++) { %>
                        <div class="thumbnail-item">
                            <img src="images/Wardrobe/Organza/<%=i%>.jpg" alt="Thumbnail <%=i%>" class="thumbnail-image" onclick="changeFeaturedImage('<%=i%>')">
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="main-image">
                <img id="featuredImage" src="images/Wardrobe/Organza/1.jpg" alt="Featured Flipper Sofa" class="featured-product-image">
            </div>
        </div>
        <div class="product-info">
            <h1>Organza Plus 4 Door</h1>
            <p class="product-size">Size: <strong>4 Door, With Drawer, With Mirror, 1 Hanging Area</strong></p>
            <p>Dark Brown</p>
            <p class="rating-section">Rating: <span class="rating">4.2</span> <span class="rating">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.7K reviews)</p>
            <p class="cart-stat">200+ added to the cart last week</p>
            <p class="price">Price: <span class="current-price">₹19,599</span> <span class="original-price">₹24,800</span> <span class="discount">(21% off)</span></p>
            <p></p>
            <h2 class="best-price">₹19,599</h2>

            <!-- Quantity Selector -->
            <div class="quantity-container">
                <label for="quantity" class="quantity-label">Quantity:</label>
                <select id="quantity" class="quantity-select">
                    <% for (int i = 1; i <= 10; i++) { %>
                        <option value="<%=i%>"><%=i%></option>
                    <% } %>
                </select>
            </div>

            <!-- Add to Cart Button -->
            <button class="go-to-cart"><span>Add to Cart</span></button>
        </div>
    </div>
    <script>
        function changeFeaturedImage(index) {
            const featuredImage = document.getElementById('featuredImage');
            featuredImage.src = `images/Wardrobe/Organza/${index}.jpg`;
        }

        document.getElementById('quantity').addEventListener('change', function () {
            const selectedQuantity = this.value;
            console.log(`Selected Quantity: ${selectedQuantity}`);
        });
    </script>
</asp:Content>

