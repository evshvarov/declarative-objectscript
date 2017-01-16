/// Binds collection with function and provides implementation of all DeclarativeOS commands and functions.
Class DeclarativeOS.Binder Extends %RegisteredObject
{

/// The collection for processing in DeclarativeOS commands and functions.
Property collection As %Collection.AbstractList [ Private ];

/// The function for processing in DeclarativeOS commands and functions.
Property function As %String [ Private ];

/// Overrides "constructor" for the class.
Method %OnNew(collection As %Collection.AbstractList, function As %String) As %Status [ Private, ServerOnly = 1 ]
{
    if ('##class(DeclarativeOS.Utils).isValidName(function)) {
        set exception = ##class(%Exception.General).%New("Declarative name is invalid", "1",,"Declarative name pattern must be ""namespace:function"".")

        throw exception
    }

    set ..collection = collection

    set ..function = ##class(DeclarativeOS.Utils).normalizeName(function)

    return $$$OK
}

/// Returns the collection of the binder.
Method GetCollection()
{
    return ..collection
}

/// Returns the function of the binder.
Method GetFunction()
{
    return ..function
}

/// 
/// <p>Implements <b>zforeach</b> command.</p>
/// 
/// <p>Applies the given function to each item in the given collection.</p>
/// 
/// <p><b>USAGE EXAMPLE</b></p>
/// <p><b>How to print all items in collection:</b></p>
/// 
/// <EXAMPLE>
/// USER> set words = ##class(%ListOfDataTypes).%New()
/// USER> do words.Insert("Hello ")
/// USER> do words.Insert("World!")
/// USER>
/// USER> zforeach $zbind(words, "io:print")
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// Hello World!
/// </EXAMPLE>
/// 
/// See also:
/// <CLASS>DeclarativeOS.IO</CLASS>
Method ForEach()
{
    quit:..collection=""

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        do $classmethod(className, methodName, item)
    }
}

/// 
/// <p>Implements <b>$zmap</b> function.</p>
/// 
/// <p>Returns new collection where each item in the given collection is mapped by the given function.</p>
/// 
/// <p><b>USAGE EXAMPLE</b></p>
/// <p><b>How to convert every number in given collection to hex representation:</b></p>
/// 
/// <EXAMPLE>
/// USER> set numbers = ##class(%ListOfDataTypes).%New()
/// USER> do numbers.Insert(10) ; 10 is 'A' in hex
/// USER> do numbers.Insert(11) ; 11 is 'B' in hex
/// USER> do numbers.Insert(12) ; 12 is 'C' in hex
/// USER>
/// USER> set hexNumbers = $zmap(numbers, "examples:toHex")
/// USER>
/// USER> for i=1:1:hexNumbers.Count() { write hexNumbers.GetAt(i), " " }
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// A B C
/// </EXAMPLE>
/// 
/// See also:
/// <CLASS>DeclarativeOS.Examples</CLASS>
Method Map()
{
    set collection = $classmethod(..collection.%ClassName(), "%New")    

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        set mappedItem = $classmethod(className, methodName, item)

        do collection.Insert(mappedItem)
    }

    return collection
}

/// 
/// <p>Implements <b>$zfind</b> function.</p>
/// 
/// <p>Returns the first found element from the given collection by the given criteria (function).</p>
/// <p>Otherwise, returns null string.</p>
/// 
/// <p><b>USAGE EXAMPLE</b></p>
/// <p><b>How to find prime number:</b></p>
/// 
/// <EXAMPLE>
/// USER> set numbers = ##class(%ListOfDataTypes).%New()
/// USER> do numbers.Insert(4)
/// USER> do numbers.Insert(5)
/// USER> do numbers.Insert(6)
/// USER>
/// USER> set primeNumber = $zfind(numbers, "examples:isPrime")
/// USER>
/// USER> write "Prime number: " _ primeNumber
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// Prime number: 5
/// </EXAMPLE>
/// 
/// See also:
/// <CLASS>DeclarativeOS.Examples</CLASS>
Method Find()
{
    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        if ($classmethod(className, methodName, item)) {
            return item
        }
    }

    return ""
}

