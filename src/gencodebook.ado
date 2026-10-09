*! gencodebook v1.1.1 - Simplified codebook generator
*! Author: Md. Redoan Hossain Bhuiyan
*! Date: 10 October 2026

program define gencodebook
    version 16
    syntax [varlist] using/, [REPLACE MODIFY SHEET(name) FORMAT EXCELX]
    
    * -------------------------------------------------------------------------
    * Input Validation
    * -------------------------------------------------------------------------
    if "`replace'" != "" & "`modify'" != "" {
        di as error "{bf:ERROR:} Cannot specify both replace and modify"
        exit 198
    }
    
    if "`sheet'" == "" local sheet "Codebook"
    
    * -------------------------------------------------------------------------
    * Initialize Variables
    * -------------------------------------------------------------------------
    if "`varlist'" == "" {
        ds
        local varlist `r(varlist)'
    }
    
    local varcount : word count `varlist'
    local start_time = clock(c(current_time), "hms")
    
    * Get dataset name (handle paths)
    local dataset_name = subinstr(`"`c(filename)'"', `"""', "", .)
    if "`dataset_name'" == "" {
        local dataset_name "Active Dataset"
    }
    else {
        * Extract just the filename from path
        local dataset_name = subinstr("`dataset_name'", "\", "/", .)
        local dataset_name = substr("`dataset_name'", strrpos("`dataset_name'", "/") + 1, .)
        if "`dataset_name'" == "" local dataset_name "Active Dataset"
    }
    
    * -------------------------------------------------------------------------
    * CLEAN START MESSAGE
    * -------------------------------------------------------------------------
    di ""
    di as text "{hline 70}"
    di as text _col(25) "{bf:CODEBOOK GENERATOR}"
    di as text "{hline 70}"
    di ""
    
    di as text "{bf:Project Details:}"
    di as text "{hline 70}"
    
    di as text "  Dataset:      {result:`dataset_name'}"
    di as text "  Variables:    {result:`varcount'}"
    di as text "  Observations: {result:`=_N'}"
    di as text "  Output File:  {result:`using'}"
    di as text "  Sheet Name:   {result:`sheet'}"
    di as text "  Start Time:   {result:`c(current_time)'}"
    
    di as text "{hline 70}"
    di ""
    
    * -------------------------------------------------------------------------
    * Set up Excel output
    * -------------------------------------------------------------------------
    qui putexcel set "`using'", `replace' `modify' sheet("`sheet'")
    
    * Write headers
    local headers Variable Label Missing Obs Type
    local col 1
    foreach h of local headers {
        qui putexcel `:word `col' of `c(ALPHA)''1 = "`h'", bold border(bottom)
        local ++col
    }
    
    * -------------------------------------------------------------------------
    * Process Variables...
    * -------------------------------------------------------------------------
    local row 2
    local processed 0
    
    * Simple progress indicator
    if `varcount' > 50 {
        di as text "Processing variables [" _c
    }
    else {
        di as text "Processing " _c
    }
    
    * Main processing loop
    foreach var of local varlist {
        * Variable label (fallback = var name if empty)
        local varlab : var label `var'
        if "`varlab'" == "" local varlab "`var'"
        
        * Counts
        qui count if !missing(`var')
        local nonmiss = r(N)
        local miss = _N - r(N)
        
        * Variable type
        local type : type `var'
        
        * Write to Excel
        qui putexcel A`row' = "`var'"
        qui putexcel B`row' = `"`varlab'"'
        qui putexcel C`row' = `miss'
        qui putexcel D`row' = `nonmiss'
        qui putexcel E`row' = "`type'"
        
        local ++row
        local ++processed
        
        * Show progress indicator 
        if `varcount' > 50 {
            * For large datasets, show dots every 2% progress
            local progress_pct = round((`processed'/`varcount') * 100)
            if mod(`progress_pct', 2) == 0 & `progress_pct' > 0 {
                if !inlist(`progress_pct', 2, 4, 6, 8) {  // Skip early small percentages
                    di as text "." _c
                }
            }
        }
        else {
            * For small datasets, show count
            di as text "." _c
        }
    }
    
    * Complete the progress line
    if `varcount' > 50 {
        di as text "]"
    }
    else {
        di ""
    }
    
    di as text "{bf:Processing complete!}"
    di ""
    
    * -------------------------------------------------------------------------
    * Apply Formatting if Requested
    * -------------------------------------------------------------------------
    if "`format'" != "" {
        * Header row formatting
        qui putexcel A1:E1, hcenter bold border(bottom, thick)
        * Data formatting
        qui putexcel A2:E`=`row'-1', hcenter txtwrap
    }
    
    * -------------------------------------------------------------------------
    * Calculate Processing Time
    * -------------------------------------------------------------------------
    local end_time = clock(c(current_time), "hms")
    local elapsed_millisec = (`end_time' - `start_time')
    
    * Format time display
    if `elapsed_millisec' < 1000 {
        local elapsed_display "`elapsed_millisec' milliseconds"
    }
    else if `elapsed_millisec' < 60000 {
        local elapsed_sec = round(`elapsed_millisec'/1000, 0.1)
        local elapsed_display "`elapsed_sec' seconds"
    }
    else {
        local elapsed_sec = `elapsed_millisec'/1000
        local elapsed_min = floor(`elapsed_sec' / 60)
        local elapsed_sec_remain = round(mod(`elapsed_sec', 60))
        local elapsed_display "`elapsed_min' min `elapsed_sec_remain' sec"
    }
    
    * -------------------------------------------------------------------------
    * COMPLETION MESSAGE
    * -------------------------------------------------------------------------
    di as text "{hline 70}"
    di as text _col(27) "{bf:EXECUTION SUMMARY}"
    di as text "{hline 70}"
    di ""
    
    di as text "{bf:Status:}          {result:✓ Completed successfully}"
    di as text "{bf:Variables:}       {result:`varcount' variables processed}"
    di as text "{bf:Processing Time:} {result:`elapsed_display'}"
    di as text "{bf:Rows Created:}    {result:`=`row'-1'}"
    di as text "{bf:Completion Time:} {result:`c(current_time)'}"
    
    di ""
    di as text "{bf:Output File:}"
    di as result "  `using'"
    di as text "{bf:Excel Sheet:}     {result:`sheet'}"
    
    di ""
    di as text "{hline 70}"
    di as text _col(20) "{bf:Ready for use in Microsoft Excel}"
    di as text "{hline 70}"
    di ""
end
