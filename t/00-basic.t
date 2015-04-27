use v6;
use Test;
use File::Find::Duplicates;

plan 7;

is( find_duplicates( dirs => ['t/test-files'] )».IO,
    (["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"],
     ["t/test-files/empty1", "t/test-files/empty2"]),
    "Basic functionality");

is( find_duplicates( dirs => ['t/test-files'], recursive => True )».IO,
    (["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"],
     ["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"],
     ["t/test-files/empty1", "t/test-files/empty2"]),
    "Recursive search");

is( find_duplicates( dirs => ['t/test-files'], ignore_empty => True )».IO,
    (["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"],),
    "Ignoring empty files");

is( find_duplicates( dirs => ['t/test-files'], recursive => True, method=> 'compare')».IO,
    (["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"],
     ["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"],
     ["t/test-files/empty1", "t/test-files/empty2"]),
    "Byte comparisons");

is( find_duplicates( dirs => ['t/test-files/foo1', 't/test-files/foo2'],
                     ignore_empty => True )».IO,
    (["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"],),
    "Multiple directory search");

is( 't/test-files'.IO.duplicates».IO,
    (["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"],
     ["t/test-files/empty1", "t/test-files/empty2"]),
    "IO::Path Method");

is( 't/test-files'.IO.duplicates(recursive => True, ignore_empty=>True)».IO,
    (["t/test-files/foobar-2.txt", "t/test-files/foobar.txt"],
     ["t/test-files/foo1/ab.txt", "t/test-files/foo2/ab.txt"]),
    "Method with recursion");



