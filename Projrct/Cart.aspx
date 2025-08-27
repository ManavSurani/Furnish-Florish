<%@ Page Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="Cart" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="cart-container">
        <h1>Shopping Cart</h1>
        <asp:GridView ID="CartGridView" runat="server" AutoGenerateColumns="False" CssClass="cart-table" OnRowDeleting="CartGridView_RowDeleting" DataKeyNames="id" EmptyDataText="Your cart is empty.">
            <Columns>
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="ProductImage" runat="server" ImageUrl='<%# Eval("image_url") %>' Width="100px" alt='<%# Eval("product_name") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="product_name" HeaderText="Product Name" />
                <asp:BoundField DataField="quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="price" HeaderText="Price (₹)" DataFormatString="{0:N2}" />
                <asp:BoundField DataField="total" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
                <asp:CommandField ShowDeleteButton="True" HeaderText="Actions" DeleteText="Remove" ButtonType="Button" ControlStyle-CssClass="btn-remove" />
            </Columns>
        </asp:GridView>

        <!-- Grand Total Section -->
        <div class="grand-total">
            <asp:Label ID="GrandTotalLabel" runat="server" CssClass="grand-total-label" Text="Grand Total: ₹0.00" />
        </div>

        <div class="cart-actions">
            <asp:Button ID="CheckoutButton" runat="server" CssClass="btn-checkout" Text="Continue to Checkout" OnClick="CheckoutButton_Click" />
            <asp:Button ID="ClearCartButton" runat="server" CssClass="btn-clear" Text="Clear Cart" OnClick="ClearCartButton_Click" OnClientClick="return confirm('Are you sure you want to clear your cart?');" aria-label="Clear Cart" Enabled="false" />
        </div>

        <asp:Label ID="MessageLabel" runat="server" CssClass="cart-message" Visible="false" />
    </div>
    <script>
        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
    <style>
        .cart-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .cart-container h1 {
            font-size: 28px;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .cart-table th, .cart-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .cart-table th {
            background-color: #f4f4f4;
            color: #555;
        }

        .cart-table tr:hover {
            background-color: #f9f9f9;
        }

        .grand-total {
            text-align: right;
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
        }

        .grand-total-label {
            color: #004d26;
        }

        .cart-actions {
            text-align: center;
            margin-top: 20px;
        }

        .btn-checkout, .btn-clear, .btn-remove {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin: 5px;
        }

        .btn-checkout {
            background-color: #004d26;
        }

        .btn-checkout:hover {
            background-color: #76b041;
        }

        .btn-clear {
            background-color: #b04141;
        }

        .btn-clear:hover {
            background-color: #e04141;
        }

        .btn-remove {
            background-color: #ff4d4d;
        }

        .btn-remove:hover {
            background-color: #ff1a1a;
        }

        .cart-message {
            margin-top: 20px;
            text-align: center;
            color: red;
            font-size: 18px;
        }
    </style>
</asp:Content>