/// Manager for declaratives.
/// The class contains methods for saving and loading declaratives from ^DeclarativeOS global.
Class DeclarativeOS.RegistryManager
{

/// Stores declarative to the ^DeclarativeOS global.
ClassMethod saveDeclarative(declarativeName As %String, className As %String, classMethod As %String)
{
    set ^DeclarativeOS(declarativeName) = $lb(className, classMethod)
}

/// Loads declarative from the ^DeclarativeOS global.
ClassMethod loadDeclarative(declarativeName As %String)
{
    return $get(^DeclarativeOS(declarativeName))
}

}
