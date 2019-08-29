FROM nvcr.io/nvidia/tensorflow:19.07-py3


# Add requirements.txt before rest of repo for caching
ADD requirements.txt /workspace/Tensorflow-TensorRT/
WORKDIR /workspace/Tensorflow-TensorRT
RUN pip install --upgrade pip setuptools
RUN pip install -r requirements.txt

ADD . /workspace/Tensorflow-TensorRT


RUN jupyter notebook --generate-config
# Allow LAN access for Jupyter Notebooks
RUN sed -i "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '*'/" ~/.jupyter/jupyter_notebook_config.py
# no password
RUN sed -i "s/#c.NotebookApp.token = '<generated>'/c.NotebookApp.token = ''/" ~/.jupyter/jupyter_notebook_config.py
RUN echo >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = ''" >> ~/.jupyter/jupyter_notebook_config.py




