selectOccs_UI <- function(id) {
  ns <- NS(id)
  tagList(
    
  )
}

selectOccs_MOD <- function(input, output, session, rvs) {
  
  reactive({
    if (is.null(rvs$occs)) {
      rvs %>% writeLog(type = 'error', "Before processing occurrences, 
                       obtain the data in component 1.")
      return()
    }
    if (is.null(rvs$polySelXY)) {
      rvs %>% writeLog(type = 'error', 'The polygon has not been finished. Please 
                                        press "Finish" on the map toolbar, then 
                                        the "Select Occurrences" button.')
      return()
    }
    
    occs.xy <- rvs$occs[c('longitude', 'latitude')]
    
    # make spatial pts object of original occs and preserve origID
    pts <- sp::SpatialPointsDataFrame(occs.xy, data=rvs$occs['occID'])
    
    newPoly <- sp::SpatialPolygons(list(sp::Polygons(list(sp::Polygon(rvs$polySelXY)), ID=rvs$polySelID)))  # create new polygon from coords
    
    intersect <- sp::over(pts, newPoly)
    ptSelIndex <- as.numeric(which(!(is.na(intersect))))
    
    selIDs <- as.numeric(pts[ptSelIndex,]$occID)
    
    occs.sel <- rvs$occs[ptSelIndex,]
    
    rvs %>% writeLog("Keeping only occurrences with occID = ", selIDs, 
                     ". Updated data has n = ", nrow(occs.sel), " records.")
    return(occs.sel)
  })
}
