library(dplyr)
library(tidyr)
library(lubridate)
library(knitr)
# Load activities
activities <- read.csv("tables/common.csv", stringsAsFactors = FALSE)
activities <- rbind(activities, read.csv("tables/tutorials.csv", stringsAsFactors = FALSE))
activities <- rbind(activities, read.csv("tables/workshops.csv", stringsAsFactors = FALSE))
#activities <- rbind(activities, read.csv("tables/pd.csv", stringsAsFactors = FALSE))
# Load activities names
activities_names <- read.csv("tables/activities_name_room.csv", stringsAsFactors = FALSE)
# Load group names
group_names <- read.csv("tables/group_names.csv", stringsAsFactors = FALSE)
# Join
activities <- inner_join(activities, activities_names)
# Transform into rows
activities <- activities %>% gather(Group, Tmp, 5:16) %>% filter(Tmp == 1) %>% select(-Tmp)
# Join with group names
activities <- inner_join(activities, group_names)

# Create a column for starting time; arrange all events by group and start time
activities <- activities %>% 
  rowwise() %>% 
  mutate(StartTime = paste0("9/", Day, "/2018 ", strsplit(Time, "-")[[1]][1], " ", AMPM)) %>% 
  mutate(StartTime = parse_date_time(StartTime, "%m/%d/%Y %I:%M %p", tz = "America/New_York")) %>% 
  arrange(Group, StartTime)

