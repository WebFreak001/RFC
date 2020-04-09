module rfc5424;

public import vibe.core.log;

version (unittest)
{
	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()()
	{
		import std.conv : hexString;

		enum BOM = hexString!"EFBBBF";

		import vibe.core.file;

		auto fstream = createTempFile();
		auto logger = new SyslogLogger!FileStream(fstream,
				SyslogLogger!FileStream.Facility.local1, "appname", null);
		LogLine msg;
		import std.datetime;
		import core.thread;

		static if (is(typeof(SysTime.init.fracSecs)))
			auto fs = 1.dur!"usecs";
		else
			auto fs = FracSec.from!"usecs"(1);
		msg.time = SysTime(DateTime(0, 1, 1, 0, 0, 0), fs);

		foreach (lvl; [
				LogLevel.debug_, LogLevel.diagnostic, LogLevel.info, LogLevel.warn,
				LogLevel.error, LogLevel.critical, LogLevel.fatal
			])
		{
			msg.level = lvl;
			logger.beginLine(msg);
			logger.put("αβγ");
			logger.endLine();
		}
		fstream.close();

		import std.file;
		import std.string;

		auto lines = splitLines(readFileUTF8(fstream.path()), KeepTerminator.yes);
		assert(lines.length == 7);
		assert(
				lines[0] == "<143>1 0000-01-01T00:00:00.000001 - " ~ BOM
				~ "appname - - - " ~ BOM ~ "αβγ\n");
		assert(
				lines[1] == "<142>1 0000-01-01T00:00:00.000001 - " ~ BOM
				~ "appname - - - " ~ BOM ~ "αβγ\n");
		assert(
				lines[2] == "<141>1 0000-01-01T00:00:00.000001 - " ~ BOM
				~ "appname - - - " ~ BOM ~ "αβγ\n");
		assert(
				lines[3] == "<140>1 0000-01-01T00:00:00.000001 - " ~ BOM
				~ "appname - - - " ~ BOM ~ "αβγ\n");
		assert(
				lines[4] == "<139>1 0000-01-01T00:00:00.000001 - " ~ BOM
				~ "appname - - - " ~ BOM ~ "αβγ\n");
		assert(
				lines[5] == "<138>1 0000-01-01T00:00:00.000001 - " ~ BOM
				~ "appname - - - " ~ BOM ~ "αβγ\n");
		assert(
				lines[6] == "<137>1 0000-01-01T00:00:00.000001 - " ~ BOM
				~ "appname - - - " ~ BOM ~ "αβγ\n");
		removeFile(fstream.path());
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
