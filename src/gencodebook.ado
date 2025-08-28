*! gencodebook v1.1 - Simplified codebook generator
*! Author: Md. Redoan Hossain Bhuiyan
*! Date: 28 August 2025

program define gencodebook
    version 16
    syntax [varlist] using/, [REPLACE MODIFY SHEET(name) FORMAT EXCELX]
    
    // Validate inputs
    if "`replace'" != "" & "`modify'" != "" {
        di as error "Cannot specify both replace and modify"
        exit 198
    }
    
    if "`sheet'" == "" local sheet "Codebook"
    
    // Default variables if none specified
    if "`varlist'" == "" {
        ds
        local varlist `r(varlist)'
    }
    
    // Set up Excel output
    putexcel set "`using'", `replace' `modify' sheet("`sheet'")
    
    // Write headers
    local headers Variable Label Missing Obs Type
    local col 1
    foreach h of local headers {
        putexcel `:word `col' of `c(ALPHA)''1 = "`h'", bold border(bottom)
        local ++col
    }
    
    // Initialize row counter
    local row 2
    
    // Process each variable
    foreach var of local varlist {
        // Variable label (fallback = var name if empty)
        local varlab : var label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        // Counts
        qui count if !missing(`var')
        local nonmiss = r(N)
        local miss = _N - r(N)
        
        // Variable type
        local type : type `var'
        
        // Write to Excel
        putexcel A`row' = "`var'"
        putexcel B`row' = `"`varlab'"'
        putexcel C`row' = `miss'
        putexcel D`row' = `nonmiss'
        putexcel E`row' = "`type'"
        
        local ++row
    }
    
    // Apply formatting if requested
    if "`format'" != "" {
        // Header row formatting
        putexcel A1:E1, hcenter bold border(bottom, thick)
        // Data formatting
        putexcel A2:E`=`row'-1', hcenter wrap
    }
    
    di as text "Codebook successfully generated in `using'"
end