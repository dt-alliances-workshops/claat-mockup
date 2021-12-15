CODELAB_DIR="/Users/rob.jahn/dev/dt-alliances-workshops/claat-mockup/codelabs/markdown/lab6"
SOURCE_DIR="/Users/rob.jahn/dev/dt-alliances-workshops/aws-modernization-dt-orders-content/assets/images"

for imagefile in $(grep png $CODELAB_DIR/README.md | awk -F'/' '{print $2}' | sed 's/.$//')
do
    echo "copying $SOURCE_DIR/$imagefile"
    cp "$SOURCE_DIR/$imagefile" "$CODELAB_DIR/img/$imagefile"
done
