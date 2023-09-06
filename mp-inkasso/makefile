TEX = pandoc
FLAGS = --pdf-engine=xelatex

# Use the values of src, template, and output passed as arguments
$(output) : $(src)
	@echo "Generating PDF using Makefile..."
	@echo "Source YAML: $(src)"
	@echo "Template: $(template)"
	@echo "Output PDF: $(output)"
	$(TEX) $(src) -o $@ --template=$(template) $(FLAGS)
	@echo "PDF generated successfully."

.PHONY: clean
clean :
	rm -f /app/data/output/*.pdf
	@echo "Cleaned up PDF files in /app/data/output directory."

.PHONY: cleanall
cleanall : clean
	rm -rf /app/data/output/*
	@echo "Cleaned up ALL files and temporary files in /app/data/output directory."

