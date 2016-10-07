# analyze survey data for free (http://asdfree.com) with the r language
# demographic and health surveys
# all available years
# all approved countries

auth <- read.csv(input_files[[1]]
	, header=FALSE
	, stringsAsFactors = FALSE
)[[1]]

# # # # # # # # # # # # # # # # #
# # block of code to run this # #
# # # # # # # # # # # # # # # # #

your.username <- auth[[1]]
your.password <- auth[[2]]
your.project <- auth[[3]]

library(downloader)
# setwd( "C:/My Directory/DHS/" )
# source_url( "https://raw.githubusercontent.com/ajdamico/asdfree/master/Demographic%20and%20Health%20Surveys/download%20and%20import.R" , prompt = FALSE , echo = TRUE )
# # # # # # # # # # # # # # #
# # end of auto-run block # #
# # # # # # # # # # # # # # #

# contact me directly for free help or for paid consulting work

# anthony joseph damico
# ajdamico@gmail.com


####################################################################################
# download every file from every year of the Demographic and Health Surveys with R #
# then save every file as an R data frame (.rda) so future analyses can be rapid   #
####################################################################################


# # # # # # # # # # # # # #
# important user warning! #
# # # # # # # # # # # # # #

# you *must* visit this dhsprogram.com website and explain your research
# before receiving a username and password.

# this is to protect both yourself and the respondents of the study.  register here:
# http://dhsprogram.com/data/Access-Instructions.cfm

# once you have registered, place your username, password, and the name of your project in the script below.
# this script will not run until valid values are included in the lines below.
# oh and don't forget to uncomment these lines by removing the `#`

# your.username <- "username"
# your.password <- "password"
# your.project <- "project"

# this massive ftp download automation script will not work without the above lines filled in.
# if the three lines above are not filled in with the details you provided at registration, 
# the script is going to break.  to repeat.  register to access dhs data.


# # # # # # # # # # # # # # # # # 
# end of important user warning #
# # # # # # # # # # # # # # # # #


# set your working directory.
# all DHS data files will be stored here
# after downloading.
# use forward slashes instead of back slashes

# uncomment this line by removing the `#` at the front..
# setwd( "C:/My Directory/DHS/" )
# ..in order to set your current working directory



# remove the # in order to run this install.packages line only once
# install.packages( c( "XML" , "httr" ) )

# no need to edit anything below this line #


# # # # # # # # #
# program start #
# # # # # # # # #


library(foreign) 	# load foreign package (converts data files into R)
library(httr)		# load httr package (downloads files from the web, with SSL and cookies)
library(XML)		# load XML (parses through html code to extract links)


# authentication page
terms <- "https://dhsprogram.com/data/dataset_admin/login_main.cfm"

# projects page
projects.page <- "https://dhsprogram.com/data/dataset_admin/"

# countries page
countries.page <- "https://dhsprogram.com/data/dataset_admin/download-datasets.cfm"

# create a temporary file and temporary directory
tf <- tempfile() ; td <- tempdir()


# set the username and password
values <- 
	list( 
		UserName = your.username , 
		UserPass = your.password 
	)

# log in.
GET( terms , query = values )
POST( terms , body = values )

# extract the available countries from the projects page
z <- GET( projects.page )

# write the information from the `projects` page to a local file
# writeBin( z$content , tf )

# load the text 
# y <- readLines( tf )

# figure out the project number
# project.line <- unique( y[ grep( paste0( "option value(.*)" , your.project ) , y ) ] )
project.line <- your.project

# confirm only one project
stopifnot( length( project.line ) == 1 ) 

# extract the project number from the line above
project.number <- gsub( "(.*)<option value=\"([0-9]*)\">(.*)" , "\\2" , project.line )

# log in again, but specifically with the project number

# re-access the download-datasets page
z <- 
	POST( 
		"https://dhsprogram.com/data/dataset_admin/download-datasets.cfm" , 
		body = list( proj_id = project.number ) 
	)

c <- xmlTreeParse(content(z))

print(class(c))

# figure out which countries are available for download
country.names <- xpathSApply( content( c ) , "//option")
country.numbers <- xpathSApply( content( c ) , "//option" , xmlGetAttr , "value" )

