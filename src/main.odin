package pong

import "core:log"
// import "core:math"
import "core:os"
import "core:strings"
import SDL "vendor:sdl3"
import TTF "../vendor/sdl3_ttf"

WINDOW_TITLE  :: "Pong"
WINDOW_X      := i32(400)
WINDOW_Y      := i32(400)
WINDOW_WIDTH  := i32(800)
WINDOW_HEIGHT := i32(600)
WINDOW_FLAGS  :: SDL.WindowFlags{.RESIZABLE}


CTX :: struct {
	window:        ^SDL.Window,
	surface:       ^SDL.Surface,
	renderer:      ^SDL.Renderer,
	font: 		   ^TTF.Font,
	// textures:      [dynamic]Texture_Asset, 

	should_close:  bool,
	app_start:     f64,

	frame_start:   f64,
	frame_end:     f64,
	frame_elapsed: f64,
}

ctx := CTX{}

init_sdl :: proc() -> (ok: bool) {
	// TODO(dkg): When in release mode use a file logger, not console!

    log.info("Initializing SDL.")

	if sdl_res := SDL.Init(SDL.INIT_VIDEO); !sdl_res {
		log.errorf("SDL.init failed. %s", SDL.GetError())
		return false
	}

    ctx.window = SDL.CreateWindow(WINDOW_TITLE, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_FLAGS)
	if ctx.window == nil {
		log.errorf("SDL.CreateWindow failed. %s", SDL.GetError())
		return false
	}

    ctx.renderer = SDL.CreateRenderer(ctx.window, nil)
	if ctx.renderer == nil {
		log.errorf("SDL.CreateRenderer failed. %s", SDL.GetError())
		return false
	}

	if !TTF.Init() {
		log.errorf("TTF.Init failed. %s", SDL.GetError())
		return false
	}

	fontFileName := "font.ttf"
	if !os.exists(fontFileName) {
		fontFileName = "resources/fonts/Mx437_DOS-V_re_ANK16.ttf" // "Ac437_IBM_VGA_8x16.ttf" // "Mx437_DOS-V_re_ANK16.ttf"
	}

	log.infof("Loading font: %s", fontFileName)

	ctx.font = TTF.OpenFont(strings.clone_to_cstring(fontFileName), 1.0)
	if ctx.font == nil {
		log.errorf("TTF.OpenFont failed. %s", SDL.GetError())
		return false
	}
	if !TTF.SetFontSize(ctx.font, 22.0) {
		log.errorf("TTF.SetFontSize failed. %s", SDL.GetError())
		return false
	}

    log.infof("Using the %s renderer.", SDL.GetRendererName(ctx.renderer))

    return true
}

process_input:: proc() {
    e: SDL.Event

	for SDL.PollEvent(&e) {
		#partial switch(e.type) {
		case .QUIT:
			ctx.should_close = true
		case .KEY_DOWN:
			if (e.key.key == SDL.K_ESCAPE) {
				ctx.should_close = true
			}
		}
	}
}

update:: proc() {
    // time_running  := ctx.frame_start - ctx.app_start
}

draw:: proc() {
    SDL.SetRenderDrawColor(ctx.renderer, 0, 0, 0, 255)
	SDL.RenderClear(ctx.renderer)

	SDL.SetRenderDrawColor(ctx.renderer, 255, 0, 0, 255)
	rect := SDL.FRect{10, 10, 100, 100}
	SDL.RenderFillRect(ctx.renderer, &rect)

	color := SDL.Color { 0xff, 0xff, 0xff, 255 }

	surface := TTF.RenderText_Solid(ctx.font, "Hello World", 0, color)
	texture := SDL.CreateTextureFromSurface(ctx.renderer, surface)

	dstRect := SDL.FRect{10, 120, 400, 32}
	SDL.RenderTexture(ctx.renderer, texture, nil, &dstRect)

	SDL.DestroySurface(surface)
	SDL.DestroyTexture(texture)

	SDL.RenderPresent(ctx.renderer)
}

loop :: proc() {
    ctx.frame_start   = ctx.app_start
	ctx.frame_elapsed = 0.001 // Set frame time to 1ms for the first frame to avoid problems.

	for !ctx.should_close {
		process_input()
		update()
		draw()

		ctx.frame_end     = f64(SDL.GetPerformanceCounter()) / f64(SDL.GetPerformanceFrequency())
		ctx.frame_elapsed = ctx.frame_end - ctx.frame_start
		ctx.frame_start   = ctx.frame_end
	}
}

cleanup :: proc() {
    // defer delete(ctx.textures)
	log.info("Cleanin up.")
	if ctx.font != nil {
		_ = TTF.CloseFont(ctx.font)
	}
	TTF.Quit()
	SDL.DestroyWindow(ctx.window)
	SDL.Quit()
}

main :: proc() {
	context.logger = log.create_console_logger()

    log.info("Staring application.")

	if res := init_sdl(); !res {
		log.errorf("Initialization failed.")
		os.exit(1)
	}

	// if res := init_resources(); !res {
	// 	log.errorf("Couldn't initialize resources.")
	// 	os.exit(1)
	// }
	defer cleanup()

	/*
		Global start time.
	*/
	ctx.app_start = f64(SDL.GetPerformanceCounter()) / f64(SDL.GetPerformanceFrequency())

	loop()

	now     := f64(SDL.GetPerformanceCounter()) / f64(SDL.GetPerformanceFrequency())
	elapsed := now - ctx.app_start
	log.infof("Finished in %v seconds!\n", elapsed)
    log.info("Done")
}
