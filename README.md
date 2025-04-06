# Pong written in Odin

This is a simple implementation of the game [Pong](https://en.wikipedia.org/wiki/Pong) in the [Odin](https://odin-lang.org/) programming language.

# Build and Run

## Prerequisites

You need to download a [SDL3 release package](https://github.com/libsdl-org/SDL/releases) and put the `SDL3.dll` into the `out` folder.

You also need to download the [SDL_ttf release package](https://github.com/libsdl-org/SDL_ttf/releases) and put the `SDL3_ttf.dll` into the `out` folder.

Then there is the [SDL3_ttf-devel-3.x.x-VC.zip development](https://github.com/libsdl-org/SDL_ttf/releases/download/release-3.2.0/SDL3_ttf-devel-3.2.0-VC.zip) package. It contains the necessary `SDL3_ttf.dll`, `SDL3_ttf.pdb` and `SDL3_ttf.lib` files in the `lib/x64` folder, which you need to copy to the [vendor/sdl3_ttf](./vendor/sdl3_ttf/) folder before compiling.

### Font

You have to copy the [font file](./resources/fonts/Mx437_DOS-V_re_ANK16.ttf) into the `out` folder `out/font.tff`.

Then you can run this to start the game:

```console
odin run src/ -out:out/pong.exe -strict-style -vet -debug
```


# License

[MIT](./LICENSE.md)
