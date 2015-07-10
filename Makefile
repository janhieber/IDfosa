.PHONY: pdf dvi clean view backup

TARGET = fosa
OUTFILE = IDfosa
BACKUP_DIR = /home/$(shell whoami)/Dokumente/latex
PROJECT = $(shell basename $(shell pwd))

LATEXMK = latexmk
LATEXMK_OPTIONS = -bibtex -use-make
# For use with ppdflatex, direct pdf generation
LATEXMK_PDF_OPTIONS = -pdf -pdflatex="ppdflatex -shell-escape -interaction=batchmode"
# For use with normal pdflatex, direct pdf generation
# LATEXMK_PDF_OPTIONS = -pdf -pdflatex="pdflatex -shell-escape -interaction=batchmode"
# For use with pplatex, dvi to pdf generation
# LATEXMK_PDF_OPTIONS = -pdfdvi -latex="pplatex -shell-escape"
# For use with normal latex, dvi to pdf generation
# LATEXMK_PDF_OPTIONS = -pdfdvi -latex="latex -shell-escape"
VIEWER_PDF = evince

RM = rm -f

all: pdf

pdf: 
	$(LATEXMK) $(LATEXMK_OPTIONS) $(LATEXMK_PDF_OPTIONS) $(TARGET).tex
	cp $(TARGET).pdf $(OUTFILE).pdf

clean:
	$(LATEXMK) -CA
	$(RM) $(TARGET).bbl
	$(RM) $(TARGET).thm
	$(RM) *.vrb *.nav $(TARGET)-blx.bib *.xml *.snm *.fls *.gls *.ist *.glg *.glo

view: pdf
	$(VIEWER_PDF) $(TARGET).pdf &

backup:
	rsync -av --delete --progress . $(BACKUP_DIR)/$(PROJECT)
