# 📘 codebookgen — Enhanced Codebook/Documentation Generator for Stata

`gencodebook` is a professional tool for generating comprehensive codebooks or documentation from Stata datasets. It creates clean, well-organized Excel reports with rich metadata, helping users quickly understand the structure and content of their datasets.

---

## 🔧 Installation

To install the package in Stata, run the following command:

```stata
net install gencodebook, from("https://raw.githubusercontent.com/RanaRedoan/gencodebook/main") replace
```

---

## 🚀 Syntax

```stata
gencodebook [varlist] using "filename.xlsx", replace
```

- `varlist` *(optional)*: Specify variables to include. If omitted, all labeled variables are used.
- `using "filename.xlsx"` *(required)*: Name of the output Excel file.
- `replace` *(optional)*: Overwrites an existing Excel file with the same name.

---

## 📝 Description

`gencodebook` generates professional Excel-based codebooks with rich documentation. It automatically extracts and organizes the following metadata for each selected variable:

- Variable names
- Variable labels
- Missing and non-missing value statistics
- Variable storage types

---

## 📁 Output Structure

The resulting Excel file includes the following columns:

| Column     | Description                                            |
|------------|--------------------------------------------------------|
| Variable   | Variable name                                          |
| Label      | Variable label                                         |
| Type       | Stata storage type                                     |
| Missing    | Count of missing observations                          |
| Obs        | Count of non-missing observations                      |

---


---

## 📌 Example

```stata
gencodebook using "Test_Codebook.xlsx", replace
```

This will generate a fully formatted codebook of all labeled variables in your dataset and save it as an Excel file named `Test_Codebook.xlsx`.

---

## 👨‍💻 Author

**Md. Redoan Hossain Bhuiyan**  

📧 redoanhossain630@gmail.com
