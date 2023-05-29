
for i in "$@"
do
case $i in
    -b=*|--bamfile=*)
    BAMFILE="${i#*=}"
    ;;
    -l=*|--listfile=*)
    LISTFILE="${i#*=}"
    ;;
    -f=*|--reference=*)
    REFERENCE="${i#*=}"
    ;;
    -o=*|--output_dir=*)
    DIR="${i#*=}"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
done

BAMNAME=$(echo $(basename $BAMFILE) |  cut -d '.' -f 1)

cat $LISTFILE | while read line; 
do
	species=$(echo $line | cut -f 1 -d ',');
	rname=$(echo $line | cut -f 2 -d ',');
	endpos=$(echo $line | cut -f 3 -d ',');
	bamsnap \
		-draw coordinates bamplot coverage base \
		-bam $BAMFILE \
		-out "${DIR}/${species}/${rname}.png"\
		-pos "${rname}:600-${endpos}" \
		-ref $REFERENCE \
		-bamplot coverage read \
		-draw coordinates bamplot -no_target_line;
done