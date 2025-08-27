<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillPrint.aspx.cs" Inherits="BillPrint" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Print Bill</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .bill-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .bill-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .bill-header h1 {
            font-size: 24px;
            color: #004d26;
        }
        .bill-details {
            margin-bottom: 20px;
        }
        .bill-details h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }
        .bill-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .bill-table th, .bill-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .bill-table th {
            background-color: #f4f4f4;
            color: #555;
        }
        .bill-total {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
        .bill-total-label {
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
        <div class="bill-container">
            <!-- Bill Header -->
            <div class="bill-header">
                <h1>Order Confirmation</h1>
                <p>Thank you for your purchase!</p>
            </div>

            <!-- User Details -->
            <div class="bill-details">
                <h2>User Details</h2>
                <p><strong>Name:</strong> <asp:Label ID="lblUserName" runat="server" /></p>
                <p><strong>Email:</strong> <asp:Label ID="lblUserEmail" runat="server" /></p>
                <p><strong>Address:</strong> <asp:Label ID="lblUserAddress" runat="server" /></p>
            </div>

            <!-- Order Details -->
            <div class="bill-details">
                <h2>Order Details</h2>
                <asp:GridView ID="OrderGridView" runat="server" AutoGenerateColumns="False" CssClass="bill-table">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price (₹)" DataFormatString="{0:N2}" />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Grand Total -->
            <div class="bill-total">
                <asp:Label ID="GrandTotalLabel" runat="server" CssClass="bill-total-label" Text="Grand Total: ₹0.00" />
            </div>

            <!-- Print Button -->
            <div class="print-button">
                <input type="button" value="Print Bill" class="btn-print" onclick="window.print();" />
            </div>
        </div>
    </form>
    <script>
        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
</body>
</html>