devtools::load_all()
data = data_clean("../odum-modular-design-r-main/data/air_sample.csv", "../odum-modular-design-r-main/data/L_CITY_MARKET_ID.csv",  "../odum-modular-design-r-main/data/L_CARRIERS.csv")
busiest_routes(data, Origin, Dest)
busiest_routes(data, OriginCity, DestCity)
