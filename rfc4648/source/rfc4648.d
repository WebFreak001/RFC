module rfc4648;

public import base32;
public import std.base64;

version (unittest)
{
	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()()
	{
		ubyte[6] data = [0xde, 0xad, 0xbe, 0xef, 0x01, 0x23];
		assert(Base32.encode(data[]) == "32W353YBEM======");

		assert(Base32.decode("32W353YBEM======") == [
				0xde, 0xad, 0xbe, 0xef, 0x01, 0x23
				]);
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
