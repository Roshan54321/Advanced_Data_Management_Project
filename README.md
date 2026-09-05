# Mortgage Database Analysis

This project contains a SQLite database for analysing mortgage and housing-related data using SQL.

The repository contains the database schema, data, and SQL queries used for the analysis.

---

## Project Structure

```text
Assessment 2/
│
├── data.sql                 # Data to populate the database
├── schema.sql               # Database structure (tables, columns, constraints)
├── mortgage.db              # SQLite database
├── queries.sql              # SQL analysis queries
```

### File descriptions

| File | Purpose |
|---|---|
| `schema.sql` | Creates the database tables and their structure |
| `data.sql` | Inserts the data into the tables |
| `mortgage.db` | The SQLite database used for the analysis |
| `queries.sql` | Contains SQL queries used to analyse the data |


---

# Requirements

You will need:

- [Visual Studio Code](https://code.visualstudio.com/)
- A SQLite extension for VS Code
- Git, if cloning the repository from GitHub

This project uses **SQLite**, so no database server such as MySQL or PostgreSQL is required.

---

# 1. Clone the Repository

Clone the repository using Git:

```bash
git clone <repository-url>
```

Then move into the project directory:

```bash
cd <repository-folder>
```

Alternatively, you can download the repository as a ZIP file and open the extracted folder in VS Code.

---

# 2. Open the Project in VS Code

Open the project folder in VS Code.

You can use:

```bash
code .
```

or select:

**File → Open Folder**

and select the project folder.

Make sure you open the **entire project folder**, rather than opening only `queries.sql`.

---

# 3. Install the SQLite Extension

The recommended extension for this project is:

**SQLite by Alex Covarrubias**

In VS Code:

1. Open **Extensions** (`Cmd + Shift + X` on macOS).
2. Search for:

```text
SQLite
```

3. Install **SQLite** by **Alex Covarrubias**.

The extension allows SQLite databases to be opened and queried directly inside VS Code. It also provides a database explorer and displays query results in a table. ([Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite&utm_source=chatgpt.com))

---

# 4. Create the SQLite Database

There are two possible situations.

## Option A — `mortgage.db` already exists

If the repository already contains:

```text
mortgage.db
```

you normally **do not need to create it again**.

You can open it directly in VS Code and start querying it.

Skip to [Opening the Database](#5-opening-the-database).

---

## Option B — Create a new database

If `mortgage.db` does not exist, create it using `schema.sql`.

### Using the terminal

Open the VS Code terminal:

**Terminal → New Terminal**

Make sure the terminal is inside the project directory.

Run:

```bash
sqlite3 mortgage.db < schema.sql
```

This creates:

```text
mortgage.db
```

and executes all SQL statements in `schema.sql`.

---

# 5. Load the Data

After creating the database from the schema, populate it using `data.sql`.

Run:

```bash
sqlite3 mortgage.db < data.sql
```

Your database now contains:

```text
Database
    ↓
Tables created by schema.sql
    ↓
Data inserted by data.sql
```

### Verify the tables

Run:

```bash
sqlite3 mortgage.db
```

Then:

```sql
.tables
```

You should see the tables created by `schema.sql`.

To inspect the database schema:

```sql
.schema
```

To exit SQLite:

```sql
.quit
```

---

# 6. Open the Database in VS Code

In the VS Code Explorer, find:

```text
mortgage.db
```

Right-click it and select:

**SQLite: Open Database**

Alternatively:

1. Open the Command Palette:
   - macOS: `Cmd + Shift + P`
   - Windows/Linux: `Ctrl + Shift + P`
2. Search for:

```text
SQLite: Open Database
```

3. Select `mortgage.db`.

The SQLite Explorer should now display the database and its tables.

You can expand the database to inspect:

- Tables
- Columns
- Views

---

# 7. Running `queries.sql`

The important thing to understand is that **`queries.sql` is just a SQL file**. It needs to be associated with `mortgage.db` before the SQLite extension can execute the queries against that database.

Open:

```text
queries.sql
```

Then open the Command Palette:

```text
Cmd + Shift + P
```

Search for:

```text
SQLite: Use Database
```

Select:

```text
mortgage.db
```

This binds the current SQL document to the database. The SQLite extension supports this binding through `SQLite: Use Database`. ([Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite&utm_source=chatgpt.com))

You can then run queries from `queries.sql`.

---


# 8. Recommended Workflow

When working on this project, follow this order:

```text
1. Clone repository
        ↓
2. Open project in VS Code
        ↓
3. Install SQLite extension
        ↓
4. Create/open mortgage.db
        ↓
5. Run schema.sql
        ↓
6. Run data.sql
        ↓
7. Open mortgage.db in SQLite Explorer
        ↓
8. Open queries.sql
        ↓
9. Attach queries.sql to mortgage.db
        ↓
10. Run SQL queries
        ↓
11. View results in VS Code
```

---

# 9. Recreating the Database from Scratch

If you want to completely recreate the database, first remove the existing database.

### macOS/Linux

```bash
rm mortgage.db
```

Then:

```bash
sqlite3 mortgage.db < schema.sql
sqlite3 mortgage.db < data.sql
```

### Windows PowerShell

```powershell
Remove-Item mortgage.db
```

Then:

```powershell
sqlite3 mortgage.db < schema.sql
sqlite3 mortgage.db < data.sql
```

This gives you a fresh database based entirely on:

```text
schema.sql
+
data.sql
```

---