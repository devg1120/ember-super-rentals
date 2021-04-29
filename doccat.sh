

usage_exit() {
#        echo "Usage: $0 [-a] [-d dir] item ..." 1>&2
        echo "Usage: $0 [-f]  item ..." 1>&2
        exit 1
}

FILE_BODY=1
while getopts fah OPT
do
    case $OPT in
        f)  FILE_BODY=0
            ;;
#        d)  VALUE_D=$OPTARG
#            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done

shift $((OPTIND - 1))

#----------------------------------------------------------
print_dirname(){
  NAME=$1
  if [ $FILE_BODY -eq 1 ]; then
    echo "---"
    echo "<a id=\""$NAME"\"></a>"
    echo "### **"$NAME"**"
  else
#   echo "- **"$NAME"**"
   echo "- [**"$NAME"**](#"$NAME")"
  fi
}
print_filename(){
  NAME=$1
  if [ $FILE_BODY -eq 1 ]; then
    echo "---"
    echo "<a id=\""$NAME"\"></a>" 
    echo "### " $NAME  "        [↑](#_pagetop_)" 
  else
#   echo "  - "$NAME
   FILENAME=$(basename $NAME)
   #echo "- ["$NAME"](#"$NAME")"
   echo "     - ["$FILENAME"](#"$NAME")"
  fi
}
print_title(){
  NAME=$1
  echo "<a id=\"_pagetop_\"></a>"
  echo "- " $NAME
}

find_subdir() {
  #echo "subdir--" $1
  DIR=$1

  #----------------------------------  file operation
  for subdir in ${DIR}/*; do
#    if [ -d "$subdir" ]; then
#      if [ $subdir = "./node_modules" ]; then
#         continue
#      fi
#      if [ $subdir = "./e2e" ]; then
#         continue
#      fi
#
#      echo "" ["$subdir" "]"
#      find_subdir $subdir
#    fi
    if [ -f "$subdir" ]; then
      if [[ $subdir =~ .*\.json$ ]]; then  
         continue
      fi
      if [[ $subdir =~ .*\.tgz$ ]]; then  
         continue
      fi
      if [[ $subdir =~ .*\.tar$ ]]; then  
         continue
      fi
      if [[ $subdir =~ .*\.zip$ ]]; then  
         continue
      fi
      if [[ $subdir =~ .*\.ico$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.png$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.cat$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.md$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.txt$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.sh$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.jpeg$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.jpg$ ]]; then
         continue
      fi
      if [ $subdir = "./package-lock.json" ]; then
         continue
      fi
      if [ $subdir = "./testem.js" ]; then
         continue
      fi
      if [ $subdir = "./yarn.lock" ]; then
         continue
      fi
      #echo " " "$subdir" 
      print_filename $subdir 
      if [ $FILE_BODY -eq 1 ]; then
        FILENAME=$(basename $subdir)
        EXTENTION="${FILENAME##*.}"
        echo "\`\`\`"$EXTENTION
        cat $subdir
        echo ""
        echo "\`\`\`"
      fi
    fi
  done

  #----------------------------------  directory operation
  for subdir in ${DIR}/*; do
    if [ -d "$subdir" ]; then
      if [ $subdir = "./node_modules" ]; then
         continue
      fi
      if [ $subdir = "./dist" ]; then
         continue
      fi
      if [ $subdir = "./vendor" ]; then
         continue
      fi
      if [ $subdir = "./tests" ]; then
         continue
      fi
      if [ $subdir = "./public" ]; then
         continue
      fi
      #echo "" ["$subdir" "]"
      print_dirname  $subdir
      find_subdir $subdir
    fi
#    if [ -f "$subdir" ]; then
#      if [[ $subdir =~ .*\.zip$ ]]; then
#         continue
#      fi
#     if [[ $subdir =~ .*\.ico$ ]]; then
#         continue
#      fi
#      if [ $subdir = "./package-lock.json" ]; then
#         continue
#      fi
#      #echo " " "$subdir"
#      print_filename $subdir
#      if [ $FILE_BODY -eq 1 ]; then
#        cat $subdir
#      fi
#    fi
  done
}


TPATH='.'
FULL_PATH=${PWD}

NAME=$(basename $FULL_PATH)

print_title $NAME
TITLE=$NAME

if [ $FILE_BODY -eq 0 ]; then
    find_subdir $TPATH
else
    FILE_BODY=0
    find_subdir $TPATH
    FILE_BODY=1
    find_subdir $TPATH $TITLE

fi
