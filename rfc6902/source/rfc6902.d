module rfc6902;

public import vision.json.patch.commons;
public import vision.json.patch.diff;
public import vision.json.patch.patch;

version (unittest)
{
	import std.json;

	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()(JSONValue j)
	{
		diff(j, j).toJson();
	}

	unittest
	{
		string s = `{ "language": "D", "rating": 3.5, "code": "42", "o": {"p1": 5, "p2": 6}, "a": [1,2,3,4,5] }`;
		JSONValue j = parseJSON(s);

		testFunctionality(j);
		safelog("package works");

		static assert(__traits(compiles, testFunctionality(JSONValue.init)), "package doesn't work");
	}

	@safe unittest
	{
		static if (__traits(compiles, testFunctionality(JSONValue.init)))
		{
			pragma(msg, "package is @safe");
		}
		else
		{
			pragma(msg, "package is not @safe");
		}
	}

	@nogc unittest
	{
		static if (__traits(compiles, testFunctionality(JSONValue.init)))
		{
			pragma(msg, "package is @nogc");
		}
		else
		{
			pragma(msg, "package is not @nogc");
		}
	}

	nothrow unittest
	{
		static if (__traits(compiles, testFunctionality(JSONValue.init)))
		{
			pragma(msg, "package is nothrow");
		}
		else
		{
			pragma(msg, "package is not nothrow");
		}
	}
}
