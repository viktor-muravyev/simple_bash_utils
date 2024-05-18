#!/bin/bash

testfile1=test_1.txt
testfile2=test_2.txt
testfile3=test_3.txt
sep=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

echo "$sep"
echo TEST CAT N1 without flags
diff <(cat "$testfile1") <(./s21_cat "$testfile1") -s -q
diff <(cat "$testfile1" "$testfile2" "$testfile3") <(./s21_cat "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N2 -b
diff <(cat -b "$testfile1") <(./s21_cat -b "$testfile1") -s -q
diff <(cat "$testfile1" "$testfile2" "$testfile3") <(./s21_cat "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N3 -n
diff <(cat -n "$testfile1") <(./s21_cat -n "$testfile1") -s -q
diff <(cat -n "$testfile1" "$testfile2" "$testfile3") <(./s21_cat -n "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N4 -e
diff <(cat -e "$testfile1") <(./s21_cat -e "$testfile1") -s -q
diff <(cat -e "$testfile1" "$testfile2" "$testfile3") <(./s21_cat -e "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N5 -s
diff <(cat -s "$testfile1") <(./s21_cat -s "$testfile1") -s -q
diff <(cat -s "$testfile1" "$testfile2" "$testfile3") <(./s21_cat -s "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N6 -t
diff <(cat -t "$testfile1") <(./s21_cat -t "$testfile1") -s -q
diff <(cat -t "$testfile1" "$testfile2" "$testfile3") <(./s21_cat -t "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N7 -v
diff <(cat -v "$testfile1") <(./s21_cat -v "$testfile1") -s -q
diff <(cat -v "$testfile1" "$testfile2" "$testfile3") <(./s21_cat -v "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N8 --number-nonblank НЕ РАБОТАЕТ НА MAC
diff <(cat --number-nonblank "$testfile1") <(./s21_cat --number-nonblank "$testfile1") -s -q
diff <(cat --number-nonblank "$testfile1" "$testfile2" "$testfile3") <(./s21_cat --number-nonblank "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N9 --show-ends НЕ РАБОТАЕТ НА MAC
diff <(cat --show-ends "$testfile1") <(./s21_cat --show-ends "$testfile1") -s -q
diff <(cat --show-ends "$testfile1" "$testfile2" "$testfile3") <(./s21_cat --show-ends "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N10 -n -b -v
diff <(cat -n -b -v "$testfile1") <(./s21_cat -n -b -v "$testfile1") -s -q
diff <(cat -n -b -v "$testfile1" "$testfile2" "$testfile3") <(./s21_cat -n -b -v "$testfile1" "$testfile2" "$testfile3") -s -q

echo "$sep"
echo TEST CAT N11 -e -s -b
diff <(cat  -e -s -b "$testfile1") <(./s21_cat  -e -s -b "$testfile1") -s -q
diff <(cat -e -s -b "$testfile1" "$testfile2" "$testfile3") <(./s21_cat -e -s -b "$testfile1" "$testfile2" "$testfile3") -s -q
