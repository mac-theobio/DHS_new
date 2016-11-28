## First draft of metadata from Carl P.

baseurl <- "http://api.dhsprogram.com/rest/dhs/data"
tarInd <- "FE_FRTR_W_TFR"
countryIds <- c('ZA')

json_file <- jsonlite::fromJSON(
	sprintf("%s/%s?breakdown=all&countryIds=%s"
		, baseurl, tarInd
		, paste(countryIds, collapse = ",")
	)
)

res <- data.table::data.table(json_file$Data)

summary(res)
print(res)
