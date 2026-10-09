# 📘 gencodebook — Enhanced Codebook/Documentation Generator for Stata

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
gencodebook [varlist] using "filename.xlsx" [, replace modify sheet(name) format]
```

- `varlist` *(optional)*: Variables to document. Default: every variable in the dataset.
- `using "filename.xlsx"` *(required)*: Name of the output Excel file.
- `replace` *(optional)*: Overwrites an existing Excel file with the same name.
- `modify` *(optional)*: Writes into an existing workbook, keeping its other sheets. Cannot be combined with `replace`.
- `sheet(name)` *(optional)*: Name of the worksheet. Default: `Codebook`.
- `format` *(optional)*: Bold, centred header and centred, wrapped data cells.

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
| Label      | Variable label (the variable name if it has no label)  |
| Missing    | Count of missing observations                          |
| Obs        | Count of non-missing observations                      |
| Type       | Stata storage type                                     |

---


---

## 📌 Example

```stata
gencodebook using "Test_Codebook.xlsx", replace
```

This will generate a codebook of all variables in your dataset and save it as an Excel file named `Test_Codebook.xlsx`.

```stata
gencodebook age income gender using "Test_Codebook.xlsx", modify sheet(Selected) format
```

This adds a formatted sheet named `Selected`, documenting only `age`, `income` and `gender`, to the same workbook.

---

## 👨‍💻 Author

**Md. Redoan Hossain Bhuiyan**  

📧 redoanhossain630@gmail.com


