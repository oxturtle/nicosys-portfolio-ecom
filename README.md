# E‑Commerce Sales Analysis Project  
A data analytics project exploring product performance, regional sales trends, and practical recommendations for a small business selling through **TikTok Shop** and **Squarespace**.

---

## Project Overview  
This project is an updated version of an analysis I originally did for a real e‑commerce business a few months back. To protect the business owner’s data, I recreated the entire project using a **synthetic dataset** that mirrors the structure, patterns, and challenges of the real-world data. This lets me showcase my workflow and problem‑solving approach without exposing any sensitive information.

The main questions I set out to answer were:

1. **Which products are selling the most?**  
2. **Which regions bring in the most revenue?**  
3. **Between the two platforms how much does the business earn?**
4. **What recommendations can help boost future sales?**

---

## Data Sources  
I worked with two synthetic datasets modeled after the real ones:

- **TikTok Shop sales data**  
- **Squarespace website sales data**

Since the business operates on both platforms, I merged everything into one consistent dataset before doing any deeper analysis — just like in the real project.

---

## Tools & Skills Used  

### SQL  
- Cleaning and standardizing data  
- Joining tables from both platforms  
- Aggregating product and regional performance  

### Excel  
- Validating SQL results  
- Quick pivot checks  

### Power BI  
- Data modeling  
- Building interactive dashboards  
- Visualizing product trends, regional sales, and recommendations  

---

## Workflow Summary  
- Pulled raw synthetic data from TikTok Shop and Squarespace  
- Cleaned and standardized fields (dates, product names, regions, etc.)  
- Used SQL joins to combine everything into one unified dataset  
- Implemented null-handling strategy to support consistnet numeric computations
- Double‑checked accuracy in Excel  
- Built a Power BI dashboard to highlight insights  
- Summarized recommendations based on the patterns in the data  

---

## Key Insights  
- Clear list of top‑selling products across both platforms  
- Regions that consistently outperform others  
- Differences in sales behavior between TikTok Shop and Squarespace  
- Opportunities to improve marketing, inventory, and platform strategy  

---

## Recommendations  
Some of the suggestions I provided included:

- Stocking more of the high‑performing products  
- Focusing marketing efforts on the strongest regions  
- Improving product visibility on the weaker platform  
- Using TikTok’s viral nature to push certain product categories  

---

## Presentation Files
- Canva presentation: https://canva.link/vj9li9z9mqki260
- Due to PDF file exceeding GitHub space: https://drive.google.com/file/d/1Om1rC2MustUMBLJuSMJ4lmmhYSH7Efwe/view?usp=sharing


---

## Repository Structure  
```
data/
├── raw/           # Original source data
├── cleaned/       # Processed and analysis-ready datasets
documentation/     # Word files and PDFs updating project progress
excel-validation/  # Checking for accurcy of SQL findings
images/            # Images used for this project
powerbi/           # powerbi files
presentation/      # files involving presentation of e-com portfolio
reports/           # summaries, and insights
sql/               # PostgreSQL queries and transformations
```
