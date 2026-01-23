# Building Notepad Next

To build Notepad Next you will need a compatible C++ compiler, the Qt libraries, and the Notepad Next source code.

# Windows

This section specifically describes how to build Notepad Next using Microsoft's Visual Studio 2019 compiler. 

## Installing Visual Studio 2022

1. Download the installer for [Visual Studio 2022 Community](https://visualstudio.microsoft.com/) (other versions should work if you have those installed already).
1. Run the installer
1. Select the 'Desktop development with C++'
1. Complete the installation

## Installing Qt Libraries

1. Download the [Qt installer](https://www.qt.io/download-qt-installer)
1. Run the installer.
1. Select 'custom installation'
1. Install any version of Qt >= 6.2 (5.15 may also work):
  * `MSVC 2019 64-bit` located under the desired version of Qt
  * `Qt 5 Compatibility Module` (not needed for Qt 5.x)
  * `Developer and Design Tools` > `Qt Creator CDB Debugger Support`
  * `Developer and Design Tools` > `Debugging Tools for Windows`

## Cloning the Notepad Next Repository

1. In a command prompt (or git shell, powershell, etc) run:
1. `git clone --recurse-submodules https://github.com/dail8859/NotepadNext.git`

## Building/Running Notepad Next

1. Open `src/NotepadNext.pro` with Qt Creator
1. Configure the project for 'Desktop Qt 6.2.4 MSVC2019 64bit'
1. Press `Ctrl+R`
1. Qt Creator will build and run the project.

# Linux

Using a fresh Ubuntu 21.10 setup, the following script will install the needed dependencies and build the executable:

```
sudo apt install qtbase5-dev qt5-qmake qtbase5-dev-tools qttools5-dev-tools qtbase5-private-dev libqt5x11extras5-dev build-essential git
git clone --recurse-submodules https://github.com/dail8859/NotepadNext.git
cd NotepadNext
mkdir build
cd build
qmake ../src/NotepadNext.pro
make -j$(nproc)
```

# Docker

If you do not have a local Qt development environment, you can build the project using Docker.

1.  Build the Docker image:
    ```bash
    docker build -t notepadnext-build .
    ```

2.  Run the build inside the container:
    ```bash
    docker run --rm -v $(pwd):/app notepadnext-build sh -c "mkdir -p build && cd build && qmake6 ../src/NotepadNext.pro && make -j$(nproc)"
    ```

    > **Note:** We use `qmake6` explicitly to ensure the correct Qt 6 version is used.

# GitHub CI Builds

You can use the release scripts in `.github/workflows` to trigger builds and generate artifacts directly on GitHub.

## 1. Test Builds (Pull Requests / Push)
To generate test builds for Windows, Linux, and macOS:
1.  **Push** commits to the `master` branch OR
2.  **Open a Pull Request** against `master`.

The [Build Notepad Next](/.github/workflows/build.yml) workflow will automatically run. Once completed, you can download the artifacts (installers, AppImages, etc.) from the **Agile Actions** > **Build Notepad Next** run page.

## 2. Release Builds
To perform a full release (version update + tag + draft release):
1.  Go to the **Actions** tab in the GitHub repository.
2.  Select the **Create Release** workflow from the sidebar.
3.  Click **Run workflow**.
4.  Enter the new version number (e.g., `0.9` - do *not* include the 'v').
5.  Click **Run workflow**.

This will:
-   Update the version in `src/Version.pri`.
-   Commit and Tag the release (e.g., `v0.9`).
-   Trigger the main build workflow.
-   Create a **Draft Release** with the compiled artifacts attached.
