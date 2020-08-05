# Compiler specification for the case where the compilation host
# and target are the same
#
# See specific targets as examples of how to modify thei.
#
TCC=$(CC)
TLD=$(LD)
LIBDIRS=-L$(dir $(shell $(TCC) -print-libgcc-file-name))

TOBJDUMP=objdump
TOBJCOPY=objcopy
