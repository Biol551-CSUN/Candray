# Kevin Candray 
# april 19 2021
# WORKING WITH WORDS LECTURE 
# Week 12A

##############################################
#loading the packages
library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

##############################################
# what is string
#string and character are the same thing , String has ""
  #ie
  words<-"this is a string"
  words  
# you can add several strings in a vector
  words_vector<-c("Apples","Bananas","Oranges")
  words_vector  
###############################################
# 4 basic families in the stringr package
  # manipulation: allows to manipulate individual characters within the strings in character vectors
  # Whitespace tools: add, remove, and edit whitespace
  # Locale sesitive operations: operations vary from locale to locale
  # pattern matching: these recognize 4 engines of pattern description 
  ###############################################
  # MANIPULATION 
    #paste words together
  paste("High temp", "Low pH")
    # add a dash between the words
  paste("High temp", "Low pH", sep = "-")
    # remove the space btwn 
  paste0("High temp", "Low pH")

  #working with vectors
  shapes <- c("Square", "Circle", "Triangle")
  paste("My favorite shape is a", shapes)
  
  two_cities <- c("best", "worst")
  paste("It was the", two_cities, "of times.")

# want to know how long a string is 
  shapes #vecotr of shapes
str_length(shapes) #how many letters are in each word  

#extracting specific charatcters
seq_data<-c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) #extract the 2nd to 4th AA

# modify strings 
str_sub(seq_data, start = 3, end = 3) <- "A" # add an A in the 3rd position
seq_data

#duplicate patterns in strings 
str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string
################################################
# WHITESPACE
## removing
badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments
# note the empty whitespaces 
str_trim(badtreatments) # this removes both white spaces
# you can remove juse one side or the other
str_trim(badtreatments, side = "left") # this removes left
# str_pad adds white space
str_pad(badtreatments, 5, side = "right") # add a white space to the right side after the 5th character
#adding character instead of whitespace
str_pad(badtreatments, 5, side = "right", pad = "1") # add a 1 to the right side after the 5th character
#################################################
# Locale sensitive 
x<-"I love R!"
str_to_upper(x) #makes it uppercase
#make it lowercase
str_to_lower(x)
#make it title case
str_to_title(x)

#Pattern Matching 
data<-c("AAA", "TATA", "CTAG", "GCTT")
# find all the strings with an A
str_view(data, pattern = "A")
#detecting pattern 
str_detect(data, pattern = "A")
str_detect(data, pattern = "AT")
#locate the pattern, where excatly it is 
str_locate(data, pattern = "AT")
str_locate(data, pattern = "AT")
#############################################
# REGULAR EXPRESSIONS: REGEX
  # several types:
    # Metacharacters
    #Sequences 
    # Quantifiers
    # Character classes
    #POSIX character classes (Portable Operating System Interface)
  ## Metacharacters : includes all letters digits
vals<-c("a.b", "b.c","c.d")
# replace all periods with a space
#string, pattern, replace
str_replace(vals, "\\.", " ")
# escaping the metacharcters involves \\ most of the time then then the character trying to remove

# problem: we have multiple periods in charcter vector
vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ")
#still missing the other periods
#str_replace only replaces the first instance
#string, pattern, replace
str_replace_all(vals, "\\.", " ")
  ##SEQUENCES
####anchor sequences to know 
#string, pattern, replace
val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d")
  ##CHARACTER CLASS
  #list of characters enclosed by square brackets
  #counting number of lowercase vowles in each string 
str_count(val2, "[aeiou]")
# count any digit
str_count(val2, "[0-9]")

#EXAMPLE :
strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")
# MAKE A REGEX FINDS ALL STRINGS THAT CONTAIN A PHONENUMBER 
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
str_detect(strings, phone)

# subset only the strings with phone numbers
test<-str_subset(strings, phone)
test %>% 
str_replace_all("\\.", "-") %>%
  str_replace_all("[a-z]|\\:"," ") %>% 
  str_trim()
##########################################################
# TIDYTEXT
  #helpful for text mining 
#analyze books by Jane Austen 

#explore it 
head(austen_books())
tail(austen_books())

#cleaning it up and add column for line and chapter
original_books <- austen_books() %>% # get all of Jane Austen's books
  group_by(book) %>%
  mutate(line = row_number(), # find every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", # count the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>% #ignore lower or uppercase
  ungroup() # ungroup it so we have a dataframe again
# don't try to view the entire thing... its >73000 lines...
head(original_books)
# interested in text mining, clean until one word per row, each word is a token 
  #function to unnest the data is unnest_tokens()
tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text) # add a column named word, with the input as the text column
head(tidy_books) # there are now >725,000 rows. Don't view the entire thing!
#see an example of all the stopwords
head(get_stopwords())
cleaned_books <- tidy_books %>%
  anti_join(get_stopwords()) # dataframe without the stopwords
## Joining, by = "word"
head(cleaned_books)
cleaned_books %>%
  count(word, sort = TRUE)

# SENTIMENT ANALYSIS
sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them
sent_word_counts %>%
  filter(n > 150) %>% # take only if there are over 150 instances of it
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% # add a column where if the word is negative make the count negative
  mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")
#################################################
#MAKE A WORDCLOUD
words<-cleaned_books %>%
  count(word) %>% # count all the words
  arrange(desc(n))%>% # sort the words
  slice(1:100) #take the top 100
wordcloud2(words, shape = 'triangle', size=0.3) # make a wordcloud out of the top 100 words
