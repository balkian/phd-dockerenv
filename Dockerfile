FROM jupyter/scipy-notebook

MAINTAINER J. Fernando Sánchez <j@sinpapel.es>

RUN conda config --set always_yes yes --set changeps1 no

RUN conda config \
    --add channels ostrokach \ 
    --add channels defaults \
    --add channels conda-forge

RUN conda install -c ostrokach graph-tool=2.22
RUN pip install jupyter_contrib_nbextensions   
RUN pip install jupyter_nbextensions_configurator

RUN jupyter nbextensions_configurator enable --user
RUN jupyter contrib nbextension install --user 

RUN mkdir -p $(jupyter --data-dir)/nbextensions
RUN git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
RUN chmod -R go-w $(jupyter --data-dir)/nbextensions/vim_binding
RUN jupyter nbextension enable --user vim_binding/vim_binding  


