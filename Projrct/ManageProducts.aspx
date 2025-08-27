<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/MasterAdmin.master" AutoEventWireup="true" CodeFile="ManageProducts.aspx.cs" Inherits="ManageProducts" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="App_Themes/Theme1/Unified.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="product-management">
        <h1>Manage Products</h1>
        <div class="product-actions">
            <asp:Button ID="btnAddProduct" runat="server" Text="Add New Product" CssClass="btn-add" OnClick="btnAddProduct_Click" />
        </div>

        <!-- Product GridView with Horizontal Scrollbar -->
        <div class="product-table-container">
            <asp:GridView ID="ProductGridView" runat="server" AutoGenerateColumns="False" CssClass="product-table" OnRowEditing="ProductGridView_RowEditing" OnRowDeleting="ProductGridView_RowDeleting" DataKeyNames="ProductID" EmptyDataText="No products found.">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="ProductImage" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Width="100px" alt='<%# Eval("ProductName") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ProductID" HeaderText="ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="Rating" HeaderText="Rating" DataFormatString="{0:N1}" />
                    <asp:BoundField DataField="ReviewCount" HeaderText="Reviews" />
                    <asp:BoundField DataField="Price" HeaderText="Price (₹)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="OriginalPrice" HeaderText="Original Price (₹)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="Discount" HeaderText="Discount (%)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="BestPrice" HeaderText="Best Price (₹)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" />
                    <asp:BoundField DataField="category" HeaderText="Category" />
                    <asp:BoundField DataField="name" HeaderText="Supplier" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn-edit" CommandName="Edit" CommandArgument='<%# Eval("ProductID") %>' />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete" CommandName="Delete" CommandArgument='<%# Eval("ProductID") %>' OnClientClick="return confirm('Are you sure you want to delete this product?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label ID="MessageLabel" runat="server" CssClass="message-label" Visible="false" />
        <asp:HiddenField ID="hdnProductID" runat="server" />
    </div>

    <!-- Modal Popup for Add/Edit Product -->
    <div id="addProductModal" class="modal" ClientIDMode="Static">
        <div class="modal-content">
            <span class="close" onclick="closeModal();">&times;</span>
            <h2><asp:Label ID="lblModalTitle" runat="server" Text="Add New Product" /></h2>
            <div class="form-group">
                <label for="txtImageUrl">Image URL:</label>
                <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvImageUrl" runat="server" ControlToValidate="txtImageUrl" ErrorMessage="Image URL is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtProductName">Product Name:</label>
                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ControlToValidate="txtProductName" ErrorMessage="Product Name is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="txtRating">Rating:</label>
                <asp:TextBox ID="txtRating" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRating" runat="server" ControlToValidate="txtRating" ErrorMessage="Rating is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvRating" runat="server" ControlToValidate="txtRating" Operator="DataTypeCheck" Type="Double" ErrorMessage="Rating must be a valid number." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label for="txtReviewCount">Review Count:</label>
                <asp:TextBox ID="txtReviewCount" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvReviewCount" runat="server" ControlToValidate="txtReviewCount" ErrorMessage="Review Count is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvReviewCount" runat="server" ControlToValidate="txtReviewCount" Operator="DataTypeCheck" Type="Integer" ErrorMessage="Review Count must be a valid number." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label for="txtOriginalPrice">Original Price (₹):</label>
                <asp:TextBox ID="txtOriginalPrice" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvOriginalPrice" runat="server" ControlToValidate="txtOriginalPrice" ErrorMessage="Original Price is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvOriginalPrice" runat="server" ControlToValidate="txtOriginalPrice" Operator="DataTypeCheck" Type="Currency" ErrorMessage="Original Price must be a valid number." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label for="txtPrice">Price (₹):</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPrice" runat="server" ControlToValidate="txtPrice" Operator="DataTypeCheck" Type="Currency" ErrorMessage="Price must be a valid number." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label for="txtBestPrice">Best Price (₹):</label>
                <asp:TextBox ID="txtBestPrice" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBestPrice" runat="server" ControlToValidate="txtBestPrice" ErrorMessage="Best Price is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvBestPrice" runat="server" ControlToValidate="txtBestPrice" Operator="DataTypeCheck" Type="Currency" ErrorMessage="Best Price must be a valid number." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label for="txtDiscount">Discount (%):</label>
                <asp:TextBox ID="txtDiscount" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDiscount" runat="server" ControlToValidate="txtDiscount" ErrorMessage="Discount is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvDiscount" runat="server" ControlToValidate="txtDiscount" Operator="DataTypeCheck" Type="Double" ErrorMessage="Discount must be a valid number." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label for="txtQuantity">Quantity:</label>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Quantity is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtQuantity" Operator="DataTypeCheck" Type="Currency" ErrorMessage="Quantity must be a valid number." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label for="txtProductLink">Product Link:</label>
                <asp:TextBox ID="txtProductLink" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvProductLink" runat="server" ControlToValidate="txtProductLink" ErrorMessage="Product Link is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="ddlCategory">Category:</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Category" Value="" />
                    <asp:ListItem Text="Sofa" Value="Sofa" />
                    <asp:ListItem Text="Bed" Value="Bed" />
                    <asp:ListItem Text="Dining" Value="Dining" />
                    <asp:ListItem Text="Closet" Value="Closet" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" ErrorMessage="Category is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label for="ddlSupplier">Supplier:</label>
                <asp:DropDownList ID="ddlSupplier" runat="server" CssClass="form-control" DataTextField="name" DataValueField="sid">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvSupplier" runat="server" ControlToValidate="ddlSupplier" ErrorMessage="Supplier is required." Display="Dynamic" CssClass="text-danger" ValidationGroup="ProductValidation"></asp:RequiredFieldValidator>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-save" OnClick="btnSave_Click" ValidationGroup="ProductValidation" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn-reset" OnClick="btnReset_Click" CausesValidation="false" />
            </div>
        </div>
    </div>

    <!-- JavaScript for Modal and Message Box -->
    <script type="text/javascript">
        function showModal() {
            var modal = document.getElementById('addProductModal');
            modal.style.display = 'block';
        }

        function closeModal() {
            var modal = document.getElementById('addProductModal');
            modal.style.display = 'none';
        }

        window.onclick = function (event) {
            var modal = document.getElementById('addProductModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</asp:Content>