module wtf.parameter;

import std.variant;
import std.string : cmp;

struct Parameter {
    string identifier;
    Variant value;

    this(string identifier, Variant value = null)
    {
        this.identifier = identifier;
        this.value = value;
    }

    //size_t toHash() const @safe pure nothrow
    //{
    //    size_t hash;
    //    foreach (char c; identifier) {
    //        hash = (hash * 9) + c;
    //    }

    //    return hash;
    //}

    //bool opEquals(ref const Parameter s) const @safe pure nothrow
    //{
    //    return cmp(this.identifier, s.identifier) == 0;
    //}
}
