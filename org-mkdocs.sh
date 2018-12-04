find . -name "*.org" | while read -r filename; do
    newfilename=$(echo $filename | sed -e "s/\.org/.md/g")
    pandoc -t markdown_github --wrap=preserve -o $newfilename $filename
done
mkdocs build
aws s3 sync site/ s3://docs.tgdnt.com --acl public-read --delete
aws configure set preview.cloudfront true
aws cloudfront create-invalidation --distribution-id E3G46GREEWAVOG --paths '/*'
