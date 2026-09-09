# 🌱 GreenSteps — Sustainable Living Learning Platform

**ASP.NET Web Forms** version | CT050-3-2-WAPP Assignment

---

## 📋 What's Included

This package contains **complete .aspx source code** for GreenSteps:

### 🌐 Public Pages
- `Default.aspx` — Homepage with feature cards
- `Articles.aspx` — Browse all articles
- `Articles/Details.aspx` — Read full article (login required)
- `Videos.aspx` — Watch YouTube videos
- `Quiz.aspx` — Browse quizzes
- `Quiz/Take.aspx` — Take quiz with scoring (login required)
- `About.aspx` — About page

### 🔐 Account
- `Account/Register.aspx` — Register with validation
- `Account/Login.aspx` — Login by email OR name
- `Account/Logout.aspx` — Logout

### 👑 Admin
- `Admin/Dashboard.aspx` — Live stats overview
- `Admin/Articles/Index.aspx` + `Create.aspx` + `Edit.aspx` — Article CRUD
- `Admin/Videos/Index.aspx` + `Create.aspx` + `Edit.aspx` — Video CRUD
- `Admin/Quizzes/Index.aspx` + `Create.aspx` + `Edit.aspx` + `Questions.aspx` — Quiz CRUD

### 📦 Core Files
- `Site.Master` — Master page (layout, navbar, footer)
- `Content/Site.css` — All styling
- `Web.config` — Configuration (DB connection, sessions)
- `Models/DataAccess.cs` — Database helper class
- `App_Data/setup_database.sql` — Database creation script

---

## 🚀 Setup Instructions (Step-by-Step)

### 1️⃣ Prepare the Project

1. **Open Visual Studio**
2. Create a NEW project → **ASP.NET Web Application (.NET Framework)**
3. Name it `GreenSteps`
4. Choose **Web Forms** template
5. Set framework to **.NET Framework 4.8**
6. Uncheck Docker/Azure options
7. Click **Create**

### 2️⃣ Delete Default Files

