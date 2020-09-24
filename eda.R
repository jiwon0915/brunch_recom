library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)

magazines<-fread("magazines_edit.csv",encoding="UTF-8")
magazines<-magazines[,-1] #필요없는 1열 삭제

metadata<-fread("metadata_edit3.csv",encoding="UTF-8")
metadata<-metadata[,-1] #필요없는 1열 삭제

users<-fread("users_edit.csv",encoding="UTF-8")
users<-users[,-1] #필요없는 1열 삭제

read<-fread("read_edit.csv",encoding="UTF-8")
read<-read[,-c(1,2)]#필요없는 1,2열 삭제

author<-fread("author.csv",encoding = "UTF-8")
author<-author %>% as.data.frame()
author<-author[-1,]
author
###############################3
# read data를 wide->long data로 전처리(article_id 정리)
read2<-read %>% separate_rows(article_id,sep=" ")
rm(read)

# 제일 많이 읽힌 기사 top20 eda
rea<-read2 %>% 
  group_by(article_id) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% 
  head(20)

# 브런치 시스템 운영자인 brunch의 기사가 제일 많이 읽히는 경향이 있음

rea %>% ggplot(aes(x=reorder(article_id,n),y=n))+
  geom_col(aes(fill=article_id), legend.position = "none")+
  coord_flip()+
  theme(text = element_text(size=10),
        legend.position = "none")

############################
# users data를 wide->long data로 전처리(following list 정리)
users2<-users %>% separate_rows(following_list,sep=" ") 
rm(users)

#특수문자([]) 제거
library(tm)
users2$following_list<-users2$following_list %>% removePunctuation() 

#특수문자(@) 추가
users2$following_list<-paste0("@",users2$following_list)

#write.csv(users2,file="users2.csv",fileEncoding = "UTF-8")

#############################
# 독자가 평균적으로 몇 개의 글을 읽는지 파악, eda
read_n<-read2[!duplicated(read2[,c("user_id","article_id")]),]
user_n<-read_n %>% group_by(user_id) %>% 
  summarise(n=n())
summary(user_n$n)

user_n<-user_n %>% mutate(stats=ifelse(n==median(user_n$n),"med",
                                       ifelse(n==round(mean(user_n$n)),"mean","others")))

user_n %>% ggplot(aes(x=n))+geom_bar(aes(fill=stats))+
  lims(x=c(0,80))

# 평균적으로 41개의 글, 중간값은 8, 그러나 이상치도 존재함

###########################
# 독자가 평균적으로 몇 명의 작가를 구독하는지 파악, eda
subs_n<-users2 %>% group_by(user_id) %>% summarise(n=n()) 
summary(subs_n$n)

subs_n<-subs_n %>% mutate(stats=ifelse(n==median(subs_n$n),"med",
                                       ifelse(n==round(mean(subs_n$n)),"mean","others")))

subs_n %>% ggplot(aes(x=n))+geom_bar(aes(fill=stats))+
  lims(x=c(0,50))


