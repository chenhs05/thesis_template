LATEX=pdflatex
LATEXOPT=-file-line-error -synctex=1
SHELLESCAPE=-shell-escape
NONSTOP=-interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf -f
CONTINUOUS=-pvc

MAIN=dissertation
SOURCES=$(MAIN).tex */*.tex
FIGURES=*/figures/* */drawings/*
BIBLIOGRAPHY=references.bib

all: $(MAIN).pdf

$(MAIN).pdf : $(MAIN).tex $(SOURCES) $(FIGURES) $(BIBLIOGRAPHY)
	$(LATEXMK) $(LATEXMKOPT) $(LATEXOPT) $(NONSTOP) $(MAIN).tex

force :
	$(LATEXMK) $(LATEXMKOPT) $(LATEXOPT) $(NONSTOP) $(MAIN).tex

watching :
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) $(LATEXOPT) $(NONSTOP) $(MAIN).tex

debug :
	$(LATEXMK) -pdf -f $(LATEXOPT) $(NONSTOP) -halt-on-error $(MAIN).tex

clean :
	@echo "Cleaning up"
	$(LATEXMK) -C $(MAIN)

clear : clean

# target for separating pages
separate_page: separated_pages.pdf

separated_pages.pdf : separated_pages.tex setup/preamble.tex
	$(LATEXMK) $(LATEXMKOPT) $(LATEXOPT) $(NONSTOP) separated_pages.tex

.PHONY: clean clear force all watching debug separate_page
