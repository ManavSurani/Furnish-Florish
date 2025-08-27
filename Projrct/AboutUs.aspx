<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="AboutUs.aspx.cs" Inherits="AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="description" content="Learn more about Furnish & Florish and our mission to provide high-quality furniture and home decor products." />
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.6;
        }
        .about-container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
            padding: 40px;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .about-container h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .about-container p {
            font-size: 16px;
            text-align: justify;
            color: #555;
            line-height: 1.8;
            margin-bottom: 20px;
        }
        .about-container h2 {
            text-align: center;
            color: #2c3e50;
            font-size: 28px;
            margin-top: 40px;
            margin-bottom: 30px;
            font-weight: 600;
        }

        /* Team Section */
        .team {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .team-member {
            text-align: center;
            margin: 20px;
            flex: 1 1 250px;
            max-width: 250px;
        }
        .team-member img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .team-member img:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .team-member h3 {
            margin-top: 20px;
            font-size: 20px;
            color: #2c3e50;
            font-weight: 600;
        }
        .team-member p {
            font-size: 14px;
            color: #777;
            margin-top: 5px;
            text-align: center; /* Ensure text is centered */
            line-height: 1.4; /* Improve readability */
        }

        /* Address Section */
        .address {
            text-align: center;
            margin-top: 40px;
            font-size: 16px;
            color: #555;
        }
        .address strong {
            color: #2c3e50;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="about-container">
        <h1>About Furnish & Florish</h1>
        <p>
            Welcome to <strong>Furnish & Florish</strong>, your trusted partner in providing high-quality furniture and home decor products. 
            We are dedicated to offering innovative and stylish solutions to make your home a better place. Our mission is to deliver 
            exceptional products that combine functionality, durability, and aesthetics.
        </p>
        <p>
            Founded in <strong>2019</strong>, we have grown to become a leading name in the furniture industry. Our team of experts works tirelessly 
            to ensure that every product meets the highest standards of quality and craftsmanship. We believe in sustainability and 
            source our materials responsibly to minimize our environmental impact.
        </p>

        <div class="address">
            <p><strong>Address:</strong> 123 Mota Bazar, Anand, Gujarat, 388120</p>
            <p><strong>Phone:</strong> +91 9998754126</p>
        </div>

        <h2><u>Our Team</u></h2>
        <div class="team">
            <div class="team-member">
                <img src="images/team/john.jpg" alt="John Doe" />
                <h3>John Doe</h3>
                <p>CEO & Founder</p>
            </div>
            <div class="team-member">
                <img src="images/team/jane.jpg" alt="Jane Smith" />
                <h3>Jane Smith</h3>
                <p>Head of Design</p>
            </div>
            <div class="team-member">
                <img src="images/team/Mikejpg.jpg" alt="Mike Johnson" />
                <h3>Mike Johnson</h3>
                <p>Operations Manager</p>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
</asp:Content>