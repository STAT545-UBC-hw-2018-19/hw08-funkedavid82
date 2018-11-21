Making a shiny app
===================
Homework 8 repository (Jummy David)
===================================

### Welcome to my [STAT547](https://github.com/STAT545-UBC) homework8 repository.

This repo contains the BC Liquor app as a boilerplate for students to add to in Homework 08.

The code and data are from [Dean Attali's tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial). The code can specifically be found [here](https://deanattali.com/blog/building-shiny-apps-tutorial/#12-final-shiny-app-code).


#### My repo is structured as follows:

<table style="width:42%;">
<colgroup>
<col width="23%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Documents</strong></th>
<th><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="https://github.com/STAT545-UBC-students/hw08-funkedavid82/blob/master/README.md">README.md</a></td>
<td>Readme.md file gives a brief description of all I have in the homework8 folder</td>
</tr>
<tr class="even">
<td><a href="https://github.com/STAT545-UBC-students/hw08-funkedavid82/tree/master/bcl">Shiny app folder</a></td>
<td>The built shiny app files and R code on github</td>
</tr>
<tr class="odd">
<td><a href="https://funkedavid82.shinyapps.io/bcld">My shiny app</a></td>
<td>My shiny app on shiny app website</td>
</tr>
</tbody>
</table>

## Added features:

1. Add an option to sort the results table by price.

2. Add an image of the BC Liquor Store to the UI

3. Use the `DT` package to turn the current results table into an interactive table. 

4. Place the plot and the table in separate tabs.

5. Show the number of results found whenever the filters change.

6. Allow the user to download the results table as a ..csv file. 

7. Allow the user to search for multiple alcohol types simultaneously, instead of being able to choose only          wines/beers/etc. 





## References:

1.  [ stat545.com shiny tutorial](http://stat545.com/shiny01_activity.html)

2.  [Vincenzo Coia’s STAT 547 shiny app note](http://stat545.com/Classroom/notes/cm107.nb.html#reactivity)

3.  [ the tutorial on Dean’s website](https://deanattali.com/blog/building-shiny-apps-tutorial/)

4.  [official shiny site](https://shiny.rstudio.com/)