A=../data

B=$1
C=../result

Lambda_tv=(40, 80, 120, 160)
Lambda_rank=(10)

for var in ${B[@]}; do

    DISPPATH=$A/${var}/disp.png

    MISS=50
    MASK=$A/${var}/mask_${MISS}.png

    echo 'inpainting for' $B 'with mask' ${MASK}
    echo 'initialized with' ${A}/${var}/tnnr_${MISS}.png
    for lam in ${Lambda_tv[@]}; do
        for r in ${Lambda_rank[@]}; do
            paramDir=$C/${lam}_$k
            if [ ! -d "$paramDir" ]; then
                `mkdir ${paramDir}`
            fi

            if [ ! -d "${paramDir}/${var}" ]; then
                `mkdir ${paramDir}/${var}`
            fi
            echo 'Lambda_tv = ' ${lam} ', Lambda_rank = ' $r 
            OUTPUT=${paramDir}/${var}/lrtv_${MISS}_${lam}_${r}
            ../build/depthInpainting LRTV ${DISPPATH} ${MASK} ${OUTPUT} ${A}/${var}/tnnr_${MISS}.png ${lam} $r 
        done
    done
done

 
