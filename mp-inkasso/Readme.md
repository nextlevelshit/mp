Open virtual environment for installing python packages
```shell
. .venv/bin/activate
```

Install packages
```shell
pip install prometheus_client
```

Move installed packages to `requirements.txt`
```shell
pip freeze > requirements.txt
```

---

```shell
pandoc details.md --template=templates/invoice-scrlttr2.tex --pdf-engine=pdflatex -o output.pdf
```
