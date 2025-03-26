FROM debian:bookworm-slim as build-env

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
  # install tools
  && apt install -y --no-install-recommends git curl ca-certificates \
  # install python dependencies
  && apt install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev libsqlite3-dev \
  # make image smaller
  && rm -rf "/var/lib/apt/lists/*" \
  && rm -rf /var/cache/apt/archives

RUN useradd -m pythonuser

ENV HOME /home/pythonuser
WORKDIR $HOME
USER pythonuser

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV PATH $HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH

ENV PYTHON_VERSION 3.13.2
RUN pyenv install --list | grep -A7 $PYTHON_VERSION \
  && pyenv install $PYTHON_VERSION \
  && pyenv global $PYTHON_VERSION \
  && pyenv rehash \
  && python --version

WORKDIR $HOME/app

RUN pip install Flask \
  && pip freeze
  #&& pip freeze > requirements.txt \
  #&& cat requirements.txt

# RUN pip install -r requirements.txt

COPY main.py .

EXPOSE 5000

CMD [ "python3", "-m" , "flask", "--app", "main", "run", "--host=0.0.0.0"]

HEALTHCHECK CMD curl -f "http://localhost:5000" || exit 1
