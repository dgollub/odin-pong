# Pong written in Odin

This is a simple implementation of the game [Pong](https://en.wikipedia.org/wiki/Pong) in the [Odin](https://odin-lang.org/) programming language.

# Build and Run

You need to download a [SDL3 release package](https://github.com/libsdl-org/SDL/releases) and put the `SDL3.dll` into the `out` folder.

Then you can run this to start the game:

```console
odin run src/ -out:out/pong.exe -strict-style -vet -debug
```


# License

[MIT](./LICENSE.md)
