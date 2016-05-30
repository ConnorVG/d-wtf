module wtf.command;

import std.variant;

import wtf.argument;
import wtf.parameter;

struct Command {
    string identifier;
    Argument[] arguments;
    void delegate(const Variant[const string] parameters, const string raw) handler;

    this(string identifier, Argument[] arguments, void delegate(const Variant[const string] parameters, const string raw) handler)
    {
        this.identifier = identifier;
        this.arguments = arguments;
        this.handler = handler;
    }
}
