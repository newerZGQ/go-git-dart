
build_win:
	go build -buildmode=c-shared -o output/win/gogit.so gitjournal.go

build_android:
	set GOARCH=arm
	set GOOS=android
	set CGO_ENABLED=1
	set CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/armv7a-linux-androideabi21-clang
	go build -buildmode=c-shared -o output/android/armeabi-v7a/gogit.so gitjournal.go

	echo "Build armeabi-v7a success"

	set GOARCH=arm64
	set GOOS=android
	set CGO_ENABLED=1
	set CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android21-clang
	go build -buildmode=c-shared -o output/android/arm64-v8a/gogit.so gitjournal.go

	echo "Build arm64-v8a success"


build_ffi:
	dart run ffigen


