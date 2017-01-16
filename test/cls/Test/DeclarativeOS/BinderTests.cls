Class Test.DeclarativeOS.BinderTests Extends (%UnitTest.TestCase, Test.DeclarativeOS.MathDeclaratives)
{

Method TestMap()
{
    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(10) ; 10 is 'A' in hex
    do numbers.Insert(11) ; 11 is 'B' in hex
    do numbers.Insert(12) ; 12 is 'C' in hex

    set hexNumbers = $zmap(numbers, "math:toHex")

    do $$$AssertEquals("A,B,C", $zjoin(hexNumbers, ","), "$zmap works!")
}

Method TestFind()
{
    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(4)
    do numbers.Insert(5)
    do numbers.Insert(6)

    do $$$AssertEquals(5, $zfind(numbers, "math:isPrime"), "$zfind works!")
}

Method TestFilter()
{
    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(2)
    do numbers.Insert(3)
    do numbers.Insert(4)
    do numbers.Insert(5)

    set evenNumbers = $zfilter(numbers, "math:isEven")

    set oddNumbers = $zfilter(numbers, "math:isOdd")

    do $$$AssertEquals("2,4", $zjoin(evenNumbers, ","), "$zfilter works (even)!")

    do $$$AssertEquals("3,5", $zjoin(oddNumbers, ","), "$zfilter works (odd)!")
}

Method TestExists()
{
    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(13)
    do numbers.Insert(12)
    do numbers.Insert(11)
    do numbers.Insert(10)

    do $$$AssertEquals($$$YES, $zexists(numbers, "math:isPalindromic"), "$zexists works!")
}

Method TestCount()
{
    set numbers = ##class(%ListOfDataTypes).%New()
    do numbers.Insert(2)
    do numbers.Insert(3)
    do numbers.Insert(4)
    do numbers.Insert(5)

    do $$$AssertEquals(3, $zcount(numbers, "math:isPrime"), "$zcount works!")
}

}
