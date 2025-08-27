<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Living Room Section -->
    <div class="section-container living-room-container" onmouseover="changeBorderColor(this, '#e74c3c')" onmouseout="resetBorderColor(this, '#6c5ce7')">
        <a href="Leving_Room.aspx" class="section-link">
            <img id="livingRoomImage" src="images/home/Living_Room.jpg" alt="Living Room" class="section-image" 
                onmouseover="changeImage('livingRoomImage', 'images/home/sofa.jpg')" 
                onmouseout="revertImage('livingRoomImage', 'images/home/Living_Room.jpg')" />
            <div class="section-text">
                <h2>Living Room</h2>
                <p>
                    The living room is the heart of the home, where family and friends gather to relax and enjoy each other's company. 
                </p>
            </div>
        </a>
    </div>

    <!-- Bedroom Section -->
    <div class="section-container bedroom-container" onmouseover="changeBorderColor(this, '#2ecc71')" onmouseout="resetBorderColor(this, '#6c5ce7')">
        <a href="Bed_Room.aspx" class="section-link">
            <img id="bedroomImage" src="images/home/sku_main-shot_01_regency-bedframelowres{w=1440}.jpg" alt="Bedroom" class="section-image" 
                onmouseover="changeImage('bedroomImage', 'images/home/bed.jpg')" 
                onmouseout="revertImage('bedroomImage', 'images/home/sku_main-shot_01_regency-bedframelowres{w=1440}.jpg')" />
            <div class="section-text">
                <h2>Bedroom</h2>
                <p>
                    The bedroom is a sanctuary of rest and relaxation, offering a private retreat from the world. 
                </p>
            </div>
        </a>
    </div>

    <!-- Closet Section -->
    <div class="section-container closet-container" onmouseover="changeBorderColor(this, '#3498db')" onmouseout="resetBorderColor(this, '#6c5ce7')">
        <a href="Closet.aspx" class="section-link">
            <img id="closetImage" src="images/home/Store_Room.jpg" alt="Closet" class="section-image" 
                onmouseover="changeImage('closetImage', 'images/home/closet.jpg')" 
                onmouseout="revertImage('closetImage', 'images/home/Store_Room.jpg')" />
            <div class="section-text">
                <h2>Closet</h2>
                <p>
                    The closet is a storage haven for clothes, shoes, and accessories. 
                </p>
            </div>
        </a>
    </div>

    <!-- Kitchen Section -->
    <div class="section-container kitchen-container" onmouseover="changeBorderColor(this, '#f1c40f')" onmouseout="resetBorderColor(this, '#6c5ce7')">
        <a href="Kitchen.aspx" class="section-link">
            <img id="kitchenImage" src="images/home/Italian-Formal-Dining-Room.jpg" alt="Kitchen" class="section-image" 
                onmouseover="changeImage('kitchenImage', 'images/home/dining.jpg')" 
                onmouseout="revertImage('kitchenImage', 'images/home/Italian-Formal-Dining-Room.jpg')" />
            <div class="section-text">
                <h2>Kitchen</h2>
                <p>
                    The kitchen is the heart of culinary creativity and family meals. 
                </p>
            </div>
        </a>
    </div>

    <script>
        function changeImage(imageId, newSrc) {
            document.getElementById(imageId).src = newSrc;
            document.getElementById(imageId).parentElement.querySelector('.section-text').style.transform = 'scale(1.05)';
        }

        function revertImage(imageId, originalSrc) {
            document.getElementById(imageId).src = originalSrc;
            document.getElementById(imageId).parentElement.querySelector('.section-text').style.transform = 'scale(1)';
        }

        function changeBorderColor(element, color) {
            element.style.borderLeftColor = color;
        }

        function resetBorderColor(element, color) {
            element.style.borderLeftColor = color;
        }

        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
    <link href="App_Themes/Theme1/Home.css" rel="stylesheet" type="text/css" />
    
</asp:Content>
