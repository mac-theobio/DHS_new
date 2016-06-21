library(httr)		# load httr package (downloads files from the web, with SSL and cookies)
library(XML)		# load XML (parses through html code to extract links)

auth <- read.csv(input_files[[1]]
	, header=FALSE
	, stringsAsFactors = FALSE
)[[1]]

# authentication page
terms <- "https://dhsprogram.com/data/dataset_admin/login_main.cfm"

# projects page
projects.page <- "https://dhsprogram.com/data/dataset_admin/"

# countries page
countries.page <- "https://dhsprogram.com/data/dataset_admin/download-datasets.cfm"

# set the username and password
values <- 
	list( 
		UserName = auth[[1]] 
		, UserPass = auth[[2]]
		, proj_id = auth[[3]]
	)

# log in.
GET( terms , query = values )
POST( terms , body = values )

# extract the available countries from the projects page
z <- GET( projects.page )
z <- POST( 
	"https://dhsprogram.com/data/dataset_admin/download-datasets.cfm"
	, body = values
)

# figure out which countries are available for download
country.names <- xpathSApply( content( z ) , "//option" , xmlValue )
country.numbers <- xpathSApply( content( z ) , "//option" , xmlGetAttr , "value" )

data.frame(country.names, country.numbers)
