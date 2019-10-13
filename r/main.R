## Step 1. Download shapefiles through this link: https://www.cartographersguild.com/attachment.php?attachmentid=73097&d=1430486966

## Step 2. Import libraries 
library(data.table)
library(ggplot2)
library(sf)
library(stringi)
#install.packages("gifski") #gif renderer
#install.packages("png")

#setwd(WorkingDirectoryPath) # set your working directory 

## Step 3. Import relevant shapefiles from download in step 1: 

locations <- st_read("./inst/01_Input/GoTRelease/locations.shp")
landscape <- st_read("./inst/01_Input/GoTRelease/landscape.shp")
continents <- st_read("./inst/01_Input/GoTRelease/continents.shp")
rivers <- st_read("./inst/01_Input/GoTRelease/rivers.shp")
roads <- st_read("./inst/01_Input/GoTRelease/roads.shp")
lakes <- st_read("./inst/01_Input/GoTRelease/lakes.shp")

arya <- structure(list(Season = c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
                                  2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 
                                  3L, 4L, 4L, 4L, 4L, 4L, 4L, 5L, 5L, 5L, 5L, 5L, 5L, 6L, 6L, 6L, 
                                  6L, 6L, 6L, 6L, 6L, 7L, 7L, 7L, 7L, 7L, 7L, 8L, 8L, 8L, 8L, 8L, 
                                  8L), Episode = c(1L, 2L, 3L, 4L, 5L, 6L, 8L, 9L, 10L, 2L, 3L, 
                                                   4L, 5L, 6L, 7L, 8L, 10L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 
                                                   1L, 3L, 5L, 7L, 8L, 10L, 2L, 3L, 6L, 8L, 9L, 10L, 1L, 2L, 3L, 
                                                   5L, 6L, 7L, 8L, 10L, 1L, 2L, 4L, 5L, 6L, 7L, 1L, 2L, 3L, 4L, 
                                                   5L, 6L), Location = c("Winterfell", "Crossroads Inn", "King's Landing", 
                                                                         "King's Landing", "King's Landing", "King's Landing", "King's Landing", 
                                                                         "King's Landing", "King's Landing", "Kingsroad in Riversland", 
                                                                         "Kingsroad in Riversland", "Harrenhal", "Harrenhal", "Harrenhal", 
                                                                         "Harrenhal", "Harrenhal", "Riverlands", "Riverlands", "Crossroads Inn", 
                                                                         "Hollow Hill", "Hollow Hill", "Riverlands Outside Hollow Hill", 
                                                                         "Riverlands Outside Hollow Hill", "Red Fork of the Trident", 
                                                                         "The Twins", "Outside The Twins", "Riverlands to the Vale", "Riverlands to the Vale", 
                                                                         "Riverlands to the Vale", "Riverlands to the Vale", "The Bloody Gate", 
                                                                         "Saltpans", "Braavos", "Braavos", "Braavos", "Braavos", "Braavos", 
                                                                         "Braavos", "Braavos", "Braavos", "Braavos", "Braavos", "Braavos", 
                                                                         "Braavos", "Braavos", "The Twins", "The Twins", "Crossroads Inn", 
                                                                         "Winterfell", "Winterfell", "Winterfell", "Winterfell", "Winterfell", 
                                                                         "Winterfell", "Winterfell", "Winterfell", "King's Landing", "West of Westeros"
                                                   ), Link = c(NA, "https://gameofthrones.fandom.com/wiki/Inn_at_the_Crossroads", 
                                                               NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "North of Harrenhall on the way to Riverrun", 
                                                               "Not too far away in the Riverlands, Arya Stark, Gendry, and Hot Pie are heading north from Harrenhal, planning to eventually reach the Red Fork of the Trident River and then follow it west to her grandfather's castle-seat at Riverrun. ", 
                                                               NA, "https://gameofthrones.fandom.com/wiki/Hollow_Hill", "https://gameofthrones.fandom.com/wiki/Hollow_Hill", 
                                                               "In the Riverlands, the hideout of the Brotherhood without Banners outside of Hollow Hill, Anguy trains Arya Stark with a bow", 
                                                               NA, "Arya Stark, now a captive of Sandor Clegane after he kidnapped her from the Brotherhood Without Banners, picks up a rock and stands over him planning to strike. rya believed he was taking her back to King's Landing, but he reveals that he is in fact taking her to The Twins", 
                                                               NA, "On the way to the vale", NA, NA, NA, NA, NA, "https://gameofthrones.fandom.com/wiki/Saltpans", 
                                                               NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "Also, and then south of the Twins. Later, Arya, having acquired a horse, is riding south when she stumbles upon a group of Lannister soldiers who have been sent to the Twins to keep law and order. To King's Landing", 
                                                               NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA), lon = c(NA, NA, 
                                                                                                                    NA, NA, NA, NA, NA, NA, NA, 19.0782297, 19.0782297, NA, NA, NA, 
                                                                                                                    NA, NA, 16, 15.5, NA, NA, NA, 13.40610796, 13.40610796, 13.81266279, 
                                                                                                                    NA, 14, 15, 18, 18.5, 19, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                                                                                                    NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                                                                                                    NA, NA, -0.75), lat = c(NA, NA, NA, NA, NA, NA, NA, NA, NA, 4.953605834, 
                                                                                                                                            5.953605834, NA, NA, NA, NA, NA, 8.879986668, 9, NA, NA, NA, 
                                                                                                                                            6.720427811, 6.920427811, 9.991984175, NA, 14, 13.5, 12.7, 12.5, 
                                                                                                                                            12, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 
                                                                                                                                            NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 17.2), EpisodeName = c("Winter Is Coming", 
                                                                                                                                                                                                                   "The Kingsroad", "Lord Snow", "Cripples, Bastards, and Broken Things", 
                                                                                                                                                                                                                   "The Wolf and the Lion", "A Golden Crown", "The Pointy End", 
                                                                                                                                                                                                                   "Baelor", "Fire and Blood", "The Night Lands", "What is Dead May Never Die", 
                                                                                                                                                                                                                   "Garden of Bones", "The Ghost of Harrenhal", "The Old Gods and the New", 
                                                                                                                                                                                                                   "A Man Without Honor", "The Prince of Winterfell", "Valar Morghulis", 
                                                                                                                                                                                                                   "Dark Wings, Dark Words", "Walk of Punishment", "And Now His Watch is Ended", 
                                                                                                                                                                                                                   "Kissed by Fire", "The Climb", "The Bear and the Maiden Fair", 
                                                                                                                                                                                                                   "Second Sons", "The Rains of Castamere", "Mhysa", "Two Swords", 
                                                                                                                                                                                                                   "Breaker of Chains", "First of His Name", "Mockingbird", "The Mountain and the Viper", 
                                                                                                                                                                                                                   "The Children", "The House of Black and White", "High Sparrow", 
                                                                                                                                                                                                                   "Unbowed, Unbent, Unbroken", "Hardhome", "The Dance of Dragons", 
                                                                                                                                                                                                                   "Mother's Mercy", "The Red Woman", "Home", "Oathbreaker", "The Door", 
                                                                                                                                                                                                                   "Blood of My Blood", "The Broken Man", "No One", "The Winds of Winter", 
                                                                                                                                                                                                                   "Dragonstone", "Stormborn", "The Spoils of War", "Eastwatch", 
                                                                                                                                                                                                                   "Beyond the Wall", "The Dragon and the Wolf", "Winterfell", "A Knight of the Seven Kingdoms", 
                                                                                                                                                                                                                   "The Long Night", "The Last of the Starks", "The Bells", "The Iron Throne"
                                                                                                                                            )), .Names = c("Season", "Episode", "Location", "Link", "lon", 
                                                                                                                                                           "lat", "EpisodeName"), row.names = c(NA, -58L), class = c("data.table", 
                                                                                                                                                                                                                     "data.frame"))
