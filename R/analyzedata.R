MILES_TO_KM = 1.609

#' Determines which routes are the busiest
#' @param dataframe dataframe to be used
#' @param startcol column for the starting location of the flight
#' @param endcol column for the ending location of the flight
#' @returns dataset containing distance from start to end location by passanger number
#' @export
busiest_routes = function (dataframe, startcol, endcol) {
  stopifnot(all({{dataframe}}$Passengers >= 1))
  stopifnot(all(!is.na({{dataframe}}$Passengers)))

  pairs = group_by({{dataframe}}, {{startcol}}, {{endcol}}) %>%
    summarize(Passengers=sum(Passengers), distance_km=first(Distance) * MILES_TO_KM)
  arrange(pairs, -Passengers)

  pairs = mutate(pairs,
                 airport1 = if_else({{startcol}} < {{endcol}}, {{startcol}}, {{endcol}}),
                 airport2 = if_else({{startcol}} < {{endcol}}, {{endcol}}, {{startcol}}))

  pairs = group_by(pairs, airport1, airport2) %>% summarize(
    Passengers=sum(Passengers),
    distance_km=first(distance_km))

  return(arrange(pairs, -Passengers))
}

#' Determines market shares for airlines in airports
#' @param dataframe dataframe to be used
#' @param carrier column for airline carrier
#' @param origin column for city/airport or origin
#' @returns dataset containing percent of passengers in each airport for an airline
#' @export
market_shares = function(dataframe, carrier, origin) {
  mkt_shares = group_by({{dataframe}}, {{carrier}}, {{origin}}) %>%
    summarize(Passengers=sum(Passengers)) %>%
    group_by({{origin}}) %>%
    mutate(market_share=Passengers/sum(Passengers)*100, total_passengers=sum(Passengers)) %>%
    ungroup()

  result = arrange(mkt_shares, -market_share)
  return(result)
}
