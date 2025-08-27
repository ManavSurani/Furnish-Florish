<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Closet.aspx.cs" Inherits="Closet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="App_Themes/Theme1/Kitchen.css" rel="stylesheet" type="text/css" />
<div class="search-container">
        <input type="text" id="searchInput" placeholder="Search for products..." onkeyup="searchProducts()" />
    </div>
    <div class="product-container" id="productContainer">
        <div class="product-card">
            <a href="Gingham.aspx">
                <img src="images/Wardrobe/Gingham/1.jpg" alt="Taurus Engineered Wood Bed with Storage" class="product-image">
                <h3>Gingham 4 Door Wardrobe with Drawer</h3>
                <p>Rating: <span class="rating">5.0</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span> (2.4K reviews)</p>
                <p>Price: ₹19,999 <span class="original-price">₹24,300</span> <span class="discount">(18% off)</span></p>
                <h3 class="best-price">₹19,999</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Twill.aspx">
                <img src="images/Wardrobe/Twill/1.jpg" alt="Solatio Sofa - Three Seater" class="product-image">
                <h3>Twill 2 Door Compact Wardrobe Wall Anchored</h3>
                <p>Rating: <span class="rating">4.3</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.5K reviews)</p>
                <p>Price: ₹8,299 <span class="original-price">₹10,120</span> <span class="discount">(18% off)</span></p>
                <h3 class="best-price">₹8,299</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Hunor.aspx">
                <img src="images/Wardrobe/Hunor/1.jpg" alt="Solomon Sofa - Three Seater" class="product-image">
                <h3>Hunor 1 Door Wardrobe</h3>
                <p>Rating: <span class="rating">4.1</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (2.7K reviews)</p>
                <p>Price: ₹6,999 <span class="original-price">₹10,998</span> <span class="discount">(36% off)</span></p>
                <h3 class="best-price">₹6,999</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Cashmere.aspx">
                <img src="images/Wardrobe/Cashmere/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Cashmere Plus 4 Door Wardrobe</h3>
                <p>Rating: <span class="rating">5.0</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span> (2.7K reviews)</p>
                <p>Price: ₹28,597 <span class="original-price">₹43,290</span> <span class="discount">(34% off)</span></p>
                <h3 class="best-price">₹28,597</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="IMAI.aspx">
                <img src="images/Wardrobe/IMAI/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>IMAI 4 Door Wardrobe with two external drawer</h3>
                <p>Rating: <span class="rating">4.3</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.81K reviews)</p>
                <p>Price: ₹27,300 <span class="original-price">₹39,000</span> <span class="discount">(30% off)</span></p>
                <h3 class="best-price">₹27,300</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Organza.aspx">
                <img src="images/Wardrobe/Organza/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Organza Plus 4 Door Wardrobe with Drawer</h3>
                <p>Rating: <span class="rating">4.2</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.7K reviews)</p>
                <p>Price: ₹19,599 <span class="original-price">₹24,800</span> <span class="discount">(21% off)</span></p>
                <h3 class="best-price">₹19,599</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Irena.aspx">
                <img src="images/Wardrobe/Irena/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Irena 4 Door Wardrobe with 1 Hanging Space</h3>
                <p>Rating: <span class="rating">4.0</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (1.0K reviews)</p>
                <p>Price: ₹17,498 <span class="original-price">₹26,900</span> <span class="discount">(35% off)</span></p>
                <h3 class="best-price">₹17,498</h3>
            </a>
        </div>
        <div class="product-card">
            <a href="Cashmere_Plus2.aspx">
                <img src="images/Wardrobe/Cashmere_Plus2/1.jpg" alt="Napper Sofa - Three Seater" class="product-image">
                <h3>Cashmere Plus 2 Door Wardrobe with 2 Shelves</h3>
                <p>Rating: <span class="rating">4.5</span> <span class="stars">&#9733;&#9733;&#9733;&#9733;&#9734;</span> (2.0K reviews)</p>
                <p>Price: ₹15,898 <span class="original-price">₹23,990</span> <span class="discount">(34% off)</span></p>
                <h3 class="best-price">₹15,898</h3>
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
        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
</asp:Content>

