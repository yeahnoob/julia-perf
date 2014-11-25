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

def processdata(filename="word-pairs.txt"):
    file = open(filename, 'r')
    lines = map(str.strip, file)
    word_pairs = map(lambda s: s.split(','), lines)
    result = groupby(first, word_pairs)

for i in range(0, int(argv[1])):
    with duration():
        processdata("word-pairs.txt")

