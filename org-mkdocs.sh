find . -name "*.org" | while read -r filename; do
    newfilename=$(echo $filename | sed -e "s/\.org/.md/g")
    pandoc -t markdown_github --wrap=preserve -o $newfilename $filename
done
[[ $1 == 'test' ]] && mkdocs serve && exit 0
mkdocs build
