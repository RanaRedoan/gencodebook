{smcl}
{* *! version 1.1 [07-07-2025] Md. Redoan Hossain Bhuiyan}
{hline}
help for {bf:gencodebook}
{hline}

{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{cmd:gencodebook} {hline 2}}Simplified codebook generator{p_end}
{p2colreset}{...}

{title:Syntax}

{p 8 17 2}
{cmd:gencodebook} 
{cmd:using "filename.xlsx"}
{cmd:,} 
{cmd:replace}

{title:Description}

{pstd}
{cmd:gencodebook} creates a clean codebook in Excel format.
It extracts variable names, labels (or variable name if label is missing), 
storage type, and missing/non-missing counts. 
This provides quick and professional dataset documentation.

{title:Options}

{phang}
{opt using} specifies the output Excel filename (required).

{phang}
{opt replace} overwrites an existing Excel file.

{title:Output Structure}

{pstd}
The generated codebook includes these columns:

{p2colset 9 24 26 2}{...}
{p2col :Variable}Variable name{p_end}
{p2col :Label}Variable label (or variable name if unlabeled){p_end}
{p2col :Missing}Count of missing values{p_end}
{p2col :Obs}Count of non-missing values{p_end}
{p2col :Type}Stata storage type{p_end}
{p2colreset}{...}

{title:Examples}

{phang2}{cmd:. gencodebook using "Test_Codebook.xlsx", replace}{p_end}

{title:Remarks}

{pstd}- If a variable has no label, its name will appear in the Label column{p_end}
{pstd}- Works with both numeric and string variables{p_end}
{pstd}- Includes all variables by default{p_end}

{title:Author}

{pstd}[Md. Redoan Hossain Bhuiyan]{p_end}
{pstd}Email: {browse "mailto:redoanhossain630@gmail.com":redoanhossain630@gmail.com}{p_end}

{title:Also see}

{psee}
Manual: {help codebook}, {help describe}
