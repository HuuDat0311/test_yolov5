#!/bin/bash
cd /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0

# wget https://github.com/ultralytics/yolov5/releases/download/v6.0/yolov5m6.pt -P /home/aitraining/workspace/anhth57/Vehicle_tensorRT_K8s/module/triton-yolov5/yolov5 -O /home/aitraining/workspace/anhth57/Vehicle_tensorRT_K8s/module/triton-yolov5/yolov5/yolov5m6.pt

cp tensorrtx/yolov5/gen_wts.py yolov5

cd /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/yolov5

# pip install -r requirements.txt

python gen_wts.py -w yolov5s_512.pt -o yolov5s_512.wts

cd /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5

rm -rf /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5/build

mkdir -p /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5/build

cd /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5/build
# update CLASS_NUM in yololayer.h if your model is trained on custom dataset
cp /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/yolov5/yolov5s_512.wts /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5/build
cmake ..
make -j8

/home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5/build/yolov5 -s /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5/build/yolov5s_512.wts /home/aitraining/workspace/datnh14/convert_tensorrtx_yolov5_6.0/tensorrtx/yolov5/build/yolov5s_512.engine s
exec "$@"