## Step 5. Assign lat, lon associated with each episode: 

locationsDat <- cbind(as.data.table(locations), st_coordinates(locations))

arya[locationsDat, `:=`(x = X, y = Y), on = .(Location = name)]

## assign missing locations to manually imputed geolocation 
arya[is.na(x), x := lon]
arya[is.na(y), y := lat]

arya[, Season_Episode := paste0(Season, " - ",Episode)]

## Step 6. Data manipulation for plotting purposes 
arya[, TextLabel := paste0(Season_Episode,":","\n",EpisodeName)]
arya[, TextLabel := stri_pad_right(TextLabel, width = max(stri_width(arya$TextLabel)))] ## expand column to get consistent box in plot
arya[, IDnum := 1:.N] ## needed to create gif

## Step 7. Create your ggplot object. Notice at the end of the call we use `transition_manual` to specify what the we want to loop through. Here I just used the rowID to go through all the rows in the dataset (all rows are unique). 
p <- ggplot(continents) + geom_sf()  + xlim(c(-9,45)) + ylim(c(-14,48))  + xlab("") + ylab("") + theme_minimal() + labs(title = "Where Arya?") + theme(plot.title = element_text(hjust = 0.3, family = "Luminari", size = 28), plot.subtitle = element_text(hjust = 0.3, family = "Luminari", size = 22), legend.position = "none", text=element_text(family = "Luminari")) + geom_sf(data = rivers, color = "light blue") + geom_sf(data = lakes, color = "light blue", fill = "light blue") + geom_sf(data = roads, color = "goldenrod1") + geom_point(data = arya, aes(x = x, y=y, color = as.factor(Season))) + geom_label(family = "Luminari", data = arya, aes(label = Location, x = x, y = y+2), size = 4) + geom_label(family = "Luminari", data = arya, aes(label = TextLabel), hjust = "left", x = -1, y = 47, size = 5.4, label.size = NA, fill = "white") + transition_manual(IDnum)

## Step 8. Slow down or speed up your gif! 
p1 <- animate(p, fps=1) # increase fps to create faster looping

## Step 9. Save your output
anim_save(filename = "./inst/02_Output/animation.gif", animation = p1)

#Since gifs don't show up in github, you need to download the gif and open it in a web browser
