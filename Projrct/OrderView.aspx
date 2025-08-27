<%@ Page Title="Order Details" Language="C#" AutoEventWireup="true" CodeFile="OrderView.aspx.cs" Inherits="OrderView" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <style>
        body { 
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .order-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
        }
        .order-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .order-header h1 {
            font-size: 24px;
            color: #004d26;
        }
        .order-details {
            margin-bottom: 20px;
        }
        .order-details h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .order-table th, .order-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .order-table th {
            background-color: #f4f4f4;
            color: #555;
        }
        .order-total {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
        .order-total-label {
            color: #004d26;
        }
        .print-button {
            text-align: center;
            margin-top: 20px;
        }
        .btn-print {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #004d26;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-print:hover {
            background-color: #76b041;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div class="order-container">
            <div class="order-header">
                <h1>Order Details</h1>
            </div>

            <!-- Error Message Label -->
            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>

            <div class="order-details">
                <h2>Customer Information</h2>
                <p><strong>Name:</strong> <asp:Label ID="lblUserName" runat="server" /></p>
                <p><strong>Email:</strong> <asp:Label ID="lblUserEmail" runat="server" /></p>
                <p><strong>Address:</strong> <asp:Label ID="lblUserAddress" runat="server" /></p>
            </div>

            <div class="order-details">
                <h2>Order Items</h2>
                <asp:GridView ID="OrderGridView" runat="server" AutoGenerateColumns="False" CssClass="order-table">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price (₹)" DataFormatString="{0:N2}" />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="order-total">
                <asp:Label ID="GrandTotalLabel" runat="server" CssClass="order-total-label" Text="Grand Total: ₹0.00" />
            </div>

            <div class="print-button">
                <button class="btn-print" onclick="window.print();">Print Order</button>
            </div>
        </div>
    </form>

</body>
</html>
