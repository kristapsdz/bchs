LIBS_EXPAT != pkg-config --libs expat 2>/dev/null || echo "-lexpat"
CFLAGS_EXPAT != pkg-config --cflags expat 2>/dev/null || echo ""
CFLAGS += $(CFLAGS_EXPAT)
LDADD += $(LIBS_EXPAT)
