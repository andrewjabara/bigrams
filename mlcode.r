textlines = readLines("documents/words.txt")
text = scan("documents/words.txt",quote=NULL,what="x")

counts = as.data.frame(xtabs(~text))

install.packages("tm")
library(tm)
library(NLP)
# whole text in one string again
oz.str = paste(text, collapse = " ")

# lowercase everything and to remove punctuation.
# turn a single text, given as a string, into a tm object:
oz.corpus = Corpus(VectorSource(oz.str))
oz.corpus = tm_map(oz.corpus, tolower)
oz.corpus = tm_map(oz.corpus, removePunctuation, preserve_intra_word_dashes = FALSE)

# Now change this tm object back into a long string, lowercased and minus the punctuation
cleaned.oz.str = as.character(oz.corpus)[1]

# split into words
oz.words = strsplit(cleaned.oz.str, " ", fixed = T)[[1]]

#Bigram
# the NLP function "ngrams" returns a list of pairs of words.
oz.bigrams = vapply(ngrams(oz.words, 2), paste, "", collapse = " ")
oz.bigram.counts = as.data.frame(xtabs(~oz.bigrams))
head(oz.bigram.counts[order(oz.bigram.counts$Freq, decreasing = T),])

#Trigram
oz.tri = vapply(ngrams(oz.words, 3), paste, "", collapse = " ")
oz.tri.counts = as.data.frame(xtabs(~oz.tri))
head(oz.tri.counts[order(oz.tri.counts$Freq, decreasing = T),])
