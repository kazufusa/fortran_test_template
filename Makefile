FC = gfortran
TARGET = bin/calculate

OPT = -Wall -pedantic -std=f95 -fbounds-check -O -Wuninitialized -ffpe-trap=invalid,zero,overflow -fbacktrace

OBJDIR = obj
SRCDIR = src
SRCS := $(wildcard $(SRCDIR)/*.f90)
OBJS := $(SRCS:$(SRCDIR)/%.f90=$(OBJDIR)/%.o)

$(OBJDIR)/%.o: $(SRCDIR)/%.f90
	$(COMPILE.f) -J $(OBJDIR) $(OPT) $(OUTPUT_OPTION) $<

$(OBJDIR)/%.mod: $(SRCDIR)/%.f90 $(OBJDIR)/%.o
	@:

$(TARGET): $(OBJS)
	$(LINK.f) $^ $(LOADLIBES) $(OPT) $(LDLIBS) -o $@

clean::
	@rm -f $(TARGET) ./$(OBJDIR)/*.mod ./$(OBJDIR)/*.o

all:: clean $(TARGET)

# dependencies
$(OBJDIR)/main.o: \
	$(OBJDIR)/mod_multiple.mod \

$(OBJDIR)/mod_multiple.o: \
	$(OBJDIR)/mod_add.mod \