/// 
/// <p>Implements <b>$zfilter</b> function.</p>
/// 
/// <p>Returns new collection which contains filtered elements by the given criteria (function) of the specified collection.</p>
/// 
/// <p><b>USAGE EXAMPLE</b></p>
/// <p><b>How to find even and odd numbers:</b></p>
/// 
/// <EXAMPLE>
/// USER> set numbers = ##class(%ListOfDataTypes).%New()
/// USER> do numbers.Insert(2)
/// USER> do numbers.Insert(3)
/// USER> do numbers.Insert(4)
/// USER> do numbers.Insert(5)
/// </EXAMPLE>
/// 
/// <b>How to find even numbers:</b>
/// 
/// <EXAMPLE>
/// USER> set evenNumbers = $zfilter(numbers, "examples:isEven")
/// USER>
/// USER> for i=1:1:evenNumbers.Count() { write evenNumbers.GetAt(i), " " }
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// 2 4
/// </EXAMPLE>
/// 
/// <b>How to find odd numbers:</b>
/// 
/// <EXAMPLE>
/// USER> set oddNumbers = $zfilter(numbers, "examples:isOdd")
/// USER>
/// USER> for i=1:1:oddNumbers.Count() { write oddNumbers.GetAt(i), " " }
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// 3 5
/// </EXAMPLE>
/// 
/// See also:
/// <CLASS>DeclarativeOS.Examples</CLASS>
Method Filter()
{
    set collection = $classmethod(..collection.%ClassName(), "%New")

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        if ($classmethod(className, methodName, item)) {
            do collection.Insert(item)
        }
    }

    return collection
}

/// 
/// <p>Implements <b>$zexists</b> function.</p>
/// 
/// <p>Returns $$$YES if collection contains element which is satisfied by the given criteria (function).</p>
/// <p>Otherwise, returns $$$NO.</p>
/// 
/// <p><b>USAGE EXAMPLE</b></p>
/// <p><b>How to check whether collection contains a palindromic numbers:</b></p>
/// 
/// <EXAMPLE>
/// USER> set numbers = ##class(%ListOfDataTypes).%New()
/// USER> do numbers.Insert(13)
/// USER> do numbers.Insert(12)
/// USER> do numbers.Insert(11)
/// USER> do numbers.Insert(10)
/// USER>
/// USER> set hasPalindromicNumbers = $zexists(numbers, "examples:isPalindromic")
/// USER>
/// USER> write "Collection has palindromic numbers? " _ $case(hasPalindromicNumbers, 1:"YES", 0:"NO")
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// Collection has palindromic numbers? YES
/// </EXAMPLE>
/// 
/// See also:
/// <CLASS>DeclarativeOS.Examples</CLASS>
Method Exists()
{
    return ..Find() '= ""
}

/// 
/// <p>Implements of <b>$zcount</b> function.</p>
/// 
/// <p>Returns count of items in the given collection which satisfies the given criteria (function).</p>
/// 
/// <p><b>USAGE EXAMPLE</b></p>
/// <p><b>How to count prime numbers in given collection:</b></p>
/// 
/// <EXAMPLE>
/// USER> set numbers = ##class(%ListOfDataTypes).%New()
/// USER> do numbers.Insert(2)
/// USER> do numbers.Insert(3)
/// USER> do numbers.Insert(4)
/// USER> do numbers.Insert(5)
/// USER>
/// USER> set primeNumbersCount = $zcount(numbers, "examples:isPrime")
/// USER>
/// USER> write "Count of prime numbers: " _ primeNumbersCount
/// </EXAMPLE>
/// 
/// <EXAMPLE>
/// Count of prime numbers: 3
/// </EXAMPLE>
/// 
/// See also:
/// <CLASS>DeclarativeOS.Examples</CLASS>
Method Count()
{
    set count = 0

    set index = ""

    for {
        set index = ..collection.Next(index)

        quit:index=""

        set item = ..collection.GetAt(index)

        set $lb(className, methodName) = ..loadDeclarative(..function)

        if ($classmethod(className, methodName, item)) {
            set count = count + 1
        }
    }

    return count
}

/// Delegates call to <CLASS>DeclarativeOS.RegistryManager</CLASS>.
ClassMethod loadDeclarative(function As %String) [ Private ]
{
    return ##class(DeclarativeOS.RegistryManager).loadDeclarative(function)
}

}
