module rfc7797;

public import itsdangerous;

version (unittest)
{
	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()()
	{
		import std.stdio;

		// Signer
		string secretkey = "hello";

		auto signer = new Signer!(SHA1, SHA1)(secretkey);
		string signature = signer.sign("this is a test");
		assert(signature == "this is a test.hgGT0Zoara4L13FX3_xm-xmfa_0");

		assert(signer.verifySignature("this is a test", "hgGT0Zoara4L13FX3_xm-xmfa_0") == true);
		assert(signer.unsign("this is a test.hgGT0Zoara4L13FX3_xm-xmfa_0") == "this is a test");

		// TimedJSONWebSignatureSerializer
		int expiresIn = 3600;

		JSONValue obj;
		obj["a"] = 13;
		obj["b"] = "test me";

		// below configuration is the default of Python version: s = TimedJSONWebSignatureSerializer(secretkey, expiresIn)
		// output token can be tested on https://jwt.io/

		auto tjwss = new TimedJSONWebSignatureSerializer!(SHA512, Signer!(SHA1, SHA512))(secretkey);

		auto ttoken = tjwss.dumps(obj);
		ttoken.writeln;

		try
		{
			tjwss.loadsWithHeader("eyJhbGciOiJIUzUxMiIsImV4cCI6MTU3ODQzNzg0MiwiaWF0IjoxNTc4NDM0MjQyfQ.eyJhIjoxMywiYiI6InRlc3QgbWUifQ.TMHBXKna35Ah5vtxNmkXUOx96xgW7iZntsHqHKOH5dTZdgt3zdjZjR5urDzdHVOlaD5Hj_CSlH_xFf1cZRF4eA")
				.writeln;
		}
		catch (SignatureExpired exp)
		{
			writeln("signature expired!: " ~ exp.msg ~ " | For paylodad: " ~ exp.payload);
		}
		catch (BadSignature exp)
		{
			writeln("Bad signature!: " ~ exp.msg);
		}

		// URLSafeSerializer
		JSONValue obj2;
		obj2["id"] = 5;
		obj2["name"] = "itsdangerous";

		auto uss = new URLSafeSerializer("secret key", "auth");
		string s = uss.dumps(obj2);
		assert(s == "eyJpZCI6NSwibmFtZSI6Iml0c2Rhbmdlcm91cyJ9.6YP6T0BaO67XP--9UzTrmurXSmg");

		JSONValue oobj = uss.loads(s);
		oobj.writeln;

		// URLSafeTimedSerializer
		auto usts = new URLSafeTimedSerializer(secretkey);
		string st = usts.dumps(obj);
		st.writeln;
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
