<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Lanta_Queen_Size_Upholstered_Bed.aspx.cs" Inherits="Lanta_Queen_Size_Upholstered_Bed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="product-details-container">
        <div class="image-panel">
            <div class="thumbnail-column">
                <div class="thumbnail-scrollable">
                    <% for(int i = 1; i <= 9; i++) { %>
                        <div class="thumbnail-item">
                            <img src="images/Bed/Lanta_Queen_Size_Upholstered_Bed/<%=i%>.jpg" alt="Thumbnail <%=i%>" class="thumbnail-image" onclick="changeFeaturedImage('<%=i%>')">
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="main-image">
                <img id="featuredImage" src="images/Bed/Lanta_Queen_Size_Upholstered_Bed/1.jpg" alt="Featured Flipper Sofa" class="featured-product-image">
            </div>
        </div>
        <div class="product-info">
            <h1>Lanta Queen Size Upholstered Bed</h1>
            <p class="product-size">Size: <strong> 78" x 60"  Inches | 1.98m x 1.52m</strong></p>
            <p>Queen, With Storege, Omega Blue</p>
            <p class="rating-section">Rating: <span class="rating">4.2</span> <span class="rating">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.7K reviews)</p>
            <p class="cart-stat">200+ added to the cart last week</p>
            <p class="price">Price: <span class="current-price">₹41,999</span> <span class="original-price">₹55,999</span> <span class="discount">(25% off)</span></p>
            <p></p>
            <h2 class="best-price">₹41,999</h2>

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

    <style>
        body {
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            color: #222; /* Matches the home page text color */
        }

        .product-details-container {
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            margin: 20px;
            transition: all 0.3s ease;
        }

        .product-details-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }

        .image-panel {
            flex: 1;
            max-width: 70%;
            display: flex;
            flex-direction: row;
        }

        .main-image {
            flex: 4;
            margin-left: 20px;
        }

        .featured-product-image {
            width: 100%;
            height: auto;
            max-height: 70vh;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .featured-product-image:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .thumbnail-column {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            max-height: 54vh;
            overflow-y: auto;
        }

        .thumbnail-scrollable {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .thumbnail-item {
            width: 80px;
            height: 80px;
            overflow: hidden;
            border-radius: 8px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 2px solid #ddd;
        }

        .thumbnail-item:hover {
            transform: scale(1.1);
            border-color: #6c5ce7; /* Updated hover border color */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .thumbnail-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .thumbnail-column::-webkit-scrollbar {
            width: 10px;
        }

        .thumbnail-column::-webkit-scrollbar-thumb {
            background-color: #bbb;
            border-radius: 5px;
        }

        .thumbnail-column::-webkit-scrollbar-track {
            background-color: #f0f0f0;
        }

        .product-info {
            flex: 1.5;
            text-align: left;
            padding: 20px;
        }

        .product-info h1 {
            font-size: 32px;
            margin-bottom: 10px;
            color: #333; /* Dark green for text */
        }

        .product-info p {
            font-size: 18px;
            margin: 5px 0;
            color: #555;
        }

        .rating {
            font-weight: bold;
            color: #28a745; /* Green color for rating */
        }

        .price {
            font-size: 24px;
            color: #004d26; /* Dark green for text */
            font-weight: bold;
        }

        .original-price {
            text-decoration: line-through;
            color: #999;
            margin-left: 5px;
        }

        .discount {
            color: #28a745;
        }

        .best-price {
            font-weight: bold;
            color: #333;
            
        }

        .quantity-container {
            margin: 15px 0;
            display: flex;
            align-items: center;
            font-size: 18px;
            color: #555;
        }

        .quantity-label {
            margin-right: 10px;
            font-weight: bold;
            font-size:larger;
        }

        .quantity-select {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border: 2px solid #76b041;
            border-radius: 5px;
            background-color: #ffffff;
            color: #004d26;
            cursor: pointer;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .quantity-select:hover {
            border-color: #004d26;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .go-to-cart {
            padding: 15px 40px;
            background: #004d26;
            color: white;
            border: 2px solid #76b041;
            font-size: 20px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            z-index: 1;
            border-radius: 5px;
            transition: color 0.3s ease;
        }

        .go-to-cart::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: #76b041;
            z-index: 0;
            transition: left 0.3s ease;
        }

        .go-to-cart:hover::before {
            left: 0;
        }

        .go-to-cart span {
            position: relative;
            z-index: 1;
            transition: color 0.3s ease;
        }

        .go-to-cart:hover span {
            color: #004d26;
        }

        @media screen and (max-width: 768px) {
            .product-details-container {
                flex-direction: column;
                align-items: center;
            }

            .image-panel {
                max-width: 100%;
                margin-bottom: 20px;
            }

            .product-info {
                padding: 10px;
            }
        }
    </style>

    <script>
        function changeFeaturedImage(index) {
            const featuredImage = document.getElementById('featuredImage');
            featuredImage.src = `images/Bed/Lanta_Queen_Size_Upholstered_Bed/${index}.jpg`;
        }

        document.getElementById('quantity').addEventListener('change', function () {
            const selectedQuantity = this.value;
            console.log(`Selected Quantity: ${selectedQuantity}`);
        });
    </script>
</asp:Content>