In Solution Explorer, DELETE these default files (right-click → Delete):
- `Default.aspx` (all 3: .aspx, .aspx.cs, .aspx.designer.cs)
- `About.aspx`
- `Contact.aspx`
- `Site.Master`
- `Content/Site.css`
- `Web.config`
- Anything in `Account/` folder if present
- Any Bootstrap files (we're not using it)

### 3️⃣ Copy These Files Into Project

Extract the ZIP and copy files into your Visual Studio project:
- Copy ALL `.aspx`, `.aspx.cs`, `.aspx.designer.cs` files into matching folders
- Copy `Site.Master` + `.cs` + `.designer.cs` to project root
- Copy `Content/Site.css` into `Content/` folder
- Copy `Web.config` to project root (replace existing)
- Copy `Models/DataAccess.cs` into `Models/` folder (create folder if needed)

### 4️⃣ In Solution Explorer

Right-click project → **Add** → **Existing Item...** → Select all copied files.

Or just drag the files from File Explorer into the Solution Explorer.

### 5️⃣ Set Up Database

**Option A — Via SQL Server Object Explorer (recommended):**

1. View → **SQL Server Object Explorer**
2. Expand **SQL Server** → **(localdb)\MSSQLLocalDB**
3. Right-click **Databases** → **New Query**
4. Copy content from `App_Data/setup_database.sql`
5. Paste and click **▶ Execute**
6. Wait for "Database setup complete!" message

**Option B — Via Package Manager Console:**

1. Tools → NuGet Package Manager → Package Manager Console
2. Run: `sqlcmd -S "(localdb)\MSSQLLocalDB" -i "App_Data\setup_database.sql"`

### 6️⃣ Test It

Press **F5** → browser opens showing the GreenSteps homepage!

---

## 🔑 Demo Login Credentials

| Role | Email | Password |
|---|---|---|
| 👑 Admin | admin@greensteps.com | admin123 |
| 👤 User | user@greensteps.com | user123 |

**You can also login using just your FULL NAME:**
- Admin: `Admin` / `admin123`
- User: `Demo User` / `user123`

---

## ✨ Features Implemented

| Feature | Notes |
|---|---|
| 🌱 Beautiful green homepage | Feature cards, gradients, animations |
| 🔐 Register with validation | Email regex, password rules, match check |
| 🎯 Login by email OR name | Case-insensitive |
| 👋 Logout with confirmation | JavaScript popup |
| 👑 Role-based access control | Admin sees dropdown menu |
| 📚 Articles CRUD | Create, Read, Update, Delete |
| 🎬 Videos with YouTube embeds | Auto-thumbnail in admin |
| 🧠 Quiz module | Take quiz, instant scoring, score circle |
| ❓ Question management | Add/delete questions inline |
| 🛡️ Access protection | Session-based auth |
| 🎨 Full CSS design | Sticky header, responsive, mobile-friendly |
| ✅ Form validation | ASP.NET validators |

---

## 🐛 Troubleshooting

**Problem:** Page shows "Database not found"
- **Solution:** Run the SQL setup script (step 5)

**Problem:** Yellow error page after F5
- **Solution:** Check `Web.config` was copied correctly to root

**Problem:** Master page not applying (no navbar)
- **Solution:** Make sure `Site.Master` is at project ROOT (not in a folder)

**Problem:** Login says "invalid credentials"
- **Solution:** Verify database was seeded — check the SQL Users table has admin/user rows

**Problem:** "The type or namespace 'GreenSteps' could not be found"
- **Solution:** Right-click project → Properties → check namespace is `GreenSteps`

---

## 📁 Folder Structure

```
GreenSteps/
├── Account/
│   ├── Login.aspx (+ .cs + .designer.cs)
│   ├── Logout.aspx (+ .cs + .designer.cs)
│   └── Register.aspx (+ .cs + .designer.cs)
├── Admin/
│   ├── Dashboard.aspx (+ .cs + .designer.cs)
│   ├── Articles/
│   │   ├── Index.aspx (+ .cs + .designer.cs)
│   │   ├── Create.aspx (+ .cs + .designer.cs)
│   │   └── Edit.aspx (+ .cs + .designer.cs)
│   ├── Videos/
│   │   ├── Index.aspx (+ .cs + .designer.cs)
│   │   ├── Create.aspx (+ .cs + .designer.cs)
│   │   └── Edit.aspx (+ .cs + .designer.cs)
│   └── Quizzes/
│       ├── Index.aspx (+ .cs + .designer.cs)
│       ├── Create.aspx (+ .cs + .designer.cs)
│       ├── Edit.aspx (+ .cs + .designer.cs)
│       └── Questions.aspx (+ .cs + .designer.cs)
├── App_Data/
│   └── setup_database.sql
├── Articles/
│   └── Details.aspx (+ .cs + .designer.cs)
├── Content/
│   └── Site.css
├── Models/
│   └── DataAccess.cs
├── Quiz/
│   └── Take.aspx (+ .cs + .designer.cs)
├── About.aspx (+ .cs + .designer.cs)
├── Articles.aspx (+ .cs + .designer.cs)
├── Default.aspx (+ .cs + .designer.cs)
├── Quiz.aspx (+ .cs + .designer.cs)
├── Videos.aspx (+ .cs + .designer.cs)
├── Site.Master (+ .cs + .designer.cs)
└── Web.config
```

---

## 🏆 Assignment Marking Coverage

| Criteria (10% each) | Feature |
|---|---|
| Web Page Layout & Appearance | ✅ Complete green theme, responsive, animations |
| User Authentication & Authorization | ✅ Register, Login, Logout, Roles |
| Dynamic Content | ✅ Database-driven pages, personalized |
| Insert/Update/Delete Records | ✅ Full CRUD on Articles, Videos, Quizzes |
| Form Validation & Navigation | ✅ Validators, sticky navbar, breadcrumbs |

---

## 👨‍💻 Built For

- **Module:** CT050-3-2-WAPP — Web Applications
- **University:** Asia Pacific University (APU)
- **Tech Stack:** ASP.NET Web Forms • C# • SQL Server LocalDB • HTML5 • CSS3
- **Framework:** .NET Framework 4.8

---

## 🎯 Success!

If you follow all the steps above, you should have a **fully working Web Forms** application with all the features of the original Razor Pages version! 🚀

Good luck with your assignment! 🌱
