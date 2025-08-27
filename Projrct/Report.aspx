<%@ Page Title="Order Report" Language="C#" MasterPageFile="~/MasterAdmin.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="App_Themes/Theme1/Report.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="report-management">
        <h1>Order Report</h1>

        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-group">
                <label for="ddlOrderID">Order ID:</label>
                <asp:DropDownList ID="ddlOrderID" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlOrderID_SelectedIndexChanged">
                    <asp:ListItem Text="All" Value="0" />
                </asp:DropDownList>
            </div>
            <div class="filter-group">
                <label for="ddlCustomerID">Customer ID:</label>
                <asp:DropDownList ID="ddlCustomerID" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCustomerID_SelectedIndexChanged">
                    <asp:ListItem Text="All" Value="0" />
                </asp:DropDownList>
            </div>
            <div class="filter-group">
                <label for="ddlStatus">Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                    <asp:ListItem Text="All" Value="" />
                    <asp:ListItem Text="Pending" Value="Pending" />
                    <asp:ListItem Text="Shipped" Value="Shipped" />
                    <asp:ListItem Text="Delivered" Value="Delivered" />
                    <asp:ListItem Text="Cancelled" Value="Cancelled" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Order GridView -->
        <div class="order-table-container">
            <asp:GridView ID="OrderGridView" runat="server" AutoGenerateColumns="False" CssClass="order-table" DataKeyNames="OrderID" EmptyDataText="No orders found.">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                    <asp:BoundField DataField="CustomerID" HeaderText="Customer ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount (₹)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn-view" OnClick="btnView_Click" CommandArgument='<%# Eval("OrderID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label ID="MessageLabel" runat="server" CssClass="message-label" Visible="false" />
    </div>
</asp:Content>