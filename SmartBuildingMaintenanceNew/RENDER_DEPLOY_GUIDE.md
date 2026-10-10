# Smart Building Maintenance System - Render Deployment Guide

Yeh project **Java (JSP / Servlets) + Apache Tomcat 9 + MySQL** par bana hai. Render par ise deploy karne ke liye hum **Docker** use karte hain (jiska `Dockerfile` project me ready kar diya gaya hai).

---

## 📌 Complete Deployment Process (3 Simple Steps)

---

### STEP 1: Free Cloud MySQL Database Banana (2 Minutes)

Render par built-in free MySQL nahi hota, isliye hume ek free Cloud MySQL database chahiye. Sabse best aur 100% free option hai **TiDB Cloud** ya **Aiven**:

#### Option A: TiDB Cloud (Recommended - Free Forever)
1. **Website pe jayein**: [https://tidbcloud.com](https://tidbcloud.com) aur free sign up karein (Google se login kar sakte hain).
2. **"Create Cluster"** par click karein aur **"Serverless" (Free Tier)** select karein.
3. Cluster banne ke baad aapko **Connection Details** milengi:
   - **Host** (e.g., `gateway01.ap-southeast-1.prod.aws.tidbcloud.com`)
   - **Port** (e.g., `4000`)
   - **User** (e.g., `xxxx.root`)
   - **Password** (jo password aap set karenge)
4. TiDB dashboard me **"SQL Editor"** par click karein aur project ka [`database/schema.sql`](database/schema.sql) paste karke **Run** kar dein. Isse tables aur demo data create ho jayega.

---

### STEP 2: Project Ko GitHub Par Upload Karna

1. [GitHub.com](https://github.com) par jayein aur ek **New Repository** banayein:
   - Naam: `SmartBuildingMaintenanceNew`
   - Type: **Public** ya **Private**
2. Is project ke sabhi folders (`src`, `web`, `database`, `Dockerfile`, `render.yaml`) ko apne GitHub repo me upload/push karein:
   - Aap **GitHub Desktop** use kar sakte hain, ya
   - VS Code ke Source Control se Push kar sakte hain, ya
   - GitHub website par "Upload files" par click karke upload kar sakte hain.

---

### STEP 3: Render Par Deploy Karna (1-Click)

1. **Render par jayein**: [https://dashboard.render.com](https://dashboard.render.com) (GitHub se sign in karein).
2. **"New +"** button par click karein aur **"Web Service"** select karein.
3. Apni GitHub repository (`SmartBuildingMaintenanceNew`) select karein aur **Connect** par click karein.
4. Settings enter karein:
   - **Name**: `smart-building-maintenance` (ya koi bhi manchaha naam)
   - **Region**: Singapore / Oregon (koi bhi)
   - **Runtime**: **Docker** (Render automatically `Dockerfile` detect kar lega)
   - **Instance Type**: **Free** ($0/month)
5. Niche **"Environment Variables"** section me jayein aur yeh 5 variables add karein:

| Key | Value (Step 1 se) |
| :--- | :--- |
| `DB_HOST` | Aapka Cloud MySQL Host |
| `DB_PORT` | `3306` (ya TiDB ka `4000`) |
| `DB_NAME` | `smart_building_new` |
| `DB_USER` | Aapka Cloud MySQL Username |
| `DB_PASSWORD` | Aapka Cloud MySQL Password |

6. **"Deploy Web Service"** par click karein!

---

## 🚀 Result
Render 2 se 3 minute me Docker image build karega aur Tomcat start kar dega.
Aapko ek live public link mil jayegi:
👉 **`https://smart-building-maintenance-xxxx.onrender.com/`**

Aapka website internet par live ho jayega aur koi bhi browser se ise access kar sakega!
