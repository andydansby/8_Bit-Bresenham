cls

del 1output.tap

bas2tap -a10 -sloader loader.bas basloader.tap

pasmo -v --tap bresenham.asm bresenham.tap bresenham.sym

copy /b basloader.tap + bresenham.tap  1output.tap

del bresenham.tap
del basloader.tap


@rem copy "1output.tap" "emulator\"

@rem for Auto Running / testing of your compile
@rem https://fms.komkon.org/Speccy/

rem emulator\Speccy -48 -nosound 1output.tap

