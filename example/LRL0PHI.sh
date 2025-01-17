A=../data

B=$1
C=../result

Lambda=(100)
K=(3 5)
max=30

for var in ${B[@]}; do

    DISPPATH=$A/${var}/disp.png

    MISS=50
    MASK=$A/${var}/mask_${MISS}.png

    echo 'inpainting for' $B 'with mask' ${MASK}
    echo 'initialized with' ${A}/${var}/tnnr_${MISS}.png
    for lam in ${Lambda[@]}; do
        for k in ${K[@]}; do
            paramDir=$C/${lam}_$k
            if [ ! -d "$paramDir" ]; then
                `mkdir ${paramDir}`
            fi

            if [ ! -d "${paramDir}/${var}" ]; then
                `mkdir ${paramDir}/${var}`
            fi
            echo 'lambda_l0 = ' ${lam} ', K = ' $k ', maxCnt = ' ${max}
            OUTPUT=${paramDir}/${var}/lrl0phi_${MISS}_
            ../build/depthInpainting LRL0PHI ${DISPPATH} ${MASK} ${OUTPUT} ${A}/${var}/tnnr_${MISS}.png $k ${lam\
} ${max} ${paramDir}/${var}

        done
    done
done

 
