source("src/000_setup.R")

get_gfw <- function(x, progress = TRUE) {
  with_progress({
    get_resources(
      x,
      get_gfw_treecover(version = "GFC-2023-v1.11"),
      get_gfw_lossyear(version = "GFC-2023-v1.11")
    )
  }, enable = progress)
}

stats_gfw <- function(x, progress = TRUE, min_size = 1, min_cover = 3) {
  with_progress({
      inds <- calc_indicators(
        x,
        calc_treecover_area(years = 2000:2023, min_size = min_size, min_cover = min_cover)
      )
  }, enable = progress)

  inds
}

timings <- run_indicator(
  input = input,
  fetch_resources = get_gfw,
  calc_stats = stats_gfw,
  resource_cores = 10,
  ncores = ncores,
  progress = progress,
  area_threshold = 75000,
  out_path = out_path,
  suffix = "gfw-indicators",
  overwrite =  overwrite
)

saveRDS(timings, file.path(out_path, "gfw-timings.rds"))

