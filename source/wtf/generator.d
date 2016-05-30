module wtf.generator;

import std.stdio;
import std.array : split;
import std.variant;

import wtf.argument;
import wtf.parameter;
import wtf.command;

class Generator {
    protected TypeInfo[const string] _types;

    this() {
        this._types = [
            "bool": typeid(bool),
            "int": typeid(int),
            "uint": typeid(uint),
            "long": typeid(long),
            "ulong": typeid(ulong),
            "string": typeid(string),
        ];
    }

    void register(const string name, TypeInfo type)
    {
        this._types[name] = type;
    }

    const Command from(const string definition, const void delegate(const Variant[const string] parameters, const string raw) handler)
    {
        writeln("definition: '", definition, "'");

        string identifier;
        Argument[] arguments;
        string[] matches = split(definition, ' ');
        foreach (int i, string part; matches) {
            // We need only set the identifier from the first one.
            if (i == 0) {
                identifier = part;

                continue;
            }

            // 2nd+ are argument definitions.
            if (part == "") {
                continue;
            }

            immutable bool optional = (part[0] == '[');
            if (optional) {
                if (part[part.length - 1] != ']') {
                    throw new Exception("error 1!");
                }

                part = part[1..part.length - 1];
            }

            string[] parts = split(part, ':');

            if (parts.length != 2) {
                throw new Exception("error 2!");
            }

            if (parts[1] !in this._types) {
                throw new Exception("error 3!");
            }

            arguments ~= Argument(parts[0], this._types[parts[1]], optional);
        }

        writeln(arguments);

        if (identifier == null) {
            throw new Exception("error 3!");
        }

        return Command(identifier, arguments, handler);
    }
}
