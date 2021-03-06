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
        processdata("dummy.txt")
    y = 0
    for n in range(1, 10^8):
        ret = n
        ret = n + 2
        ret = n + 1
        y += ret
    with duration():
        processdata("wordpairs.txt")

