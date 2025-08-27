<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/MasterAdmin.master" AutoEventWireup="true" CodeFile="ManageOrders.aspx.cs" Inherits="ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="App_Themes/Theme1/Unified.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="order-management">
        <h1>Manage Orders</h1>

        <!-- Order GridView -->
        <div class="order-table-container">
            <asp:GridView ID="OrderGridView" runat="server" AutoGenerateColumns="False" CssClass="order-table" OnRowEditing="OrderGridView_RowEditing" OnRowDeleting="OrderGridView_RowDeleting" DataKeyNames="OrderID" EmptyDataText="No orders found.">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                    <asp:BoundField DataField="CustomerID" HeaderText="Customer ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount (₹)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn-edit" CommandName="Edit" CommandArgument='<%# Eval("OrderID") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete" CommandName="Delete" CommandArgument='<%# Eval("OrderID") %>' OnClientClick="return confirm('Are you sure you want to delete this order?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label ID="MessageLabel" runat="server" CssClass="message-label" Visible="false" />
        <asp:HiddenField ID="hdnOrderID" runat="server" />
    </div>

    <!-- Modal Popup for Edit Order -->
    <div id="editOrderModal" class="modal" ClientIDMode="Static">
        <div class="modal-content">
            <span class="close" onclick="closeModal();">&times;</span>
            <h2><asp:Label ID="lblModalTitle" runat="server" Text="Edit Order" /></h2>
            <div class="form-group">
                <label for="ddlStatus">Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Pending" Value="Pending" />
                    <asp:ListItem Text="Shipped" Value="Shipped" />
                    <asp:ListItem Text="Delivered" Value="Delivered" />
                    <asp:ListItem Text="Cancelled" Value="Cancelled" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="ddlStatus" ErrorMessage="Status is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="OrderValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSave_Click" ValidationGroup="OrderValidation" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn-reset" OnClick="btnReset_Click" CausesValidation="false" />
            </div>
        </div>
    </div>

    <!-- JavaScript for Modal and Message Box -->
    <script type="text/javascript">
        function showModal() {
            var modal = document.getElementById('editOrderModal');
            modal.style.display = 'block';
        }

        function closeModal() {
            var modal = document.getElementById('editOrderModal');
            modal.style.display = 'none';
        }

        window.onclick = function (event) {
            var modal = document.getElementById('editOrderModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</asp:Content>