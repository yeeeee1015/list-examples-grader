CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then
echo 'Found Thing!'
else 
echo 'Need ListExamples.java'
exit 1
fi

cp ../TestListExamples.java .
echo 'Moved TestListExamples.java'
cp -r ../lib .
echo 'Copied junit libs'

javac -cp $CPATH *.java > ../compileOutput.txt
echo 'Done compiling'

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > ../output.txt
echo 'Code has run'

if [[ $(grep -h "OK" ../output.txt) != "" ]]
then
    echo 'There are no errors! Congrats!'
elif [[ $(grep -h "testMergeRightEnd" ../output.txt) != "" ]]
then
    echo 'You are failing the test "testMergeRightEnd"'
fi