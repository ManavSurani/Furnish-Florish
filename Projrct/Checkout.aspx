<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .checkout-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .checkout-container h1 {
            font-size: 28px;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }

        .user-details, .cart-details {
            margin-bottom: 20px;
        }

        .user-details h2, .cart-details h2 {
            font-size: 24px;
            color: #555;
            margin-bottom: 10px;
        }

        .user-info p {
            font-size: 16px;
            color: #333;
            margin: 5px 0;
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

        .checkout-actions {
            text-align: center;
            margin-top: 20px;
        }

        .btn-checkout, .btn-back {
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

        .btn-back {
            background-color: #6c757d; /* Gray color for the back button */
        }

        .btn-back:hover {
            background-color: #5a6268; /* Darker gray on hover */
        }

        .cart-message {
            margin-top: 20px;
            text-align: center;
            color: red;
            font-size: 18px;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: #000;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .modal-actions {
            text-align: right;
        }

        .btn-submit, .btn-reset, .btn-save ,.btn-cancel{
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-left: 10px;
        }

        .btn-save {
            background-color: #4CAF50;
            color: white;
        }

        .btn-save:hover {
            background-color: #45a049;
        }

        .btn-submit {
            background-color: #004d26;
            color: #fff;
        }

        .btn-submit:hover {
            background-color: #76b041;
        }

        .btn-reset {
            background-color: #ffc107;
            color: #000;
        }

        .btn-reset:hover {
            background-color: #e0a800;
        }

        .text-danger {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
        .btn-cancel {
            background-color: #dc3545; /* Red color for the cancel button */
            color: white;
        }

        .btn-cancel:hover {
            background-color: #c82333; /* Darker red on hover */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="checkout-container">
        <h1>Checkout</h1>

        <!-- User Details Section -->
        <div class="user-details">
            <h2>User Details</h2>
            <div class="user-info">
                <p><strong>Name:</strong> <asp:Label ID="lblUserName" runat="server" Text="" /></p>
                <p><strong>Email:</strong> <asp:Label ID="lblUserEmail" runat="server" Text="" /></p>
                <p><strong>Address:</strong> <asp:Label ID="lblUserAddress" runat="server" Text="" /></p>
            </div>
        </div>

        <!-- Cart Details Section -->
        <div class="cart-details">
            <h2>Your Cart</h2>
            <asp:GridView ID="CartGridView" runat="server" AutoGenerateColumns="False" CssClass="cart-table" EmptyDataText="Your cart is empty.">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="ProductImage" runat="server" ImageUrl='<%# Eval("image_url") %>' Width="100px" alt='<%# Eval("product_name") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="product_name" HeaderText="Product Name" />
                    <asp:BoundField DataField="price" HeaderText="Price (₹)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" />
                    <asp:BoundField DataField="total" HeaderText="Total (₹)" DataFormatString="{0:N2}" />
                </Columns>
            </asp:GridView>

            <!-- Grand Total Section -->
            <div class="grand-total">
                <asp:Label ID="GrandTotalLabel" runat="server" CssClass="grand-total-label" Text="Grand Total: ₹0.00" />
            </div>
        </div>

        <!-- Proceed to Billing Button -->
        <div class="checkout-actions">
            <asp:Button ID="ProceedToBillingButton" runat="server" CssClass="btn-checkout" Text="Proceed to Billing" OnClick="ProceedToBillingButton_Click" />
            <asp:Button ID="BackButton" runat="server" CssClass="btn-back" Text="Back to Cart" OnClick="BackButton_Click" />
        </div>

        <!-- Error/Success Message -->
        <asp:Label ID="MessageLabel" runat="server" CssClass="cart-message" Visible="false" />
    </div>

    <!-- Modal Popup for Billing Information -->
    <div id="billingModal" class="modal" runat="server">
        <div class="modal-content">
            <span class="close" onclick="closeModal();">&times;</span>
            <h2>Billing Information</h2>
            <div class="form-group">
                <label for="txtCardNumber">Card Number:</label>
                <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="Enter card number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" ControlToValidate="txtCardNumber" ErrorMessage="Card number is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="BillingValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtExpiryDate">Expiry Date:</label>
                <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" placeholder="MM/YY"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvExpiryDate" runat="server" ControlToValidate="txtExpiryDate" ErrorMessage="Expiry date is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="BillingValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtCVV">CVV:</label>
                <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="Enter CVV" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCVV" runat="server" ControlToValidate="txtCVV" ErrorMessage="CVV is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="BillingValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnSubmitBilling" runat="server" Text="Submit" CssClass="btn-submit" OnClick="btnSubmitBilling_Click" ValidationGroup="BillingValidation" />
                <asp:Button ID="btnCancelBilling" runat="server" Text="Cancel" CssClass="btn-cancel" OnClientClick="closeModal(); return false;" />
            </div>
        </div>
    </div>

    <!-- JavaScript for Modal and Message Box -->
    <script type="text/javascript">
        function showModal() {
            var modal = document.getElementById('<%= billingModal.ClientID %>');
            modal.style.display = 'block';
        }

        function closeModal() {
            var modal = document.getElementById('<%= billingModal.ClientID %>');
            modal.style.display = 'none';
        }

        // Close modal when clicking outside the modal
        window.onclick = function (event) {
            var modal = document.getElementById('<%= billingModal.ClientID %>');
            if (event.target == modal) {
                closeModal();
            }
        }
        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
</asp:Content>