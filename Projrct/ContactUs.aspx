<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="description" content="Get in touch with Furnish & Florish for any inquiries or support." />
    <style>
        /* General Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.6;
        }
        .contact-container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
            padding: 40px;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .contact-container h1 {
            text-align: center;
            color: #4CAF50;
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .contact-container p {
            font-size: 16px;
            text-align: justify;
            color: #555;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        /* Contact Info Section */
        .contact-info {
            text-align: center;
            margin-bottom: 40px;
        }
        .contact-info p {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
        }
        .contact-info strong {
            color: #2c3e50;
        }
        .contact-info a {
            color: #4CAF50;
            text-decoration: none;
        }
        .contact-info a:hover {
            text-decoration: underline;
        }

        /* Message Form Container */
        .message-container {
            background-color: #f5f5f5;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-top: 40px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .message-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        }
        .message-container h2 {
            text-align: center;
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        /* Contact Form Section */
        .contact-form {
            margin-top: 20px;
        }
        .contact-form label {
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
            color: #2c3e50;
            font-weight: 600;
        }
        .contact-form input, .contact-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            color: #555;
            transition: border-color 0.3s ease, transform 0.3s ease; /* Add transition for hover effect */
        }
        .contact-form input:hover, .contact-form textarea:hover {
            border-color: #4CAF50; /* Change border color on hover */
            transform: scale(1.02); /* Slightly scale up on hover */
        }
        .contact-form textarea {
            resize: vertical;
            min-height: 150px;
        }
        .contact-form button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .contact-form button:hover {
            background-color: #45a049;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="contact-container">
        <h1>Contact Us</h1>
        <div class="contact-info">
            <p>We'd love to hear from you! Whether you have a question about our products, need assistance, or just want to share feedback, feel free to reach out.</p>
            <p><strong>Email:</strong> <a href="mailto:info@furnishflorish.com">info@furnishflorish.com</a></p>
            <p><strong>Phone:</strong> +91 9998754126</p>
            <p><strong>Address:</strong> 123 Mota Bazar, Anand, Gujarat, 388120</p>
        </div>

        <!-- Message Form Container -->
        <div class="message-container">
            <h2>Send Us a Message</h2>
            <div class="contact-form">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required />

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required />

                <label for="message">Message:</label>
                <textarea id="message" name="message" rows="5" required></textarea>

                <button type="submit">Send Message</button>
            </div>
        </div>
    </div>
</asp:Content>