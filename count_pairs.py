from toolz import groupby, first
from sys import argv
from contextlib import contextmanager
from time import time
from sys import stdout
 
@contextmanager
def duration(outfile=stdout):
    start = time()
    yield
    end = time()
    outfile.write(str(end - start) + '\n')

with duration():
    filename = "word-pairs.txt"
    file = open(filename)
    lines = map(str.strip, file)
    word_pairs = map(lambda s: s.split(','), lines)
    result = groupby(first, word_pairs)
