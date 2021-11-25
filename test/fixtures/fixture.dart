import 'dart:convert';
import 'dart:io';

String fixture(String name, Encoding encoding) =>
    File('test/fixtures/$name').readAsStringSync(encoding: encoding);