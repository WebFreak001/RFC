module rfc1867;

public import vibe.inet.webform;

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

		auto content_type = "multipart/form-data; boundary=\"AaB03x\"";

		auto input = createMemoryStream(cast(ubyte[])(
				"--AaB03x\r\n" ~
				"Content-Disposition: form-data; name=submitname\r\n" ~
				"\r\n" ~
				"Larry\r\n" ~
				"--AaB03x\r\n" ~
				"Content-Disposition: form-data; name=files; filename=file1.txt\r\n" ~
				"Content-Type: text/plain\r\n" ~
				"Content-Length: 29\r\n" ~
				"\r\n" ~
				"... contents of file1.txt ...\r\n" ~
				"--AaB03x--\r\n").dup, false);

		FormFields fields;
		FilePartFormFields files;

		parseMultiPartForm(fields, files, content_type, input, 4096);

		assert(fields["submitname"] == "Larry");
		assert(files["files"].filename == "file1.txt");
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
