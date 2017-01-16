/// Some utils for DeclarativeOS implementation.
Class DeclarativeOS.Utils
{

/// <p>Declarative name regular expression.</p>
/// <p>The pattern is "namespace:function"</p>
Parameter DECLARATIVENAMEREGEX [ Internal ] = "[a-zA-Z0-9]+(.[a-zA-Z0-9]+)*\s*:\s*[a-zA-Z0-9]+([a-zA-Z0-9_-]+)*";

/// <p>Returns $$$YES if specified name is satisfied by the DECLARATIVENAMEREGEX regex.</p>
/// <p>Otherwise, returns $$$NO.</p>
ClassMethod isValidName(name As %String) As %Boolean
{
    return ##class(%Regex.Matcher).%New("^" _ ..#DECLARATIVENAMEREGEX _ "$", name).Locate()
}

/// <p>Returns declarative name without any space characters.</p>
ClassMethod normalizeName(name As %String) As %String
{
    if (..isValidName(name)) {
        return $replace(name, " ", "")
    }

    return ""
}

}
