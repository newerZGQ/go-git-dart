import subprocess
import shutil
import os

def copy_files_from_folders(source_folder, destination_folder, file_name):
    # 遍历源文件夹中的文件夹
    for root, dirs, files in os.walk(source_folder):
        for dir in dirs:
            folder_path = os.path.join(root, dir)
            # 检查目标文件是否存在于当前文件夹
            file_path = os.path.join(folder_path, file_name)
            if os.path.exists(file_path):
                # 构建目标文件夹中的对应目录结构
                relative_path = os.path.relpath(folder_path, source_folder)
                destination_path = os.path.join(destination_folder, relative_path)
                os.makedirs(destination_path, exist_ok=True)
                # 复制文件到目标文件夹中的对应目录
                shutil.copy(file_path, destination_path)
                print(f"Copied {file_name} from {folder_path} to {destination_path}")

# .so 文件所在的路径
cxx_folder = f"./output/android"  # 这个路径可能需要根据你的工程结构做出调整
# flutter项目目录
flutter_folder = "../git_write"
# flutter libgit2 插件目录
flutter_plugin_folder = flutter_folder + "/gogit2dart"
copy_files_from_folders(cxx_folder, flutter_plugin_folder + "/android/src/main/jniLibs", "gogit.so")
# 将libgit2头文件复制到flutter项目文件夹
shutil.copyfile("./generated_bindings.dart", flutter_plugin_folder + "/lib/generated_bindings.dart")
shutil.copyfile("./gogit_bindings.dart", flutter_plugin_folder + "/lib/gogit_bindings.dart")
