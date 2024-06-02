import pandas as pd
import json

classics = pd.read_csv("classics.csv").to_dict()

# if classics is not None:
#     for prop in classics:
#         print(prop)


bookdict = []
for i in range(1000):
    book = {}
    # book["subjects"] = classics["bibliography.subjects"][i]
    book["title"] = classics["bibliography.title"][i]
    book["author_birth"] = classics["bibliography.author.birth"][i]
    book["author_death"] = classics["bibliography.author.death"][i]
    book["author_name"] = classics["bibliography.author.name"][i]
    book["pub_date"] = classics["bibliography.publication.full"][i]
    book["pub_year"] = classics["bibliography.publication.year"][i]
    book["num_chars"] = classics["metrics.statistics.characters"][i]
    book["num_words"] = classics["metrics.statistics.words"][i]

    bookdict.append(book)

print(json.dumps(bookdict, indent=2))

with open("classics.json", "w") as outfile:
    json.dump(bookdict, outfile, indent=4)




#
# bibliography.congress classifications
# bibliography.languages
# bibliography.subjects
# bibliography.title
# bibliography.type
# metadata.downloads
# metadata.id
# metadata.rank
# metadata.url
# bibliography.author.birth
# bibliography.author.death
# bibliography.author.name
# bibliography.publication.day
# bibliography.publication.full
# bibliography.publication.month
# bibliography.publication.month name
# bibliography.publication.year
# metadata.formats.total
# metadata.formats.types
# metrics.difficulty.automated readability index
# metrics.difficulty.coleman liau index
# metrics.difficulty.dale chall readability score
# metrics.difficulty.difficult words
# metrics.difficulty.flesch kincaid grade
# metrics.difficulty.flesch reading ease
# metrics.difficulty.gunning fog
# metrics.difficulty.linsear write formula
# metrics.difficulty.smog index
# metrics.sentiments.polarity
# metrics.sentiments.subjectivity
# metrics.statistics.average letter per word
# metrics.statistics.average sentence length
# metrics.statistics.average sentence per word
# metrics.statistics.characters
# metrics.statistics.polysyllables
# metrics.statistics.sentences
# metrics.statistics.syllables
# metrics.statistics.words
