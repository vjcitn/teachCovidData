#' get the BiocFileCache for sars2pack -- code by Sean Davis, extracted
#' and modified by Vince Carey for teachCovidData -- specifically,
#' no automated age check for updating; user must ask for update, otherwise gets cached data
#'
#' Set up or get location of BiocFileCache. By default,
#' this uses the name BiocFileCache.
#'
#' @importFrom BiocFileCache BiocFileCache bfcneedsupdate bfcupdate bfcadd bfcquery bfcrpath
#' 
#' @param cache character(1), the path to the cache directory. See [BiocFileCache::BiocFileCache()].
#'
#' @return a `BiocFileCache` instance
#'
#' @keywords internal
s2p_get_cache <- function(...) {
    BiocFileCache::BiocFileCache()
}

#' @importFrom BiocFileCache bfcneedsupdate bfcdownload bfcadd bfcquery bfcrpath
#' 
s2p_cached_url <- function(url, rname = url, update=FALSE, ...) {
    bfc = s2p_get_cache()
    bfcres = bfcquery(bfc,rname,'rname')

    rid = bfcres$rid
    # Not found, must download
    if (!length(rid)) {
           rid = names(bfcadd(bfc, rname, url))
           bfcdownload(bfc, rid, ask=FALSE, ...)
           }
    # if needs update, do the download
    else if(update) {
        bfcdownload(bfc, rid, ask=FALSE, ...)
    }
    bfcrpath(bfc, rids = rid)
}

