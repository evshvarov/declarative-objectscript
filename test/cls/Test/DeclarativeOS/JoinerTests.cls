Class Test.DeclarativeOS.JoinerTests Extends %UnitTest.TestCase
{

Method TestJoin()
{
    set words = ##class(%ListOfDataTypes).%New()
    do words.Insert("DeclarativeOS")
    do words.Insert("is")
    do words.Insert("awesome!")

    do $$$AssertEquals("DeclarativeOS is awesome!", $zjoin(words, " "), "$zjoin works!")
}

}
