#' Cleans the datafiles to combine them into one
#' @param datafile main datafile with flight info
#' @param cityfile data file with information on cities
#' @param carrierfile data file with info on airline carrier
#' @returns a joined and cleaned datafile
#' @export
data_clean = function(datafile, cityfile, carrierfile) {
  data = readr::read_csv({{datafile}})
  market_ids = readr::read_csv({{cityfile}})
  data = dplyr::left_join(data, dplyr::rename(market_ids, OriginCity="Description"), by=c(OriginCityMarketID="Code"))
  data = dplyr::left_join(data, dplyr::rename(market_ids, DestCity="Description"), by=c(DestCityMarketID="Code"))

  carriers = readr::read_csv({{carrierfile}})
  data = dplyr::left_join(data, dplyr::rename(carriers, OperatingCarrierName="Description"), by=c(OpCarrier="Code"))
  data = dplyr::left_join(data, dplyr::rename(carriers, TicketingCarrierName="Description"), by=c(TkCarrier="Code"))
}
