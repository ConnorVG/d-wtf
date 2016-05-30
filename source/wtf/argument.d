module wtf.argument;

struct Argument {
    const string identifier;
    const TypeInfo type;
    const bool optional;

    this(const string identifier, const TypeInfo type, const bool optional = false)
    {
        this.identifier = identifier;
        this.type = type;
        this.optional = optional;
    }
}
