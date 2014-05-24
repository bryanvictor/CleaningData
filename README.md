This script takes 6 separate files, reads them into R 
and eventually produces a clean data set with some basic statistical analysis.

The first step is to combine all six files into a single data frame using
a combination of row and column binding.

Once that is complete, column names need to be imported.

The code replaces numeric values for activity with strings.

The data frame is then transformed using the melt function from the reshape package.

Finally mean is calculated based on both subject id and activity across the frame, and
a txt file is exported to the working directory.