import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'dart:io';

import 'generated_bindings.dart';

class GoGitBindings {
  late final NativeLibrary lib;

  GoGitBindings(DynamicLibrary library) {
    lib = NativeLibrary(library);
  }

  void clone(
    String url,
    String directory,
    Uint8List pemBytes,
    String password,
  ) {
    var cPemBytes = malloc.allocate<ffi.Uint8>(pemBytes.length);
    for (var i = 0; i < pemBytes.length; i++) {
      cPemBytes[i] = pemBytes[i];
    }

    var cloneUrl = url.toNativeUtf8();
    var cloneDir = directory.toNativeUtf8();
    var pemPassphrase = password.toNativeUtf8();

    var retValue = lib.GitClone(
      cloneUrl.cast<Char>(),
      cloneDir.cast<Char>(),
      cPemBytes.cast<Char>(),
      pemBytes.length,
      pemPassphrase.cast<Char>(),
    );
    if (retValue != nullptr) {
      var err = retValue.cast<Utf8>().toDartString();
      lib.free(retValue.cast());

      throw Exception("GitClone failed with error: $err");
    }

    malloc.free(cPemBytes);
    malloc.free(cloneUrl);
    malloc.free(cloneDir);
    malloc.free(pemPassphrase);
  }

  void fetch(
    String remote,
    String directory,
    Uint8List pemBytes,
    String password,
  ) {
    var cPemBytes = malloc.allocate<ffi.Uint8>(pemBytes.length);
    for (var i = 0; i < pemBytes.length; i++) {
      cPemBytes[i] = pemBytes[i];
    }

    var remoteName = remote.toNativeUtf8();
    var cloneDir = directory.toNativeUtf8();
    var pemPassphrase = password.toNativeUtf8();

    var retValue = lib.GitFetch(
      remoteName.cast<Char>(),
      cloneDir.cast<Char>(),
      cPemBytes.cast<Char>(),
      pemBytes.length,
      pemPassphrase.cast<Char>(),
    );
    if (retValue != nullptr) {
      var err = retValue.cast<Utf8>().toDartString();
      lib.free(retValue.cast());

      throw Exception("GitFetch failed with error code: $err");
    }

    malloc.free(cPemBytes);
    malloc.free(remoteName);
    malloc.free(cloneDir);
    malloc.free(pemPassphrase);
  }

  void push(
    String remote,
    String directory,
    Uint8List pemBytes,
    String password,
  ) {
    var cPemBytes = malloc.allocate<ffi.Uint8>(pemBytes.length);
    for (var i = 0; i < pemBytes.length; i++) {
      cPemBytes[i] = pemBytes[i];
    }

    var remoteName = remote.toNativeUtf8();
    var cloneDir = directory.toNativeUtf8();
    var pemPassphrase = password.toNativeUtf8();

    var retValue = lib.GitPush(
      remoteName.cast<Char>(),
      cloneDir.cast<Char>(),
      cPemBytes.cast<Char>(),
      pemBytes.length,
      pemPassphrase.cast<Char>(),
    );
    if (retValue != nullptr) {
      var err = retValue.cast<Utf8>().toDartString();
      lib.free(retValue.cast());

      throw Exception("GitPush failed with error code: $err");
    }

    malloc.free(cPemBytes);
    malloc.free(remoteName);
    malloc.free(cloneDir);
    malloc.free(pemPassphrase);
  }

  String defaultBranch(
    String remote,
    String directory,
    Uint8List pemBytes,
    String password,
  ) {
    var cPemBytes = malloc.allocate<ffi.Uint8>(pemBytes.length);
    for (var i = 0; i < pemBytes.length; i++) {
      cPemBytes[i] = pemBytes[i];
    }

    var remoteName = remote.toNativeUtf8();
    var cloneDir = directory.toNativeUtf8();
    var pemPassphrase = password.toNativeUtf8();

    var retValue = lib.GitDefaultBranch(
      remoteName.cast<Char>(),
      cloneDir.cast<Char>(),
      cPemBytes.cast<Char>(),
      pemBytes.length,
      pemPassphrase.cast<Char>(),
    );
    // if (retValue != 0) {
    // throw Exception("GitDefaultBranch failed with error code: $retValue");
    // }

    malloc.free(cPemBytes);
    malloc.free(remoteName);
    malloc.free(cloneDir);
    malloc.free(pemPassphrase);

    var branch = retValue.cast<Utf8>().toDartString();
    lib.free(retValue.cast());
    return branch;
  }
}