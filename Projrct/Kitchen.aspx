<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Kitchen.aspx.cs" Inherits="Kitchen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link href="App_Themes/Theme1/Kitchen.css" rel="stylesheet" type="text/css" />
<div class="search-container">
        <input type="text" id="searchInput" placeholder="Search for products..." onkeyup="searchProducts()" />
    </div>
    <div class="product-container" id="productContainer">
        <div class="product-card">
            <a href="Cobbler_4_seater.aspx">
                <img src="images/Dining/Cobbler_4_seater/1.jpg" alt="Taurus Engineered Wood Bed with Storage" class="product-image">
                <h3>Cobbler 4 seater solid wood dining set</h3>
                <p>Rating: <span class="rating">5.0</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span> (2.4K reviews)</p>
                <p>Price: ₹21,199 <span class="original-price">₹30,190</span> <span class="discount">(30% off)</span></p>
                <h3 class="best-price">₹21,199</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Vanilla_4_seater_Glass_Metal_Dining_Set.aspx">
                <img src="images/Dining/Vanilla_4_seater_Glass_Metal_Dining_Set/1.jpg" alt="Solatio Sofa - Three Seater" class="product-image">
                <h3>Vanilla 4-seater Glass & Metal Dining Set</h3>
                <p>Rating: <span class="rating">4.3</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.5K reviews)</p>
                <p>Price: ₹16,399 <span class="original-price">₹22,143</span> <span class="discount">(26% off)</span></p>
                <h3 class="best-price">₹16,399</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Kopra.aspx">
                <img src="images/Dining/Kopra/1.jpg" alt="Solomon Sofa - Three Seater" class="product-image">
                <h3>Kopra 6 seater Dining Set</h3>
                <p>Rating: <span class="rating">4.1</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (2.7K reviews)</p>
                <p>Price: ₹37,100 <span class="original-price">₹53,000</span> <span class="discount">(30% off)</span></p>
                <h3 class="best-price">₹37,100</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Simsim.aspx">
                <img src="images/Dining/Simsim/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Simsim-Ginamon Natural Sheesham Wood Dining Set</h3>
                <p>Rating: <span class="rating">5.0</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span> (2.7K reviews)</p>
                <p>Price: ₹27,300 <span class="original-price">₹30,000</span> <span class="discount">(9% off)</span></p>
                <h3 class="best-price">₹27,300</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Nigella.aspx">
                <img src="images/Dining/Nigella/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Nigella 4 Seater Dining Set - Mocha Brown</h3>
                <p>Rating: <span class="rating">4.3</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.81K reviews)</p>
                <p>Price: ₹42,119 <span class="original-price">₹70,199</span> <span class="discount">(40% off)</span></p>
                <h3 class="best-price">₹42,119</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Rosemary.aspx">
                <img src="images/Dining/Rosemary/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Rosemary 4 Seater Glass & Metal Dining Set</h3>
                <p>Rating: <span class="rating">4.2</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.7K reviews)</p>
                <p>Price: ₹16,386 <span class="original-price">₹22,143</span> <span class="discount">(26% off)</span></p>
                <h3 class="best-price">₹16,386</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Fanila.aspx">
                <img src="images/Dining/Fanila/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Fanila 4-seater sheesham wood dining set with four chairs</h3>
                <p>Rating: <span class="rating">4.0</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.0K reviews)</p>
                <p>Price: ₹32,900 <span class="original-price">₹47,000</span> <span class="discount">(30% off)</span></p>
                <h3 class="best-price">₹32,900</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Minto.aspx">
                <img src="images/Dining/Minto/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Minto 4 Seater sheesham wood Dining Set</h3>
                <p>Rating: <span class="rating">4.5</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (2.0K reviews)</p>
                <p>Price: ₹28,500 <span class="original-price">₹38,000</span> <span class="discount">(25% off)</span></p>
                <h3 class="best-price">₹28,500</h3>
            </a>
        </div>
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

