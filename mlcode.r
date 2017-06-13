# thank you to http://www.katrinerk.com/ for the basis of this code

textlines = readLines("documents/words.txt")
text = scan("documents/words.txt",quote=NULL,what="x")

counts = as.data.frame(xtabs(~text))

install.packages("tm")
library(tm)
library(NLP)
# whole text in one string again
new.str = paste(text, collapse = " ")

# lowercase everything and to remove punctuation.
# turn a single text, given as a string, into a tm object:
new.corpus = Corpus(VectorSource(oz.str))
new.corpus = tm_map(new.corpus, tolower)
new.corpus = tm_map(new.corpus, removePunctuation, preserve_intra_word_dashes = FALSE)

# Now change this tm object back into a long string, lowercased and minus the punctuation
cleaned.new.str = as.character(new.corpus)[1]

# split into words
new.words = strsplit(cleaned.new.str, " ", fixed = T)[[1]]

#Bigram Code
# the NLP function "ngrams" returns a list of pairs of words.
new.bigrams = vapply(ngrams(new.words, 2), paste, "", collapse = " ")
new.bigram.counts = as.data.frame(xtabs(~new.bigrams))
head(new.bigram.counts[order(new.bigram.counts$Freq, decreasing = T),])

#Trigram Code
#ngrams(new.words, 3) 
new.tri = vapply(ngrams(new.words, 3), paste, "", collapse = " ")
new.tri.counts = as.data.frame(xtabs(~new.tri))
head(new.tri.counts[order(new.tri.counts$Freq, decreasing = T),])
