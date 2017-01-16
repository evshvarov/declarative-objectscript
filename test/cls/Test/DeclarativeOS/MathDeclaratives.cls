/// Set of DeclarativeOS math examples.
Class Test.DeclarativeOS.MathDeclaratives Extends DeclarativeOS.RegistryHelper
{

/// <p>Returns hex value of the passed value.</p>
/// 
/// @Declarative("math:toHex")
ClassMethod toHex(value As %Numeric)
{
    return $zhex(value)
}

/// <p>Returns $$$YES if passed value is prime number.</p>
/// <p>Otherwise, returns $$$NO.</p>
/// 
/// @Declarative("math:isPrime")
ClassMethod isPrime(value As %Numeric)
{
    for i=2:1:$zsqr(value) {
        if (value # i = 0) {
            return $$$NO
        }
    }

    return $$$YES
}

/// <p>Returns $$$YES if passed value is odd number.</p>
/// <p>Otherwise, returns $$$NO.</p>
/// 
/// @Declarative("math:isOdd")
ClassMethod isOdd(value As %Numeric)
{
    return value # 2 '= 0
}

/// <p>Returns $$$YES if passed value is even number.</p>
/// <p>Otherwise, returns $$$NO.</p>
/// 
/// @Declarative("math:isEven")
ClassMethod isEven(value As %Numeric)
{
    return value # 2 = 0
}

/// <p>Returns $$$YES if passed value is palindromic number.</p>
/// <p>Otherwise, returns $$$NO.</p>
/// 
/// @Declarative("math:isPalindromic")
ClassMethod isPalindromic(value As %Numeric)
{
    return $reverse(value) = value
}

}
