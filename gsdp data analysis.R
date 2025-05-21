library(tidyverse)
library(janitor)

dir()
 
dir(path="GDP Data")

"GDP Data/NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
read.csv() -> ap_df 

"NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
str_split("-") %>% 
unlist()-> state_name_vector

state_name_vector[2]->st_name

ap_df %>%
slice(-c(7,11,27:33)) %>% 
pivot_longer(-c(1,2),names_to = "year",values_to = "gsdp") %>% 
clean_names() %>% 
select(-1) %>% 
mutate(state = st_name) %>% 
view()



# from "GDP Data" folder, exclude GSDP.csv and only take NDA files
dir(path = "GDP Data",
    pattern = "NDA")->state_files
for(i in state_files){
  print(paste0("file name:",i))
  i %>% 
    str_split("_") %>% 
    unlist()->state_name_vector
  state_name_vector[2] -> st_name
  
  print(paste0("state name:",st_name))
  
  
  paste0("GDP Data/",i) %>% 
    read.csv()->st_df1
  
  st_df1 %>% 
    slice(-c(7,11,27:33)) %>% 
    pivot_longer(-c(1,2),names_to = "year",values_to = "gdsp") %>% 
    clean_names() %>% 
    select(-1) %>% 
    mutate(state=st_name)->state_df
  print(state_df)
  
}
  

