FROM python:3.11.5

COPY ["requirements.txt",  "./"]
RUN pip install -r requirements.txt
ARG UNAME=thesis_eda_user
ARG UID=1000
RUN useradd -m --no-log-init --system --uid ${UID} ${UNAME} -g sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# https://stackoverflow.com/a/63377623
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

USER $UNAME
WORKDIR /home/${UNAME}/
RUN umask 0000
EXPOSE 8999
COPY ["start_notebook.sh",  "/home/setup/"]
CMD [ "bash", "/home/setup/start_notebook.sh"]

