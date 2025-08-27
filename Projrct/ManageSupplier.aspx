<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdmin.master" AutoEventWireup="true" CodeFile="ManageSupplier.aspx.cs" Inherits="ManageSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1" />
    <link href="App_Themes/Theme1/Unified.css" rel="stylesheet" type="text/css" />
    <div class="supplier-management">
        <h1>Manage Suppliers</h1>
        <div class="supplier-actions">
            <asp:Button ID="btnAddSupplier" runat="server" Text="Add New Supplier" CssClass="btn-add" OnClick="btnAddSupplier_Click" />
        </div>

        <!-- Wrap the GridView in a scrollable container -->
        <div class="supplier-table-container">
            <asp:GridView ID="SupplierGridView" runat="server" AutoGenerateColumns="False" CssClass="supplier-table" OnRowEditing="SupplierGridView_RowEditing" OnRowDeleting="SupplierGridView_RowDeleting" DataKeyNames="sid" EmptyDataText="No suppliers found.">
                <Columns>
                    <asp:BoundField DataField="sid" HeaderText="ID" />
                    <asp:BoundField DataField="name" HeaderText="Name" />
                    <asp:BoundField DataField="phone" HeaderText="Phone" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:BoundField DataField="address" HeaderText="Address" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn-edit" CommandName="Edit" CommandArgument='<%# Eval("sid") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete" CommandName="Delete" CommandArgument='<%# Eval("sid") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label ID="MessageLabel" runat="server" CssClass="message-label" Visible="false" />
        <asp:HiddenField ID="hdnSupplierID" runat="server" />
    </div>

    <!-- Modal Popup for Add/Edit Supplier -->
    <div id="addSupplierModal" class="modal" runat="server">
        <div class="modal-content">
            <span class="close" onclick="closeModal();">&times;</span>
            <h2><asp:Label ID="lblModalTitle" runat="server" Text="Add New Supplier" /></h2>
            <div class="form-group">
                <label for="txtName">Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="SupplierValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtPhone">Phone:</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="SupplierValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="SupplierValidation"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" CssClass="text-danger" ValidationGroup="SupplierValidation"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <label for="txtAddress">Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="SupplierValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSave_Click" ValidationGroup="SupplierValidation" />
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-submit" OnClick="btnSubmit_Click" ValidationGroup="SupplierValidation" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn-reset" OnClick="btnReset_Click" CausesValidation="false" />
            </div>
        </div>
    </div>

    <!-- JavaScript for Modal and Message Box -->
    <script type="text/javascript">
        function showModal() {
            var modal = document.getElementById('<%= addSupplierModal.ClientID %>');
            modal.style.display = 'block';
        }

        function closeModal() {
            var modal = document.getElementById('<%= addSupplierModal.ClientID %>');
            modal.style.display = 'none';
        }

        // Function to show a centered message box
        function showMessageBox(message) {
            var messageBox = document.createElement("div");
            messageBox.style.position = "fixed";
            messageBox.style.top = "50%";
            messageBox.style.left = "50%";
            messageBox.style.transform = "translate(-50%, -50%)";
            messageBox.style.backgroundColor = "#f9f9f9";
            messageBox.style.padding = "20px";
            messageBox.style.border = "1px solid #ccc";
            messageBox.style.boxShadow = "0 4px 8px rgba(0, 0, 0, 0.2)";
            messageBox.style.zIndex = "1000";
            messageBox.style.textAlign = "center";
            messageBox.innerHTML = "<p>" + message + "</p><button onclick='closeMessageBox()'>OK</button>";

            document.body.appendChild(messageBox);
        }

        // Function to close the message box
        function closeMessageBox() {
            var messageBox = document.querySelector("div[style*='fixed']");
            if (messageBox) {
                messageBox.remove();
            }
        }

        // Close modal when clicking outside the modal
        window.onclick = function (event) {
            var modal = document.getElementById('<%= addSupplierModal.ClientID %>');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</asp:Content>

