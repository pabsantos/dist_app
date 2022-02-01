create_linestring <- function(points) {
  points %>% 
    st_drop_geometry() %>% 
    drop_na(LONG, LAT) %>% 
    filter(LONG != 0, LAT != 0) %>% 
    mutate(
      lag = TIME_ACUM - lag(TIME_ACUM),
      wkt = case_when(
        lag == 1 ~ paste0(
          "LINESTRING (", lag(LONG), " ", lag(LAT), ", ", LONG, " ", LAT, ")"
        ),
        lag > 1 ~ "0",
        lag < 1 ~ "0",
        TRUE ~ NA_character_
      )
    ) %>%
    filter(wkt != "0") %>%
    select(-lag) %>%
    st_as_sf(wkt = "wkt") %>%
    st_set_crs(4674)
}

# transform_linestring <- function(points) {
#   points %>%
#     mutate(coords = st_as_text(geom)) %>%
#     st_drop_geometry() %>%
#     separate(
#       coords, into = c("point", "coords"), sep = "\\s", extra = "merge"
#     ) %>%
#     mutate(
#       lag = TIME_ACUM - lag(TIME_ACUM),
#       wkt = case_when(
#         lag == 1 ~ paste0(
#           "LINESTRING (", str_sub(lag(coords), 2, -2), ", ",
#           str_sub(coords, 2, -2), ")"
#         ),
#         lag > 0 ~ "0",
#         lag < 0 ~ "0",
#         TRUE ~ NA_character_
#       )
#     ) %>%
#     filter(wkt != "0") %>%
#     drop_na(wkt) %>%
#     select(-point, -coords, -lag) %>%
#     st_as_sf(wkt = "wkt") %>%
#     st_set_crs(4674)
# }

calc_dist <- function(lines) {
  lines %>% 
    mutate(DIST = st_length(wkt))
}

transform_csv <- function(lines) {
  lines %>% 
    st_drop_geometry()
}