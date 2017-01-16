/// Joiner is a kind of text utils class.
/// The main point of the class is join elemenet of collection using separator.
Class DeclarativeOS.Joiner
{

/// 
/// <p>Returns concatination of items in the given collection by using the given separator.</p>
/// 
/// <p><b>USAGE EXAMPLE</b></p>
/// <p><b>How to convert the given collection to a string which enumerates all items:</b></p>
/// 
/// <EXAMPLE>
/// USER> set words = ##class(%ListOfDataTypes).%New()
/// USER> do words.Insert("DeclarativeOS")
/// USER> do words.Insert("is")
/// USER> do words.Insert("awesome!")
/// USER>
/// USER> write $zjoin(words, " ")
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// DeclarativeOS is awesome!
/// </EXAMPLE>
ClassMethod join(collection As %Collection.AbstractList, separator As %String = "") As %String
{
    if (collection = "") {
      return ""
    }

    set string = ""

    set index = ""

    for {
        set index = collection.Next(index)

        quit:index=""

        set item = collection.GetAt(index)

        set string = string _ $case(string, "":"", :separator) _ item
    }

    return string
}

}
