FROM ufoym/deepo:all-jupyter-py36-cu90

MAINTAINER Sintifo

ENV TEMP_MRCNN_DIR /tmp/mrcnn
ENV TEMP_COCO_DIR /tmp/coco
ENV MRCNN_DIR /mrcnn

## Update PIP
RUN pip install --upgrade pip

RUN pip install scikit-image wandb

RUN git clone https://github.com/matterport/Mask_RCNN.git $TEMP_MRCNN_DIR

RUN git clone https://github.com/waleedka/coco.git $TEMP_COCO_DIR


RUN cd $TEMP_COCO_DIR/PythonAPI && \
    sed -i "s/\bpython\b/python3/g" Makefile && \
    make

RUN mkdir -p $MRCNN_DIR/coco

RUN wget -O $MRCNN_DIR/coco/mask_rcnn_coco.h5 https://github.com/matterport/Mask_RCNN/releases/download/v2.0/mask_rcnn_coco.h5

WORKDIR "/root"

CMD ["/bin/bash"]
