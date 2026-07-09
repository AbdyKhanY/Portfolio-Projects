# 📦 Supply Chain & Logistics Analytics Dashboard

> An interactive Power BI dashboard designed to monitor supply chain performance by analyzing supplier efficiency, inventory levels, shipment operations, customer profitability, and key business KPIs.

---

## 📖 Project Overview

Efficient supply chain management is essential for improving operational performance, reducing costs, and delivering products to customers on time. This project demonstrates how Power BI can transform operational data into meaningful business insights through interactive visualizations and executive-level dashboards.

The dashboard provides a centralized view of the entire supply chain, enabling stakeholders to monitor supplier performance, inventory availability, shipment efficiency, customer profitability, and overall financial performance in one place.

---

# 📸 Dashboard Preview

## Executive Dashboard

![Dashboard Overview](Images/dashboard-overview.png)

---

## 🎯 Business Problem

Organizations often manage supply chain data across multiple systems, making it difficult to answer important business questions such as:

- Which suppliers have the longest lead times?
- Which products hold the highest inventory value?
- Which shipping carriers experience the most delays?
- Which customers generate the highest revenue?
- How is the business performing overall?

Without a centralized reporting solution, decision-making becomes slow and reactive.

---

# 💡 Solution

This Power BI dashboard provides decision-makers with a single source of truth by combining supplier, inventory, shipment, and customer data into one interactive reporting solution.

The dashboard enables users to:

- Monitor business KPIs
- Evaluate supplier performance
- Track inventory levels
- Analyze shipment delays
- Identify customers with highest revenues
- Improve operational efficiency

---

# 📊 Dashboard Features

## Executive KPIs

The dashboard includes high-level business metrics such as:

- Gross Revenue
- Total Revenue
- Profit
- Profit Margin
- Perfect Order Rate
- Total Shipments

---

## 🚢 Supplier Analysis

Monitor supplier performance using:

- Average Lead Time
- Order Quantity
- Supplier Ranking

**Business Value**

Helps procurement teams identify suppliers causing delays and improve sourcing decisions.

---

## 📦 Inventory Analysis

Track inventory performance through:

- Inventory Quantity
- Inventory Value
- Product Ranking

**Business Value**

Supports inventory optimization and reduces overstocking or stock shortages.

---

## 🚚 Shipment Analysis

Evaluate logistics performance using:

- Shipment Quantity
- Carrier Delays
- Shipment Status

**Business Value**

Identifies transportation bottlenecks and improves delivery performance.

---

## 👥 Customer Analysis

Analyze customer performance through:

- Profit Margin
- Delivered Quantity
- Customer Ranking

**Business Value**

Supports customer segmentation and profitability analysis.

---

# 📈 Key Insights

After analyzing the data, several valuable business insights were identified:

- Suppliers exhibit varying lead times, highlighting opportunities for supplier performance improvement.
- High inventory value is concentrated among flagship products, indicating where inventory optimization efforts should focus.
- Shipment delays differ by carrier, enabling logistics teams to identify and address transportation bottlenecks.
- Customer profit margins remain relatively consistent across major customers, suggesting stable profitability.
- Overall business performance shows strong revenue generation supported by healthy profit margins.

---

# 🛠️ Technologies Used

| Tool | Purpose |
|-------|----------|
| Power BI | Dashboard Development |
| Power Query | Data Cleaning & Transformation |
| DAX | Business Calculations |
| Excel | Source Dataset |
| Data Modeling | Star Schema Design |

---

# 🗄️ Data Model

The dashboard is built using a **multi-fact Star Schema**, a best practice in dimensional modeling for Business Intelligence. The model separates transactional data into fact tables and descriptive information into dimension tables, ensuring high performance, scalability, and efficient DAX calculations.

## Fact Tables

| Table | Description |
|--------|-------------|
| **Fact_Sales** | Stores sales transactions, revenue, profit, and order-related metrics. |
| **Fact_Production** | Contains production quantities, manufacturing output, and production performance metrics. |
| **Fact_Shipment** | Tracks shipment details, delivery status, carriers, and logistics performance. |
| **Fact_Procurement** | Records procurement activities, purchase orders, supplier transactions, and procurement costs. |
| **Fact_Inventory** | Stores inventory quantities, stock levels, inventory value, and warehouse information. |

---

## Dimension Tables

| Table | Description |
|--------|-------------|
| **Dim_Product** | Product details including product names, categories, and specifications. |
| **Dim_Supplier** | Supplier information such as supplier names, locations, and performance attributes. |
| **Dim_Customer** | Customer information used for customer-level analysis. |
| **Dim_Facility** | Manufacturing plants, warehouses, and distribution centers. |
| **Dim_Date** | Calendar table supporting time intelligence, trend analysis, and period comparisons. |

---

## Data Model Architecture

