
build_win:
	go build -buildmode=c-shared -o output/win/gogit.so gitjournal.go

	dart run ffigen

# 只能在cmd中运行
build_android:
	set GOARCH=arm
	set GOOS=android
	set CGO_ENABLED=1
	set CC=%ANDROID_NDK_HOME%\toolchains\llvm\prebuilt\windows-x86_64\bin\armv7a-linux-androideabi21-clang
	go build -buildmode=c-shared -o output/android/armeabi-v7a/gogit.so gitjournal.go

	echo "Build armeabi-v7a success"

	set GOARCH=arm64
	set GOOS=android
	set CGO_ENABLED=1
	set CC=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/windows-x86_64/bin/aarch64-linux-android21-clang
	go build -buildmode=c-shared -o output/android/arm64-v8a/gogit.so gitjournal.go

	echo "Build arm64-v8a success"

	set GOARCH=x86
	set GOOS=android
	set CGO_ENABLED=1
	set CC=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/windows-x86_64/bin/i686-linux-android21-clang
	go build -buildmode=c-shared -o output/android/x86/gogit.so gitjournal.go

	echo "Build x86 success"

	set GOARCH=x86_64
	set GOOS=android
	set CGO_ENABLED=1
	set CC=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/windows-x86_64/bin/x86_64-linux-android21-clang
	go build -buildmode=c-shared -o output/android/x86_64/gogit.so gitjournal.go

	echo "Build x86_64 success"

	dart run ffigen



