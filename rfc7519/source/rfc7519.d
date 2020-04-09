module rfc7519;

public import jwt;

version (unittest)
{
	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()()
	{
		import std.datetime : Clock;
		import std.exception : assertThrown;

		string secret = "super_secret";
		long now = Clock.currTime.toUnixTime();
		Token token = new Token(JWTAlgorithm.HS512);
		token.claims.nbf = now + (60 * 60);
		string encodedToken = token.encode(secret);
		assertThrown!NotBeforeException(verify(encodedToken, secret, [
					JWTAlgorithm.HS512
				]));
		token = new Token(JWTAlgorithm.HS512);
		token.claims.iat = now - 3600;
		token.claims.exp = now - 60;
		encodedToken = token.encode(secret);
		assertThrown!ExpiredException(verify(encodedToken, secret, [
					JWTAlgorithm.HS512
				]));
		token = new Token(JWTAlgorithm.NONE);
		encodedToken = token.encode(secret);
		assertThrown!VerifyException(verify(encodedToken, secret, [
					JWTAlgorithm.HS512
				]));
		token = new Token(JWTAlgorithm.HS512);
		encodedToken = token.encode(secret) ~ "we_are";
		assertThrown!InvalidSignatureException(verify(encodedToken, secret, [
					JWTAlgorithm.HS512
				]));
		token = new Token(JWTAlgorithm.HS512);
		encodedToken = token.encode(secret);
		assertThrown!InvalidAlgorithmException(verify(encodedToken, secret,
				[JWTAlgorithm.HS256, JWTAlgorithm.HS384]));
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