```
                            ┌──────────────┐
                            │  Dim_Date    │
                            └──────┬───────┘
                                   │
      ┌──────────────┬─────────────┼─────────────┬──────────────┐
      │              │             │             │              │
      ▼              ▼             ▼             ▼              ▼
┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐
│ Fact Sales │ │Fact Product│ │Fact Shipment││Fact Inventory││Fact Procure│
└─────┬──────┘ └─────┬──────┘ └─────┬──────┘ └─────┬──────┘ └─────┬──────┘
      │              │              │              │              │
      ├──────────────┼──────────────┼──────────────┼──────────────┤
      │              │              │              │              │
      ▼              ▼              ▼              ▼              ▼
┌──────────┐  ┌──────────┐  ┌──────────┐
│DimProduct│  │DimSupplier│ │DimFacility│
└─────┬────┘  └─────┬─────┘ └─────┬─────┘
      │             │             │
      └─────────────┼─────────────┘
                    │
                    ▼
             ┌────────────┐
             │DimCustomer │
             └────────────┘
```

> **Model Type:** Multi-Fact Star Schema  
> **Total Fact Tables:** 5  
> **Total Dimension Tables:** 5  
> **Total Tables:** 10

---

## Modeling Best Practices

This project follows industry-standard Power BI modeling practices:

- ⭐ Star Schema Design
- ⭐ One-to-Many Relationships
- ⭐ Single Direction Cross Filtering
- ⭐ Dedicated Date Dimension for Time Intelligence
- ⭐ Normalized Dimension Tables
- ⭐ Fact Tables Optimized for Analytical Queries
- ⭐ Reusable DAX Measures
- ⭐ Optimized Model Performance

The model was designed to minimize redundancy, improve report performance, and support scalable business analytics across procurement, production, inventory, shipments, customers, and sales.

---

# 📐 Sample DAX Measures

### Total Revenue

```DAX
Total Revenue =
SUM(FactSales[Revenue])
```

### Profit

```DAX
Profit =
SUM(FactSales[Profit])
```

### Profit Margin

```DAX
Profit Margin =
DIVIDE([Profit],[Total Revenue])
```

### Total Shipments

```DAX
Total Shipments =
COUNT(FactShipment[ShipmentID])
```

### Inventory Quantity

```DAX
Inventory Quantity =
SUM(Inventory[Quantity])
```

---

# 📁 Repository Structure

```
Supply-Chain-Dashboard
│
├── Dashboard
│   └── Supply Chain Dashboard.pbix
│
├── Data
│   ├── Suppliers.csv
│   ├── Inventory.csv
│   ├── Shipments.csv
│   └── Customers.csv
│
├── Images
│   ├── dashboard-overview.png
│   ├── supplier-analysis.png
│   ├── inventory-analysis.png
│   ├── shipment-analysis.png
│   ├── customer-analysis.png
│   └── data-model.png
│
├── Documentation
│   └── Project Report.pdf
│
└── README.md
```

---

# 📊 Business KPIs

| KPI | Description |
|------|-------------|
| Gross Revenue | Total revenue generated before deductions |
| Total Revenue | Revenue after adjustments |
| Profit | Overall business profit |
| Profit Margin | Percentage profit generated |
| Perfect Orders | Orders delivered successfully without issues |
| Inventory Quantity | Current stock available |
| Shipment Quantity | Total shipments processed |
| Delivered Quantity | Products successfully delivered |

---

# 💼 Skills Demonstrated

This project demonstrates practical experience in:

- Data Cleaning
- ETL Processes
- Power Query
- Data Modeling
- Star Schema Design
- DAX Calculations
- KPI Development
- Dashboard Design
- Data Visualization
- Business Intelligence
- Supply Chain Analytics
- Data Storytelling

---

# 🚀 Business Impact

This dashboard helps organizations:

✅ Monitor operational performance in real time

✅ Improve supplier management

✅ Reduce shipment delays

✅ Optimize inventory planning

✅ Track customer profitability

✅ Support executive decision-making

---

# 🔮 Future Improvements

Future versions of this project may include:

- Forecasting inventory demand
- Predictive shipment delay analysis
- Supplier risk scoring
- Customer segmentation using RFM analysis
- Mobile-optimized dashboard
- Automated data refresh

---

# 📷 Additional Dashboard Screenshots

## Supplier Performance

![Supplier Analysis](Images/supplier-analysis.png)

---

## Inventory Analysis

![Inventory Analysis](Images/inventory-analysis.png)

---

## Shipment Analysis

![Shipment Analysis](Images/shipment-analysis.png)

---

## Customer Analysis

![Customer Analysis](Images/customer-analysis.png)

---

# 📄 Project Highlights

✔ Executive Dashboard

✔ Interactive Power BI Visualizations

✔ KPI Monitoring

✔ Supply Chain Analytics

✔ Inventory Management

✔ Shipment Performance Tracking

✔ Customer Profitability Analysis

✔ Business Intelligence Reporting

---

# 🤝 Connect With Me

## Abdikhan Mohamed

📧 Email: your.email@example.com

💼 LinkedIn: https://linkedin.com/in/your-linkedin

🌐 Portfolio: https://yourportfolio.com

🐙 GitHub: https://github.com/yourusername

---

## ⭐ If you found this project interesting, consider giving it a star!
