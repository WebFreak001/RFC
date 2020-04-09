module rfc6455;

public import vibe.http.websockets;

version (unittest)
{
	void safelog(string msg) @trusted @nogc nothrow
	{
		import core.stdc.stdio : printf;

		printf("%.*s\n", msg.length, &msg[0]);
	}

	void testFunctionality()()
	{
		void handleConn(scope WebSocket sock)
		{
			// simple echo server
			while (sock.connected)
			{
				auto msg = sock.receiveText();
				sock.send(msg);
			}
		}

		void startServer()
		{
			import vibe.http.router;

			auto router = new URLRouter;
			router.get("/ws", handleWebSockets(&handleConn));

			// Start HTTP server using listenHTTP()...
		}

		startServer();
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
