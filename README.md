# 🚄 IRCTC Real-Time Data Pipeline using Google Cloud Platform (GCP)

## 📢 Overview  
The **IRCTC Real-Time Data Pipeline** is a cloud-based data processing system designed to ingest, transform, and store real-time streaming data from IRCTC (Indian Railway Catering and Tourism Corporation). This project leverages **Google Cloud Platform (GCP)** services such as **Pub/Sub, Dataflow (Apache Beam), BigQuery, and Cloud Storage** to enable seamless data processing, transformation, and analysis.

---
## 📊 Project Flowchart
![](https://github.com/sujitmahapatra/IRCTC-RealTime-Data-Pipeline-GCP/blob/5546ff698094b39e722b06b17afb4e83c3820194/IRCTC%20Flowchart.png)


## 📁 Architecture Overview  
### **🔹 Data Flow Pipeline**
1. **Data Ingestion**: Simulated **IRCTC Mock Data** is published to **Google Pub/Sub**.
2. **Data Processing**: A **Dataflow pipeline (Apache Beam)** reads data from Pub/Sub, applies **Python UDFs** for transformation and fault tolerance.
3. **Data Storage**: The transformed data is stored in **Google BigQuery** for analytics.
4. **UDF Registration**: User-defined functions (**transform_UDF.py**) are registered from **Google Cloud Storage** to BigQuery.

---

## ⚙️ Tech Stack  
- **Google Cloud Pub/Sub** → Real-time message streaming  
- **Google Dataflow (Apache Beam)** → Data processing and transformation  
- **Google BigQuery** → Data warehouse for analytics  
- **Google Cloud Storage** → Stores UDF files  
- **Python** → Apache Beam pipeline & UDF implementation  
- **SQL** → Data transformation & querying in BigQuery  
- **Terraform** (Optional) → Infrastructure as Code (IaC) for GCP setup  

---

## 🚀 Features  
✔️ **Real-time data ingestion** using Pub/Sub  
✔️ **Serverless & scalable processing** via Dataflow  
✔️ **Custom transformations** using Python UDFs  
✔️ **Fault tolerance & error handling**  
✔️ **Data warehousing for analytics** using BigQuery  
✔️ **Optimized SQL queries** for analysis and reporting  

---

## 🏗️ Project Structure  

