/// The heart of DeclarativeOS!
/// Extend the class to register declaratives.
Class DeclarativeOS.RegistryHelper [ DependsOn = DeclarativeOS.Utils ]
{

/// Code generator for registration declaratives in special global: ^DeclarativeOS
ClassMethod register() [ CodeMode = objectgenerator ]
{
    if (%compiledclass.Name = "DeclarativeOS.RegistryHelper") {
        kill ^DeclarativeOS
    }
    set methods = %compiledclass.Methods

    set i = ""

    for {
        set i = methods.Next(i)

        quit:i=""

        set method = methods.GetAt(i)

        set methodName = method.Name

        set methodDescription = method.Description

        continue:methodName="register"

        continue:$extract(methodName)="%"

        set declarativeNameRegex = ##class(DeclarativeOS.Utils).#DECLARATIVENAMEREGEX

        set annotationRegexp = "@Declarative\(""(" _ declarativeNameRegex _ ")""\)"

        set annotationMatcher = ##class(%Regex.Matcher).%New(annotationRegexp, methodDescription)

        if (annotationMatcher.Locate()) {
            set annotationValue = $replace(annotationMatcher.Group(1), " ", "")

            do ##class(DeclarativeOS.RegistryManager).saveDeclarative(annotationValue, %compiledclass.Name, methodName)
        }
    }

    d %code.WriteLine("    q")

    q $$$OK
}

}
