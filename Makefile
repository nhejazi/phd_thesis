BASE_DIRECTORY=$(CURDIR)

INPUT_DIRECTORY=$(BASE_DIRECTORY)/src
OUTPUT_DIRECTORY=$(BASE_DIRECTORY)/output
FINAL_DIRECTORY=$(BASE_DIRECTORY)/pdf

all: link

$(OUTPUT_DIRECTORY)/approvalpage.pdf: $(INPUT_DIRECTORY)/approvalpage.tex
	cd $(INPUT_DIRECTORY) && \
	latexmk \
	-pdf \
	-output-directory=$(OUTPUT_DIRECTORY) \
	approvalpage

$(OUTPUT_DIRECTORY)/thesis.pdf: $(INPUT_DIRECTORY)/thesis.tex
	cd $(INPUT_DIRECTORY) && \
	latexmk \
	-pdfxe \
	-f \
	-quiet \
	-output-directory=$(OUTPUT_DIRECTORY) \
	thesis

link: $(OUTPUT_DIRECTORY)/thesis.pdf $(OUTPUT_DIRECTORY)/approvalpage.pdf
	mkdir -p $(FINAL_DIRECTORY) && \
	ln -snf $(OUTPUT_DIRECTORY)/thesis.pdf $(FINAL_DIRECTORY)
	ln -snf $(OUTPUT_DIRECTORY)/approvalpage.pdf $(FINAL_DIRECTORY)

web:
	rsync --chmod=go+r $(OUTPUT_DIRECTORY)/thesis.pdf \
		nhejazi@arwen.berkeley.edu:/mirror/data/pub/users/nhejazi/publications/thesis-phd-biostat.pdf

clean:
	rm -rf \
	$(OUTPUT_DIRECTORY) \
	$(FINAL_DIRECTORY)
