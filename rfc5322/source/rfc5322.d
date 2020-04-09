module rfc5322;

public import std.datetime.systime;
public import std.net.isemail;
public import vibe.inet.message;

version (unittest)
{
	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()()
	{
		import vibe.stream.memory;

		ubyte[] hdr = cast(ubyte[]) "A: a \r\nB: \r\nC:\r\n\tc\r\n\r\n".dup;
		InetHeaderMap map;
		parseRFC5322Header(createMemoryStream(hdr), map);
		assert(map.length == 3);
		assert(map["A"] == "a");
		assert(map["B"] == "");
		assert(map["C"] == " c");
	}

	unittest
	{
		testFunctionality();
		safelog("package works");
	}

	@safe unittest
	{
		static if (__traits(compiles, testFunctionality()))
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
		static if (__traits(compiles, testFunctionality()))
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
		static if (__traits(compiles, testFunctionality()))
		{
			pragma(msg, "package is nothrow");
		}
		else
		{
			pragma(msg, "package is not nothrow");
		}
	}
}
