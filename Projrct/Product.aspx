<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* Search Container */
        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }

        #searchInput {
            width: 50%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        #searchInput:hover {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        #searchInput:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            outline: none;
        }

        /* Product Container */
        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
            padding: 20px;
        }

        /* Product Card */
        .product-card {
            text-align: center;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 250px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .product-card a {
            text-decoration: none;
            color: inherit;
        }

        .product-image {
            width: 100%;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.1);
        }

        .product-card h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #333;
        }

        .product-card p {
            margin: 5px 0;
            font-size: 14px;
            color: #666;
        }

        .original-price {
            text-decoration: line-through;
            color: #999;
            margin-left: 5px;
        }

        .discount {
            color: #28a745; /* Green color for discount text */
        }

        .best-price {
            font-weight: bold;
            font-size: 20px; /* Bigger font size */
            color: #d9534f;
        }

        .rating {
            font-weight: bold;
            color: #28a745; /* Green color for rating */
        }

        .stars {
            color: #28a745; /* Green color for stars */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="search-container">
        <input type="text" id="searchInput" placeholder="Search for products..." onkeyup="searchProducts()" />
    </div>
    <div class="product-container" id="productContainer">
        <!-- Product Cards -->
        <asp:Repeater ID="ProductRepeater" runat="server">
            <ItemTemplate>
                <div class="product-card">
                    <a href='<%# Eval("ProductLink") %>'>
                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="product-image">
                        <h3><%# Eval("ProductName") %></h3>
                        <p>Rating: <span class="rating"><%# Eval("Rating") %></span> <span class="stars"><%# GetStars(Eval("Rating")) %></span> (<%# Eval("ReviewCount") %> reviews)</p>
                        <p>Price: ₹<%# Eval("Price") %> <span class="original-price">₹<%# Eval("OriginalPrice") %></span> <span class="discount">(<%# Eval("Discount") %>% off)</span></p>
                        <h3 class="best-price">₹<%# Eval("BestPrice") %></h3>
                    </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <script>
        function searchProducts() {
            var input, filter, container, cards, h3, i, txtValue;
            input = document.getElementById('searchInput');
            filter = input.value.toUpperCase();
            container = document.getElementById('productContainer');
            cards = container.getElementsByClassName('product-card');

            for (i = 0; i < cards.length; i++) {
                h3 = cards[i].getElementsByTagName('h3')[0];
                txtValue = h3.textContent || h3.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    cards[i].style.display = "";
                } else {
                    cards[i].style.display = "none";
                }
            }
        }
    </script>
</asp:Content>