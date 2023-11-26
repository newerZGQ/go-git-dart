import 'dart:io';
import 'dart:ffi';

import 'gogit_bindings.dart';

DynamicLibrary _getCorrectLibrary() {
  return DynamicLibrary.open('libgit2.so');
}

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Please provide a command: clone, fetch, push, defaultBranch');
    return;
  }

  final command = arguments[0];
  final bindings = GoGitBindings(_getCorrectLibrary());

  switch (command) {
    case 'clone':
      if (arguments.length != 5) {
        print('Usage: clone <url> <directory> <pemFile> <pemPassword>');
        return;
      }
      final pemBytes = File(arguments[3]).readAsBytesSync();
      bindings.clone(arguments[1], arguments[2], pemBytes, arguments[4]);
      break;
    case 'fetch':
    case 'push':
    case 'defaultBranch':
      if (arguments.length != 4) {
        print('Usage: $command <remote> <pemFile> <pemPassword>');
        return;
      }
      final directory = Directory.current.path;
      print(directory);
      final pemBytes = File(arguments[2]).readAsBytesSync();

      switch (command) {
        case 'fetch':
          bindings.fetch(arguments[1], directory, pemBytes, arguments[3]);
          break;
        case 'push':
          bindings.push(arguments[1], directory, pemBytes, arguments[3]);
          break;
        case 'defaultBranch':
          var branch = bindings.defaultBranch(
              arguments[1], directory, pemBytes, arguments[3]);
          print("DefaultBranch: $branch");
          break;
      }
      break;
    default:
      print('Unknown command: $command');
      break;
  }
}
