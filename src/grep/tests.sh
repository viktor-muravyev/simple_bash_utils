#!/bin/bash

testfile1=test_1.txt
testfile2=test_2.txt

sep=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

echo "$sep"
echo TEST GREP N1 without flags
diff <(grep case "$testfile1") <(./s21_grep case "$testfile1") -s -q
diff <(grep case "$testfile1" "$testfile2") <(./s21_grep case "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N2 -e case -e file
diff <(grep -e case -e file "$testfile1") <(./s21_grep -e case -e file "$testfile1") -s -q
diff <(grep -e case -e file "$testfile1" "$testfile2") <(./s21_grep -e case -e file "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N3 -e case -f test_patterns.txt
diff <(grep -e case -f test_patterns.txt "$testfile1") <(./s21_grep -e case -f test_patterns.txt "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N4 -e case -f test_patterns.txt -v
diff <(grep -e case -f test_patterns.txt -v "$testfile1") <(./s21_grep -e case -f test_patterns.txt -v "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -v "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -v "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N5 -e case -f test_patterns.txt -c
diff <(grep -e case -f test_patterns.txt -c "$testfile1") <(./s21_grep -e case -f test_patterns.txt -c "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -c "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -c "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N6 -e case -f test_patterns.txt -cv
diff <(grep -e case -f test_patterns.txt -cv "$testfile1") <(./s21_grep -e case -f test_patterns.txt -cv "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -cv "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -cv "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N7 -e case -f test_patterns.txt -l
diff <(grep -e case -f test_patterns.txt -l "$testfile1") <(./s21_grep -e case -f test_patterns.txt -l "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -l "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -l "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N8 -e case -f test_patterns.txt -n
diff <(grep -e case -f test_patterns.txt -n "$testfile1") <(./s21_grep -e case -f test_patterns.txt -n "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -n "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -n "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N9 -e case -f test_patterns.txt -i
diff <(grep -e case -f test_patterns.txt -i "$testfile1") <(./s21_grep -e case -f test_patterns.txt -i "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -i "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -i "$testfile1" "$testfile2") -s -q


echo "$sep"
echo TEST GREP N10 -e case -f test_patterns.txt -h
diff <(grep -e case -f test_patterns.txt -h "$testfile1") <(./s21_grep -e case -f test_patterns.txt -h "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -h "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -h "$testfile1" "$testfile2") -s -q


echo "$sep"
echo TEST GREP N11 -e case -f test_patterns.txt -n -h
diff <(grep -e case -f test_patterns.txt -n -h "$testfile1") <(./s21_grep -e case -f test_patterns.txt -n -h "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -n -h "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -n -h "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N12 -e case -f test_patterns.txt -s nofile.txt
diff <(grep -e case -f test_patterns.txt -s nofile.txt "$testfile1") <(./s21_grep -e case -f test_patterns.txt -s nofile.txt "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -s nofile.txt "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -s nofile.txt "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N13 -e case -f test_patterns.txt -o
diff <(grep -e case -f test_patterns.txt -o "$testfile1") <(./s21_grep -e case -f test_patterns.txt -o "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -o "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -o "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N14 -e case -f test_patterns.txt -oi
diff <(grep -e case -f test_patterns.txt -oi "$testfile1") <(./s21_grep -e case -f test_patterns.txt -oi "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -oi "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -oi "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N13 -e case -f test_patterns.txt -iv
diff <(grep -e case -f test_patterns.txt -iv "$testfile1") <(./s21_grep -e case -f test_patterns.txt -iv "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -iv "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -iv "$testfile1" "$testfile2") -s -q

echo "$sep"
echo TEST GREP N13 -e case -f test_patterns.txt -in
diff <(grep -e case -f test_patterns.txt -in "$testfile1") <(./s21_grep -e case -f test_patterns.txt -in "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -in "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -in "$testfile1" "$testfile2") -s -q


echo "$sep"
echo TEST GREP N14 -e case -f test_patterns.txt -chilnosv
diff <(grep -e case -f test_patterns.txt -chilnosv "$testfile1") <(./s21_grep -e case -f test_patterns.txt -chilnosv "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -chilnosv "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -chilnosv "$testfile1" "$testfile2") -s -q


echo "$sep"
echo TEST GREP N15 -e case -f test_patterns.txt -hinsv nofile.txt
diff <(grep -e case -f test_patterns.txt -hinsv nofile.txt "$testfile1") <(./s21_grep -e case -f test_patterns.txt -hinsv nofile.txt "$testfile1") -s -q
diff <(grep -e case -f test_patterns.txt -hinsv nofile.txt "$testfile1" "$testfile2") <(./s21_grep -e case -f test_patterns.txt -hinsv nofile.txt "$testfile1" "$testfile2") -s -q
