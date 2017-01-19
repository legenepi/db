#' Lookup SNP chromosome and position from UCSC
#'
#' @param snps a vector of rsids
#' @param user username for UCSC mysql access
#' @param host hostname for UCSC mysql access
#' @param dbname database name for UCSC mysql access
#' @param dbsnp database table for UCSC mysql access
#'
#' @return a data frame with columns snp name, chromosome and position
#' @export
#'
#' @examples
#' dbsnp_position(c("rs17216656", "rs726640", "rs587779413"))
dbsnp_position <- function(snps, user="genome", host="genome-mysql.cse.ucsc.edu", dbname="hg19", dbsnp="snp147") {
    require(RMySQL)

    ucsc <- dbConnect(MySQL(), user=user, host=host, dbname=dbname)
    snps <- paste(snps, collapse="','")
    rs <- suppressWarnings(dbSendQuery(ucsc, paste0(
        "select name,chrom,chromEnd from ", dbsnp, " where name in ('", snps, "')"
        )))
    dbFetch(rs, n=-1)
}
