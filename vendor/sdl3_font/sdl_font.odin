package sdl3_font

import "core:c"
import SDL "vendor:sdl3"

when ODIN_OS == .Windows {
	foreign import lib "SDL3_ttf.lib"
} else {
	foreign import lib "system:SDL3_ttf"
}

MAJOR_VERSION :: 3
MINOR_VERSION :: 2
PATCHLEVEL    :: 0

// #include <SDL3_ttf/SDL_ttf.h>

Font :: struct {}

// typedef Uint32 TTF_FontStyleFlags;
StyleFlags :: distinct bit_set[StyleFlag; c.int]
StyleFlag :: enum c.int {
    NORMAL        = 0x00, /**< No special style */
    BOLD          = 0x01, /**< Bold style */
    ITALIC        = 0x02, /**< Italic style */
    UNDERLINE     = 0x04, /**< Underlined text */
    STRIKETHROUGH = 0x08, /**< Strikethrough text */
}

@(default_calling_convention="c", link_prefix="TTF_", require_results)
foreign lib {
    Init :: proc() -> c.bool ---
    Quit :: proc() ---
	WasInit :: proc() -> c.int ---

    OpenFont  :: proc(file: cstring, ptsize: c.float) -> ^Font ---
    CloseFont :: proc(font: ^Font) -> c.float ---

    SetFontSize :: proc(font: ^Font, ptsize: c.float) -> bool ---
    GetFontSize :: proc (font: ^Font) -> c.float ---

    RenderText_Solid            :: proc(font: ^Font, text: cstring, length: c.int, fg: SDL.Color) -> ^SDL.Surface ---
	RenderText_Solid_Wrapped    :: proc(font: ^Font, text: cstring, length: c.int, fg: SDL.Color, wrapLength: u32) -> ^SDL.Surface ---
}
