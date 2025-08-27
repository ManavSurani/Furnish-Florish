<%@ Page Title="" Language="C#" MasterPageFile="~/MasterAdmin.master" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager runat="server" ID="ScriptManager1" />
    <link href="App_Themes/Theme1/Unified.css" rel="stylesheet" type="text/css" />
    <div class="user-management">
        <h1>Manage Users</h1>
        <div class="user-actions">
            <asp:Button ID="btnAddUser" runat="server" Text="Add New User" CssClass="btn-add" OnClick="btnAddUser_Click" />
        </div>

        <!-- Wrap the GridView in a scrollable container -->
        <div class="user-table-container">
            <asp:GridView ID="UserGridView" runat="server" AutoGenerateColumns="False" CssClass="user-table" OnRowEditing="UserGridView_RowEditing" OnRowDeleting="UserGridView_RowDeleting" DataKeyNames="cid" EmptyDataText="No users found.">
                <Columns>
                    <asp:BoundField DataField="cid" HeaderText="ID" />
                    <asp:BoundField DataField="name" HeaderText="Name" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:BoundField DataField="phone" HeaderText="Phone" />
                    <asp:BoundField DataField="addr" HeaderText="Address" />
                    <asp:BoundField DataField="city" HeaderText="City" />
                    <asp:BoundField DataField="state" HeaderText="State" />
                    <asp:BoundField DataField="pin" HeaderText="PIN Code" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn-edit" CommandName="Edit" CommandArgument='<%# Eval("cid") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete" CommandName="Delete" CommandArgument='<%# Eval("cid") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label ID="MessageLabel" runat="server" CssClass="message-label" Visible="false" />
        <asp:HiddenField ID="hdnUserID" runat="server" />
    </div>

    <!-- Modal Popup for Add/Edit User -->
    <div id="addUserModal" class="modal" runat="server">
        <div class="modal-content">
            <span class="close" onclick="closeModal();">&times;</span>
            <h2><asp:Label ID="lblModalTitle" runat="server" Text="Add New User" /></h2>
            <div class="form-group">
                <label for="txtName">Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtEmail">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group">
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtPhone">Phone:</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtAddress">Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtCity">City:</label>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtState">State:</label>
                <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" ErrorMessage="State is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtPin">PIN Code:</label>
                <asp:TextBox ID="txtPin" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPin" runat="server" ControlToValidate="txtPin" ErrorMessage="PIN Code is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="UserValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSave_Click" ValidationGroup="UserValidation" />
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-submit" OnClick="btnSubmit_Click" ValidationGroup="UserValidation" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn-reset" OnClick="btnReset_Click" CausesValidation="false" />
            </div>
        </div>
    </div>

    <!-- JavaScript for Modal and Message Box -->
    <script type="text/javascript">
        function showModal() {
            var modal = document.getElementById('<%= addUserModal.ClientID %>');
            modal.style.display = 'block';
        }

        function closeModal() {
            var modal = document.getElementById('<%= addUserModal.ClientID %>');
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
            var modal = document.getElementById('<%= addUserModal.ClientID %>');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</asp:Content>

