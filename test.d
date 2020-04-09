#!/usr/bin/env rdmd

import std;

int main(string[] args)
{
	bool success = true;
	string[] failed;
	writeln("running tests");
	foreach (d; dirEntries(".", SpanMode.shallow))
	{
		auto name = d.baseName;
		if (d.isDir && name.startsWith("rfc"))
		{
			if (!testSubpackage(name))
			{
				success = false;
				failed ~= name;
			}
		}
	}

	if (!success)
		writefln("Failed packages: %(%s %)", failed);

	return success ? 0 : 1;
}

bool testSubpackage(string path)
{
	assert(path.startsWith("rfc"));
	writeln("Testing package ", path);
	auto cmd = ["dub", "test", "-q", ":" ~ path[3 .. $]];
	writefln("$ %(%s %)", cmd);
	bool success = spawnProcess(cmd).wait == 0;
	if (success)
		writeln(path, ": success!");
	else
		writeln(path, ": FAILED TEST");
	writeln();
	writeln();
	return success;
}
