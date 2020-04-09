# RFC

Meta package to import implementations of RFC specifications.

PR to add new packages!

You can import various RFC implementations using this package.

For example by depending on `rfc:4648` you will pull in all packages used for implementing RFC 4648. At this point you can also just `import rfc4648;` to automatically get the specific imports from the packages.

---

Supported specifications (in ascending order):

| RFC  | title                                               | package                         | license   | impl | pkg |`safe`|`nogc`|`nothrow`|betterC| Updated | Checked |
| ----:| --------------------------------------------------- | ------------------------------- | --------- | ----:|:---:|:----:|:----:|:-------:|:-----:| -------:| -------:|
|  822 | Standard for ARPA Internet Text Messages            | rfc:5322 (obsoleted)            | n/a       |  n/a |     |      |      |         |       | n/a     | 2020-04 |
| 1867 | Form-based File Upload in HTML                      | https://vibe-d.dub.pm           | MIT       |  40% | :o: | :o:  |      |         |       | 2020-01 | 2020-04 |
| 1950 | ZLIB Compressed Data Format Specification v. 3.3    | etc.c.zlib                      | Zlib      | 100% | :o: |      | :o:  |   :o:   |  :o:  | n/a     | 2020-04 |
|      |                                                     | std.zlib (wrapper)              | BSL-1.0   |    ? | :o: |      |      |         |       | n/a     | 2020-04 |
| 1951 | DEFLATE Compressed Data Format Specification v. 1.3 | etc.c.zlib                      | Zlib      | 100% | :o: |      | :o:  |   :o:   |  :o:  | n/a     | 2020-04 |
|      |                                                     | std.zlib (wrapper)              | BSL-1.0   |    ? | :o: |      |      |         |       | n/a     | 2020-04 |
| 1952 | GZIP file format specification v. 4.3               | etc.c.zlib                      | Zlib      | 100% | :o: |      | :o:  |   :o:   |  :o:  | n/a     | 2020-04 |
|      |                                                     | std.zlib (wrapper)              | BSL-1.0   |    ? | :o: |      |      |         |       | n/a     | 2020-04 |
| 2069 | An Extension to HTTP : Digest Access Authentication | https://vibe-d.dub.pm           | MIT       |  80% | :o: | :o:  |      |         |       | 2020-01 | 2020-04 |
| 2373 | IP Version 6 Addressing Architecture                | std.socket                      | BSL-1.0   |  n/a | :o: | :o:  |      |         |       | n/a     | 2020-04 |
| 2518 | HTTP Extensions for Distributed Authoring -- WEBDAV | https://vibe-d.dub.pm           | MIT       |   2% |     | :o:  |      |         |       | 2020-01 | 2020-04 |
| 2822 | Standard for ARPA Internet Text Messages            | rfc:5322 (obsoleted)            | n/a       |  n/a |     |      |      |         |       | n/a     | 2020-04 |
| 3253 | Versioning Extensions to WebDAV                     | https://vibe-d.dub.pm           | MIT       |   2% |     | :o:  |      |         |       | 2020-01 | 2020-04 |
| 3629 | UTF-8, a transformation format of ISO 10646         | std.utf                         | BSL-1.0   |  98% | :o: | :o:  | :o:  |   :o:   |       | n/a     | 2020-04 |
|      |                                                     | std.encoding (BOM)              | BSL-1.0   |   2% | :o: |      |      |         |       | n/a     | 2020-04 |
| 3648 | WebDAV Ordered Collections Protocol                 | https://vibe-d.dub.pm           | MIT       |   2% |     | :o:  |      |         |       | 2020-01 | 2020-04 |
| 3744 | WebDAV Access Control Protocol                      | https://vibe-d.dub.pm           | MIT       |   2% |     | :o:  |      |         |       | 2020-01 | 2020-04 |
| 3986 | Uniform Resource Identifier (URI): Generic Syntax   | std.uri (pct-encode/decode)     | BSL-1.0   |   5% | :o: | :o:  |      |         |       | n/a     | 2020-04 |
| 4122 | A Universally Unique IDentifier (UUID) URN Namespace | std.uuid                       | BSL-1.0   | 100% | :o: | :o:  | :o:  |   :o:   |       | n/a     | 2020-04 |
| 4506 | XDR: External Data Representation Standard          | https://xdr.dub.pm              | AGPL-3.0  |   5% | :o: | :o:  | :o:  |   :o:   |       | 2015-08 | 2020-04 |
| 4648 | The Base16, Base32, and Base64 Data Encodings       | https://base32.dub.pm           | BSL-1.0   |  33% | :o: | :o:  |      |         |       | 2015-05 | 2020-04 |
|      |                                                     | std.base64                      | BSL-1.0   |  33% | :o: | :o:  |      |         |       | n/a     | 2020-04 |
| 5321 | Simple Mail Transfer Protocol                       | std.net.isemail (validation)    | BSL-1.0   |  10% | :o: | :o:  |      |         |       | n/a     | 2020-04 |
| 5322 | Standard for ARPA Internet Text Messages            | std.datetime.systime (date-time) | BSL-1.0  |   3% | :o: | :o:  |      |         |       | n/a     | 2020-04 |
|      |                                                     | std.net.isemail (addr-spec)     | BSL-1.0   |   3% | :o: | :o:  |      |         |       | n/a     | 2020-04 |
|      |                                                     | https://vibe-d.dub.pm (headers) | BSL-1.0   |  10% | :o: | :o:  |      |         |       | n/a     | 2020-04 |
| 5424 | The Syslog Protocol                                 | https://vibe-core.dub.pm        | MIT       |  80% | :o: | :o:  |      |         |       | 2020-01 | 2020-04 |
| 6265 | HTTP State Management Mechanism                     | https://vibe-d.dub.pm           | MIT       | 100% | :o: | :o:  |      |         |       | 2020-01 | 2020-04 |
| 6455 | The WebSocket Protocol                              | https://vibe-d.dub.pm           | MIT       | 100% | :o: | :o:  |      |         |       | 2020-01 | 2020-04 |
| 6901 | JavaScript Object Notation (JSON) Pointer           | https://json-pointer.dub.pm     | BSL-1.0   | 100% | :o: |      |      |         |       | 2018-06 | 2020-04 |
| 6902 | JavaScript Object Notation (JSON) Patch             | https://json-patch.dub.pm       | BSL-1.0   | 100% | :o: |      |      |         |       | 2018-06 | 2020-04 |
| 7232 | Hypertext Transfer Protocol (HTTP/1.1): Conditional Requests | https://vibe-d.dub.pm  | MIT       | 100% | :o: | :o:  |      |         |       | 2020-01 | 2020-04 |
| 7519 | JSON Web Token (JWT)                                | https://hunt-jwt.dub.pm         | MIT       |  40% | :o: |      |      |         |       | 2019-10 | 2020-04 |
|      |                                                     | https://jwt.dub.pm              | MIT       |  40% |     |      |      |         |       | 2017-02 | 2020-04 |
|      |                                                     | https://itsdangerous.dub.pm     | BSL-1.0   |  40% |     |      |      |         |       | 2020-01 | 2020-04 |
| 7797 | JSON Web Signature (JWS) Unencoded Payload Option   | https://itsdangerous.dub.pm     | BSL-1.0   |  80% | :o: |      |      |         |       | 2020-01 | 2020-04 |

The `RFC` and `title` columns refer to the RFC being implemented.

`package` points to where it is implemented and `license` shows under which license it is published.

`impl` shows a rough percentage how much of the RFC is implemented by this package. `100%` would mean it covers all examples inside the specification correctly.

`pkg` indicates that there is a subpackage available in this repository for importing it.

`safe`, `nogc`, `nothrow`, `betterC` indicate using a :o: if that package fulfills the respective features.

`@safe`, `@nogc` and `nothrow` are tested automatically inside their submodules, `betterC` is only checked if explicitly advertised.

`Updated` is when the package code was last updated (possibly not a new version though), `Checked` is when this readme or the subpackage is changed for this package.

---

There is no warranty the information on this page is correct, please check the links to be sure yourself.

The source code of the dub package files is public domain, the import files may adhere to separate licenses as governed by the dependencies.