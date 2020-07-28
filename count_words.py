import urllib.request
from html.parser import HTMLParser
import re
import collections

# Parser for HTML
class MyHTMLParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.html_data = ""

    def handle_data(self, data):
        self.html_data += data
    
parser = MyHTMLParser()

# First, get text from webpage
page = urllib.request.urlopen('http://localhost:8080')
output = page.read()

# Next, parse it into text
parser.feed(output.decode('ascii'))

# Regex to identify words
# Capitalise everything to account for words at the start of sentences - probably unnecessary
# but just to be thorough
words = [x.upper() for x in re.findall(r'\w+', parser.html_data)]

word_count = collections.Counter(words)

# Print most common word
print(word_count.most_common(1))

