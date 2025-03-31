# SDL3_ttf support

This is a minimal Odin wrapper around [SDL3_ttf](https://github.com/libsdl-org/SDL_ttf/tree/main).

You need to download the [SDL_ttf release package](https://github.com/libsdl-org/SDL_ttf/releases) and put the `SDL3_ttf.dll` into the `out` folder.

Then there is the [SDL3_ttf-devel-3.x.x-VC.zip development](https://github.com/libsdl-org/SDL_ttf/releases/download/release-3.2.0/SDL3_ttf-devel-3.2.0-VC.zip) package. It contains the necessary `SDL3_ttf.dll`, `SDL3_ttf.pdb` and `SDL3_ttf.lib` files in the `lib/x64` folder, which you need to copy into this current folder before you can compile the program.
