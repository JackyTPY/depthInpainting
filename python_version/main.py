import argparse
import cv2
import numpy as np
from tnnr import TNNR
from lrtv import LRTV

def parse_args():
    parser = argparse.ArgumentParser(description='depthInpainting')

    # path
    parser.add_argument('--method', default='LRTV', type=str, choices=['LRTV', 'LRL0', 'LRL0PHI'])
    parser.add_argument('--depthImage', default='', type=str)
    parser.add_argument('--mask', default='', type=str)
    parser.add_argument('--outputPath', default='', type=str)
    parser.add_argument('--initImage', default='', type=str)
    parser.add_argument('--K', default=3, type=int)
    parser.add_argument('--lambda_L0', default=30, type=int)
    parser.add_argument('--MaxIterCnt', default=30, type=int)

    args = parser.parse_args()
    return args

def main(args):
    if args.method == 'LRTV':
        disparityMissing = cv2.imread(args.depthImage, flags=cv2.IMREAD_GRAYSCALE)
        mask = cv2.imread(args.mask, cv2.IMREAD_GRAYSCALE)
        disparityMissing = disparityMissing * (mask / 255)
        denoised = cv2.imread(args.initImage, cv2.IMREAD_GRAYSCALE)
        # denoised = TNNR(disparityMissing, mask, 9, 9, 1e-2)
        lrtv = LRTV(disparityMissing, mask, denoised, 1.2, 0.1, 40, 10)
        result = lrtv.compute()
        M = lrtv.getM()
        Y = lrtv.getY()
        output = result.astype(np.uint8)
        cv2.imwrite('result.png', output)
        cv2.imwrite('M.png', M)
        cv2.imwrite('Y.png', Y)
        
    elif args.method == 'LRL0':
        pass
    elif args.method == 'LRL0PHI':
        pass



if __name__ == '__main__':
    args = parse_args()
    print(args)
    main(args)
