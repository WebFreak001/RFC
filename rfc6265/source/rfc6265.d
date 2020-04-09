module rfc6265;

public import vibe.http.common;

version (unittest)
{
	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()()
	{
		auto c = new Cookie;
		c.value = "foo";
		assert(c.value == "foo");
		assert(c.rawValue == "foo");

		c.value = "foo$";
		assert(c.value == "foo$");
		assert(c.rawValue == "foo%24", c.rawValue);

		c.value = "foo&bar=baz?";
		assert(c.value == "foo&bar=baz?");
		assert(c.rawValue == "foo%26bar%3Dbaz%3F", c.rawValue);
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
