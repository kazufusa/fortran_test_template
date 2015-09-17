FC = gfortran
TARGET = bin/calculate

OPT = -Wall -pedantic -std=f95 -fbounds-check -O -Wuninitialized -ffpe-trap=invalid,zero,overflow -fbacktrace

OBJDIR = obj
SRCDIR = src
TESTBINDIR = tmp
TESTSRCS := $(wildcard $(SRCDIR)/*_test.f90)
TESTS := $(TESTSRCS:$(SRCDIR)/%.f90=%)
SRCS := $(filter-out $(TESTSRCS), $(wildcard $(SRCDIR)/*.f90))
OBJS := $(SRCS:$(SRCDIR)/%.f90=$(OBJDIR)/%.o)

NO="\033[0m"
GREEN="\033[32m"
BRED="\033[31;01m"
BYELLOW="\033[33;01m"

$(OBJDIR)/%.o: $(SRCDIR)/%.f90
	$(COMPILE.f) -J $(OBJDIR) $(OPT) $(OUTPUT_OPTION) $<

$(OBJDIR)/%.mod: $(SRCDIR)/%.f90 $(OBJDIR)/%.o
	@:

$(TARGET): $(OBJS)
	$(LINK.f) $^ $(LOADLIBES) $(OPT) $(LDLIBS) -o $@

clean::
	@rm -f $(TARGET) ./$(OBJDIR)/*.mod ./$(OBJDIR)/*.o $(TESTBINDIR)/*_test

all:: clean $(TARGET)

$(TESTBINDIR)/%:
	$(LINK.f) $^ $(LOADLIBES) $(OPT) $(LDLIBS) -o $@

$(TESTS):
	@make -s $(TESTBINDIR)/$@
	@$(TESTBINDIR)/$@ && echo $(GREEN)$@ SUCCEEDED$(NO) || echo $(BRED)$@ FAILED$(NO);

test::
	@for test in $(TESTS) ; do $(MAKE) -s $$test; done

# dependencies
$(OBJDIR)/main.o: \
	$(OBJDIR)/mod_multiple.mod \

$(OBJDIR)/mod_multiple.o: \
	$(OBJDIR)/mod_add.mod \

$(TESTBINDIR)/mod_add_test: \
	$(OBJDIR)/mod_add.o \
	$(OBJDIR)/mod_add_test.o \

$(TESTBINDIR)/mod_multiple_test: \
	$(OBJDIR)/mod_multiple.o \
	$(OBJDIR)/mod_multiple_test.o \
	$(OBJDIR)/mod_add.o \
