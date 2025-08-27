<%@ Page Title="Admin Home" Language="C#" MasterPageFile="~/MasterAdmin.master" AutoEventWireup="true" CodeFile="AHome.aspx.cs" Inherits="AHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Dashboard Styles */
        .dashboard {
            padding: 20px;
        }

        .dashboard h1 {
            font-size: 28px;
            color: #004d26; /* Dark green for title */
            margin-bottom: 20px;
        }

        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .metric-card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .metric-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .metric-card i {
            font-size: 40px;
            color: #76b041; /* Bright green for icons */
            margin-bottom: 10px;
        }

        .metric-card h2 {
            font-size: 24px;
            color: #004d26; /* Dark green for headings */
            margin-bottom: 10px;
        }

        .metric-card p {
            font-size: 18px;
            color: #333;
        }

        .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .quick-link {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .quick-link:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .quick-link i {
            font-size: 40px;
            color: #76b041; /* Bright green for icons */
            margin-bottom: 10px;
        }

        .quick-link h3 {
            font-size: 20px;
            color: #004d26; /* Dark green for headings */
            margin-bottom: 10px;
        }

        .quick-link p {
            font-size: 16px;
            color: #333;
        }

        /* Loading Spinner */
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #76b041;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard">
        <h1>Dashboard</h1>

        <!-- Metrics Section -->
        <div class="metrics-grid">
            <div class="metric-card">
                <i class="fas fa-users"></i>
                <h2>Total Users</h2>
                <p><asp:Label ID="lblTotalUsers" runat="server" Text="Loading..."></asp:Label></p>
            </div>
            <div class="metric-card">
                <i class="fas fa-box"></i>
                <h2>Total Products</h2>
                <p><asp:Label ID="lblTotalProducts" runat="server" Text="Loading..."></asp:Label></p>
            </div>
            <div class="metric-card">
                <i class="fas fa-shopping-cart"></i>
                <h2>Total Orders</h2>
                <p><asp:Label ID="lblTotalOrders" runat="server" Text="Loading..."></asp:Label></p>
            </div>
            <div class="metric-card">
                <i class="fas fa-chart-line"></i>
                <h2>Revenue</h2>
                <p><asp:Label ID="lblRevenue" runat="server" Text="Loading..."></asp:Label></p>
            </div>
        </div>

        <!-- Quick Links Section -->
        <div class="quick-links">
            <div class="quick-link" onclick="location.href='ManageUsers.aspx';">
                <i class="fas fa-user-cog"></i>
                <h3>Manage Users</h3>
                <p>View and manage user accounts.</p>
            </div>
            <div class="quick-link" onclick="location.href='ManageProducts.aspx';">
                <i class="fas fa-box-open"></i>
                <h3>Manage Products</h3>
                <p>Add, edit, or remove products.</p>
            </div>
            <div class="quick-link" onclick="location.href='ManageOrders.aspx';">
                <i class="fas fa-clipboard-list"></i>
                <h3>Manage Orders</h3>
                <p>View and process customer orders.</p>
            </div>
            <div class="quick-link" onclick="location.href='Report.aspx';">
                <i class="fas fa-chart-pie"></i>
                <h3>Reports</h3>
                <p>Generate and view reports.</p>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('copy', function (event) {
            event.clipboardData.setData('text/plain', '🖕'); // Middle finger emoji
            event.preventDefault();
        });
    </script>
</asp:Content>