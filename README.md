# Furnish-Florish (Furniture Management System)

A robust and intuitive **Windows Desktop Application** designed to streamline operations for furniture businesses. Built with Visual Basic .NET (VB.NET), this application provides comprehensive modules for managing customers, tracking product inventory, handling suppliers, and processing billing seamlessly.

---

## 🌟 Key Features

- **🛒 Billing System:** Generate, view, and manage customer bills with detailed line items and pricing calculations.
- **👥 Customer Management:** Keep a comprehensive database of customer details for better tracking and service.
- **📦 Product Inventory:** Manage furniture stock, track availability, and update product details easily.
- **🚚 Supplier Management:** Maintain supplier contact details and track restocking orders.
- **📊 Reporting Module:** Built-in `.rdlc` reports to visualize and print data for:
  - Bill Invoices (`ReportBill.rdlc`)
  - Customer Lists (`ReportCus.rdlc`)
  - Product Inventory (`ReportPro.rdlc`)
  - Supplier Information (`ReportSup.rdlc`)
- **🔐 User Authentication:** Secure login and registration functionality to restrict access to authorized personnel.

---

## 🛠️ Technologies Used

- **Language:** Visual Basic .NET (VB.NET)
- **Framework:** .NET Framework (Windows Forms / WinForms)
- **Database:** Microsoft SQL Server LocalDB (`Database1.mdf`)
- **Reporting:** Microsoft Report Viewer (`.rdlc` reports)

---

## 📂 Project Structure

```
Furnish-Florish/
├── Project/
│   ├── Project.sln                  # Visual Studio Solution file
│   └── Project/
│       ├── Database1.mdf            # Local SQL Server Database file
│       ├── Project.vbproj           # VB.NET Project file
│       ├── main.vb                  # Main dashboard form
│       ├── login.vb & Register.vb   # Authentication forms
│       ├── customer.vb              # Customer management interface
│       ├── Form3.vb                 # Product management interface
│       ├── supplier.vb              # Supplier management interface
│       ├── BillingForm.vb           # Billing and invoicing interface
│       └── *.rdlc                   # Report design files
└── README.md                        # This documentation file
```

---

## 🚀 Prerequisites

Before you can run the project locally, ensure you have the following installed on your machine:

1. **Visual Studio 2019 or later:** (Community, Professional, or Enterprise edition). Make sure to include the **.NET desktop development** workload during installation.
2. **SQL Server Express LocalDB:** Usually installed alongside Visual Studio data workloads.
3. **Microsoft Report Viewer Control:** Ensure the report viewer components for WinForms are installed to view `.rdlc` files.

---

## 💻 How to Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ManavSurani/Furnish-Florish.git
   ```
2. **Open the Project:**
   Navigate to the `Project` folder and double-click `Project.sln` to open the solution in Visual Studio.
3. **Database Connection (If Required):**
   - The project uses a local database file (`Database1.mdf`).
   - If you face any connection issues, verify the connection string in `App.config` to ensure it correctly points to the `|DataDirectory|\Database1.mdf` path, or attach the database to your local SQL Server instance.
4. **Build and Run:**
   - Press **Start** (or `F5`) in Visual Studio to build and launch the application.
   - The application will start at the Loading/Login page.

---

## 📜 License

This project is open-source. Feel free to fork and modify the code as per your requirements.