##### GROUP SCHEDULE
{
for (my_group in sort(unique(activities$Group))){
  group_activities <- activities %>% filter(Group == my_group)
  group_name_long <- group_activities$Long[1]
  group_name_long_nospace <- gsub(" ", "_", group_name_long)
  sink(file = paste0("../", group_name_long_nospace, ".Rmd")) # Create Rmd file
  # Some headers
  cat("---
header-includes:
  - \\usepackage{fancyhdr}
  - \\pagestyle{fancy}
  - \\usepackage{lmodern}
  - \\usepackage{xcolor}
  - \\usepackage{sectsty}
  - \\definecolor{bsdqbio}{rgb}{0.44, 0.16, 0.39}
  - \\sectionfont{\\color{bsdqbio}}
  - \\subsectionfont{\\color{bsdqbio}}
  - \\subsubsectionfont{\\color{bsdqbio}}
  - \\setlength\\heavyrulewidth{0ex}
output:
  pdf_document:
    fig_height: 2
    latex_engine: xelatex
    keep_tex: true
---")
  cat("\n# BSD qBio$^4$ @ MBL")
  cat("\n\n")
  cat(paste0("## Group Schedule: *", group_name_long, "*"))
  cat("\n")
  if (group_activities$Pic[1] != "TBD") cat(paste0(' ![](', group_activities$Pic[1], ')     ')) # note the special character to fool MarkDown not to add a caption
  cat("\n\n")
  # For markdown tables, you want to align the text properly. For this reason, we need to find out 
  # what is the max length of the strings we're going to type
  ll <- max(nchar(group_activities$Time)) + 7
  lr <- max(nchar(group_activities$Description)) + 2
  
  for (my_day in sort(unique(activities$Day))){
    #cat("\n-------\n\n")
    # Build Day
    group_daily <- group_activities %>% filter(Day == my_day)
    name_day <- wday(group_daily$StartTime[1], label = TRUE, abbr = FALSE)
    name_day <- paste0(name_day, ", September ", my_day)
    cat(paste("###", name_day, "\n\n"))
    cat(paste0(
      paste0(rep("-", ll), collapse = ""),
      "    ",
      paste0(rep("-", lr), collapse = ""),
      "\n"))
    for (i in 1:nrow(group_daily)){
      ldesc <- substr(paste0("**", group_daily[i,"Time"], "**", paste0(rep(" ", ll), collapse = "")), 1, ll)
      rdesc <- substr(paste0(group_daily$Description[i], paste0(rep(" ", lr), collapse = "")), 1, lr)
      cat(paste0(ldesc, "    ", rdesc, "\n"))
    }
    cat(paste0(
      paste0(rep("-", ll), collapse = ""),
      "    ",
      paste0(rep("-", lr), collapse = ""),
      "\n\n"))
  }
  cat("\n")
  cat("\n-------\n\n")
  
  cat("
**Rooms** *CH1:* ground floor room in Candle House; *LB263:* Loeb 263; *LB374:* Loeb 374; 
*LBG70N/S:* Loeb lower level, room G70; *Lillie:* Lillie Auditorium; 
*Lillie 103*; *MBL Club*; *Meigs:* Meigs room, Swope Center; 
*MRC:* Marine Resources Center; 
*Speck:* Speck Auditorium, Rowe Lab; *SWC:* Swope cafeteria.
  \n")
  sink()
  #pandoc(input = paste0("../", group_name_long_nospace, ".Rmd"))
  pandoc(input = paste0("../", group_name_long_nospace, ".Rmd"), format = "latex")
}
  }

### GENERAL SCHEDULE
sink(file = paste0("../GeneralSchedule.Rmd")) # Create Rmd file
# Some headers
cat('---
fontsize: 10pt
geometry: margin=0.75in
header-includes:
  - \\usepackage{fancyhdr}
  - \\pagestyle{fancy}
  - \\usepackage{lmodern}
  - \\usepackage{xcolor}
  - \\usepackage{sectsty}
  - \\definecolor{bsdqbio}{rgb}{0.44, 0.16, 0.39}
  - \\sectionfont{\\color{bsdqbio}}
  - \\subsectionfont{\\color{bsdqbio}}
  - \\subsubsectionfont{\\color{bsdqbio}}
  - \\setlength\\heavyrulewidth{0ex}
output:
  pdf_document:
    fig_height: 2
    latex_engine: xelatex
    keep_tex: true
    pandoc_args: ["numberLines"]
---')
cat("\n# BSD qBio$^4$ @ MBL")
cat("\n\n")
cat(paste0("## General Schedule"))
cat("\n")

activities <- activities %>% rowwise() %>% mutate(ShortDesc = strsplit(Description, " \\(")[[1]][1])
ll <- max(nchar(activities$Time)) + 7
lr <- max(nchar(activities$ShortDesc)) + 2

for (my_day in sort(unique(activities$Day))){
  daily <- activities %>% filter(Day == my_day)
  name_day <- wday(daily$StartTime[1], label = TRUE, abbr = FALSE)
  name_day <- paste0(name_day, ", September ", my_day)
  #if (name_day == "Sunday, September 11"){
  #  cat(paste("\\ \n\\ \n\n"))
  #}
  cat(paste("###", name_day, "\n\n"))
  cat(paste0(
    paste0(rep("-", ll), collapse = ""),
    "    ",
    paste0(rep("-", lr), collapse = ""),
    "\n"))
  for (my_time in unique(daily$Time)){
    tmp <- daily %>% filter(Time == my_time)
    all_act_tmp <- sort(unique(tmp$ShortDesc))
    for (i in 1:length(all_act_tmp)){
      ldesc <- substr(paste0("            ", paste0(rep(" ", ll), collapse = "")), 1, ll)
      if (i == 1) ldesc <- substr(paste0("**", my_time, "**", paste0(rep(" ", ll), collapse = "")), 1, ll)
      rdesc <- substr(paste0(all_act_tmp[i], paste0(rep(" ", lr), collapse = "")), 1, lr)
      cat(paste0(ldesc, "    ", rdesc))
      namegroups <- sort(as.vector(as.data.frame(tmp %>% filter(ShortDesc == all_act_tmp[i]) %>% select(Short))[,1]))
      if (length(namegroups) == 12){
        cat("\n")
      } else {
        cat(paste0(" (*", paste0(namegroups, collapse = " "),"*)\n"))
      }
      
    }

  }
  cat(paste0(
    paste0(rep("-", ll), collapse = ""),
    "    ",
    paste0(rep("-", lr), collapse = ""),
    "\n\n"))
}
sink()
pandoc(input = paste0("../GeneralSchedule.Rmd"), format = "latex")
